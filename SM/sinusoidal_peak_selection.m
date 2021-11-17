function [amp,freq,ph] = sinusoidal_peak_selection(fft_frame,amp,freq,ph,indmaxnpeak,framelen,nfft,fs,nframe,nchannel,...
    maxnpeak,shapethres,rangethres,relthres,absthres,winflag,normflag,zphflag,npeakflag)
%SINUSOIDAL_PEAK_SELECTION Selection of spectral peaks as sinusoids.
%   [AMP,FREQ,PH] = SINUSOIDAL_PEAK_SELECTION(FFTFR,A,F,P,IND,M,N,Fs,NFRAME,NCHANNEL,MAXNPEAK,
%   SHAPETHRES,RANGETHRES,RELTHRES,ABSTHRES,WINFLAG,NORMFLAG,ZPHFLAG,NPEAKFLAG)
%   returns the amplitudes AMP, frequencies FREQ, and phases PH of the spectral
%   peaks selected as sinusoids according to spectral shape, amplitude range of
%   peaks, relative amplitudes of peaks within each frame, and absolute amplitude
%   of peaks.
%
%   The FFT frames FFTFR and the estimations of the amplitudes A,
%   frequencies F, and phases P of each spectral peak are used to
%   compute the measures.
%
%   The measure of spectral shape compares the shape
%   of each peak with the theoretical DFT of the window determined by
%   WINDOWFLAG modulated by a sinusoid with amplitude A, frequency F, and
%   phase P around NBINSPAN bins of F. The normalized dot product between
%   the peak in FFTFR and the theoretical peak is the final measure.
%
%   The measure of spectral range uses the average of the difference in
%   amplitude between the spectral peak and the troughs to its left- and
%   right-hand sides.
%
%   The relative amplitude of each peak is a measure of its amplitude in dB
%   using the amplitude of the maximum peak in that frame as reference.
%
%   The absolute amplitude of each peak is a measure of its amplitude in
%   dB using 0dB as reference.
%
%   The peaks are selected using the thresholds:
%
%   SHAPETHRES spectral shape threshold (normalized)
%   RANGETHRES spectral range threshold (dB power)
%   RELTHRES relative amplitude threshold (dB power)
%   ABSTHRES absolute amplitude threshold (dB power)
%
%   See also PEAKSEL, PEAK_SHAPE, PEAK_RANGE, PEAK_RELDB

% 2021 M Caetano SMT
% $Id 2021 M Caetano SM 0.8.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(10,19);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 10
    
    maxnpeak = inf(1);
    shapethres = 0;
    rangethres = -inf(1);
    relthres = -inf(1);
    absthres = -inf(1);
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 11
    
    shapethres = 0;
    rangethres = -inf(1);
    relthres = -inf(1);
    absthres = -inf(1);
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 12
    
    rangethres = -inf(1);
    relthres = -inf(1);
    absthres = -inf(1);
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin ==13
    
    relthres = -inf(1);
    absthres = -inf(1);
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 14
    
    absthres = -inf(1);
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 15
    
    winflag = 3;
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 16
    
    normflag = true;
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 17
    
    zphflag = true;
    npeakflag = true;
    
elseif nargin == 18
    
    npeakflag = true;
    
end

validateattributes(fft_frame,{'numeric'},{'nonempty','finite'},mfilename,'FFRFR',1)
validateattributes(amp,{'numeric'},{'nonempty','real'},mfilename,'AMP',2)
validateattributes(freq,{'numeric'},{'nonempty','real'},mfilename,'FREQ',3)
validateattributes(ph,{'numeric'},{'nonempty','real'},mfilename,'PH',4)
validateattributes(indmaxnpeak,{'numeric'},{'nonempty','integer','real','positive','increasing'},mfilename,'INDMAXNPEAK',5)
validateattributes(framelen,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'FRAMELEN',6)
validateattributes(nfft,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'NFFT',7)
validateattributes(fs,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'Fs',8)
validateattributes(nframe,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NFRAME',9)
validateattributes(nchannel,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NCHANNEL',10)
validateattributes(maxnpeak,{'numeric'},{'nonempty','scalar','real','positive'},mfilename,'MAXNPEAK',11)
validateattributes(shapethres,{'numeric'},{'nonempty','scalar','real','>=',0,'<=',1},mfilename,'SHAPETHRES',12)
validateattributes(rangethres,{'numeric'},{'nonempty','scalar','real'},mfilename,'RANGETHRES',13)
validateattributes(relthres,{'numeric'},{'nonempty','scalar','real'},mfilename,'RELTHRES',14)
validateattributes(absthres,{'numeric'},{'nonempty','scalar','real'},mfilename,'ABSTHRES',15)
validateattributes(winflag,{'numeric'},{'scalar','integer','nonempty','>=',1,'<=',8},mfilename,'WINFLAG',16)
validateattributes(normflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'NORMFLAG',17)
validateattributes(zphflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'ZPHFLAG',18)
validateattributes(npeakflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'NPEAKFLAG',19)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Range of frequency bins around peak
nbinspan = 6;

% Flag to specify frequency sign of signal (only applies to complex signals)
posfreqflag = true;

% Flag to generate the DFT of a real signal
realsigflag = true;

% Flag to normalize the dot product
normdprodflag = true;

[amp,freq,ph] = tools.psel.peaksel(fft_frame,amp,freq,ph,indmaxnpeak,framelen,nfft,fs,nframe,nchannel,...
    maxnpeak,nbinspan,shapethres,rangethres,relthres,absthres,winflag,normflag,zphflag,posfreqflag,...
    realsigflag,npeakflag,normdprodflag);

end
