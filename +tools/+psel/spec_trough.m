function [ampTroughLeft,ampTroughRight,freqTroughLeft,freqTroughRight] = spec_trough(fft_frame,indmaxnpeak,nfft,fs,...
    nframe,nchannel,npeakflag)
%SPEC_TROUGH Amplitudes and frequencies of spectral troughs to the right and to the left of spectral peaks.
%   [AL,AR,FL,FR] = SPEC_TROUGH(FFTFR,INDMAXNPEAK,NFFT,Fs,NFRAME,NCHANNEL,NPEAKFLAG)
%
%   See also

% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.8.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(7,7);

% Check number of output arguments
nargoutchk(0,4);

% TODO: VALIDATE ARGUMENTS

validateattributes(fft_frame,{'numeric'},{'nonempty','finite'},mfilename,'FFRFR',1)
validateattributes(indmaxnpeak,{'numeric'},{'nonempty','finite','real','integer','increasing'},mfilename,'INDMAXNPEAK',2)
validateattributes(nfft,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'NFFT',3)
validateattributes(fs,{'numeric'},{'scalar','nonempty','integer','real','positive'},mfilename,'Fs',4)
validateattributes(nframe,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NFRAME',5)
validateattributes(nchannel,{'numeric'},{'scalar','integer','nonempty','real','positive'},mfilename,'NCHANNEL',6)
validateattributes(npeakflag,{'numeric','logical'},{'scalar','nonempty','binary'},mfilename,'NPEAKFLAG',7)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nrgflag = true;
posmagspec = tools.fft2.fft2pos_mag_spec(fft_frame,nfft,nrgflag);
bool_trough = tools.psel.istrough(posmagspec);
bool_peak = tools.sin.ispeak(posmagspec);

% Frequency bins
[freqbin,nbin] = tools.spec.mkfreq(nfft,fs,nframe,nchannel,'pos');

% Initialize trough
freq_trough_left = nan(nbin,nframe,nchannel);
amp_trough_left = nan(nbin,nframe,nchannel);
freq_trough_right = nan(nbin,nframe,nchannel);
amp_trough_right = nan(nbin,nframe,nchannel);

% Linear indices of troughs
ind_trough = find(bool_trough);

% Linear indices of first/last trough in each frame (across channels)
[ind_first_trough,ind_last_trough] = tools.algo.findIndFirstLastTrueVal(bool_trough,nbin,nframe,nchannel);

% Linear indices of troughs to the left of peaks
ind_trough_left = setdiff(ind_trough,ind_last_trough);

% Linear indices of troughs to the right of peaks
ind_trough_right = setdiff(ind_trough,ind_first_trough);

% Assign AMP/FREQ of trough left to the same positions as peaks
amp_trough_left(bool_peak) = posmagspec(ind_trough_left);
freq_trough_left(bool_peak) = freqbin(ind_trough_left);

% Assign AMP/FREQ of trough right to the same positions as peaks
amp_trough_right(bool_peak) = posmagspec(ind_trough_right);
freq_trough_right(bool_peak) = freqbin(ind_trough_right);

if npeakflag
    
    % Return MAXNPEAK x NFRAME x NCHANNEL
    ampTroughLeft = amp_trough_left(indmaxnpeak);
    ampTroughRight = amp_trough_right(indmaxnpeak);
    freqTroughLeft = freq_trough_left(indmaxnpeak);
    freqTroughRight = freq_trough_right(indmaxnpeak);
    
else
    
    % Initialize with size NBIN x NFRAME x NCHANNEL
    ampTroughLeft = nan(nbin,nframe,nchannel);
    freqTroughLeft = nan(nbin,nframe,nchannel);
    ampTroughRight = nan(nbin,nframe,nchannel);
    freqTroughRight = nan(nbin,nframe,nchannel);
    
    % Assign only to MAXNPEAK positions per frame
    ampTroughLeft(indmaxnpeak) = amp_trough_left(indmaxnpeak);
    ampTroughRight(indmaxnpeak) = amp_trough_right(indmaxnpeak);
    freqTroughLeft(indmaxnpeak) = freq_trough_left(indmaxnpeak);
    freqTroughRight(indmaxnpeak) = freq_trough_right(indmaxnpeak);
    
end

end
