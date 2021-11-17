function measure_range = peak_range(fft_frame,amp,indmaxnpeak,nfft,fs,nframe,nchannel,npeakflag)
%PEAKRANGE Spectral peak range.
%   Detailed explanation goes here
%
%   See also PEAK_SHAPE, SPEC_PEAK_SHAPE

% 2021 M Caetano SMT% $Id 2021 M Caetano SM 0.8.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(8,8);

% Check number of output arguments
nargoutchk(0,1);

validateattributes(fft_frame,{'numeric'},{'nonempty','finite'},mfilename,'FFRFR',1)
validateattributes(amp,{'numeric'},{'nonempty','real'},mfilename,'AMP',2)
validateattributes(indmaxnpeak,{'numeric'},{'nonempty','integer','real','positive','increasing'},mfilename,'INDMAXNPEAK',3)
validateattributes(nfft,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'NFFT',4)
validateattributes(fs,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'Fs',5)
validateattributes(nframe,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NFRAME',6)
validateattributes(nchannel,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NCHANNEL',7)
validateattributes(npeakflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'NPEAKFLAG',8)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validateattributes(npeakflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'NPEAKFLAG',8)

[ampLeft,ampRight,freqLeft,freqRight] = tools.psel.spec_trough(fft_frame,indmaxnpeak,nfft,fs,nframe,nchannel,npeakflag);

measure_range = tools.psel.rangediff(amp,ampLeft,ampRight);

end
