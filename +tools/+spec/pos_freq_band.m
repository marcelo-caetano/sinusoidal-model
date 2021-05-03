function nbin = pos_freq_band(nfft)
%POS_FREQ_BAND Positive frequency band.
%   PB = POS_FREQ_BAND(NFFT) returns the length of the positive frequency band in
%   bins of a spectrum obtained with an FFT of size NFFT. PH = NFFT/2+1, so
%   PB includes the zero frequency and Nyquist frequency bins.
%
%   See also NEG_FREQ_BAND, NYQBIN, FFTFLIP, IFFTFLIP, LEFTWIN, RIGHTWIN

% 2020 MCaetano SMT 0.1.1
% $Id 2021 M Caetano SM 0.6.0-alpha.1 $Id


%TODO: CHECK INPUT ARGUMENTS (integer and power of 2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Length of positive frequency band
nbin = tools.spec.nyq_freq(nfft,'ind');

end
