function posphspec = fft2positive_phase_spectrum(fft_frame,nfft)
%FFT2POSITIVE_PHASE_SPECTRUM From FFT to positive phase spectrum.
%   PPS = FFT2POSITIVE_PHASE_SPECTRUM(FFT) returns the phase spectrum of
%   the positive half of the complex FFT vector or matrix. FFT can be
%   either an NFFT x 1 colum vector or an NFFT x NFRAME matrix with NFRAME
%   frames of the STFT. PPS is NFFT/2+1 x NFRAME, where NFFT/2+1 is the
%   number of _nonnegative_ frequency bins of the FFT.
%
%   PPS = FFT2POSITIVE_PHASE_SPECTRUM(FFT,NFFT) uses NFFT for the size of
%   the FFT.
%
%   See also FFT2POSITIVE_MAGNITUDE_SPECTRUM, FFT2MAGNITUDE_SPECTRUM,
%   FFT2PHASE_SPECTRUM, FFT2LOG_MAGNITUDE_SPECTRUM,
%   FFT2UNWRAPPED_PHASE_SPECTRUM

% 2021 M Caetano SMT% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Defaults
if nargin == 1
    
    % Assume FFT_FRAME is NFFT X NFRAME
    [nfft,~] = size(fft_frame);
    
end

% Check that NFFT == SIZE(FFT_FRAME,1)
[nrow,ncol] = size(fft_frame);

if nfft ~= nrow
    
    warning('SMT:FFT2POSITIVE_MAGNITUDE_SPECTRUM:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of FFT.\n'...
        'FFT must be NFFT x NFRAME.\nSize of FFT entered was %d x %d.\n'...
        'NFFT entered was %d.\nUsing NFFT = %d'],nrow,ncol,nfft,nrow);
    
    nfft = nrow;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Phase of the FFT
phspec = fft2phase_spectrum(fft_frame);

% Positive half of phase spectrum
posphspec = full_spectrum2positive_spectrum(phspec,nfft);

end
