function magspec = fft2magnitude_spectrum(fft_frame)
%FFT2MAGNITUDE_SPECTRUM From FFT to magnitude spectrum.
%   M = FFT2MAGNITUDE_SPECTRUM(FFT) returns the magnitude spectrum M of the
%   complex FFT vector or matrix. FFT can be either a NFFT x 1 colum vector
%   or an NFFT x NFRAME matrix with NFRAME frames of the STFT.
%
%   See also FFT2PHASE_SPECTRUM, FFT2POSITIVE_MAGNITUDE_SPECTRUM,
%   FFT2POSITIVE_PHASE_SPECTRUM, FFT2LOG_MAGNITUDE_SPECTRUM,
%   FFT2UNWRAPPED_PHASE_SPECTRUM

% 2021 M Caetano SMT% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


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

% Magnitude of the complex FFT
magspec = abs(fft_frame);

end
