function phspec = fft2phase_spectrum(fft_frame)
%FFT2PHASE_SPECTRUM From FFT to phase spectrum.
%   P = FFT2PHASE_SPECTRUM(FFT) returns the phase spectrum P of the complex
%   FFT vector or matrix. FFT can be either a NFFT x 1 colum vector or an
%   NFFT x NFRAME matrix with NFRAME frames of the STFT.
%
%   See also FFT2MAGNITUDE_SPECTRUM, FFT2POSITIVE_MAGNITUDE_SPECTRUM,
%   FFT2POSITIVE_PHASE_SPECTRUM, FFT2LOG_MAGNITUDE_SPECTRUM,
%   FFT2UNWRAPPED_PHASE_SPECTRUM

% 2020 M Caetano SMT 0.1.1
% 2021 M Caetano SMT (Revised)% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


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

% Phase of the complex FFT
phspec = angle(fft_frame);

end
