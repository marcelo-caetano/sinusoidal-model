function posmagspec = fft2positive_magnitude_spectrum(fft_frame,nfft,nrgflag)
%FFT2POSITIVE_MAGNITUDE_SPECTRUM From FFT to positive magnitude spectrum.
%   PMS = FFT2POSITIVE_MAGNITUDE_SPECTRUM(FFT) returns the magnitude
%   spectrum of the positive half of the complex FFT vector or matrix. FFT
%   can be either an NFFT x 1 colum vector or an NFFT x NFRAME matrix with
%   NFRAME frames of the STFT. PMS is NFFT/2+1 x NFRAME, where NFFT/2+1 is
%   the number of _nonnegative_ frequency bins of the FFT.
%
%   PMS = FFT2POSITIVE_MAGNITUDE_SPECTRUM(FFT,NFFT) uses NFFT for the size
%   of the FFT.
%
%   PMS = FFT2POSITIVE_MAGNITUDE_SPECTRUM(FFT,NFFT,NRGFLAG) uses the
%   logical flag NRGFLAG to specify if PMS should also contain the spectral
%   energy of the negative frequency bins. NRGFLAG = TRUE adds the energy
%   of the negative frequency bins to the log magnitude spectrum and
%   NRGFLAG = FALSE does not. The default is NRGFLAG = FALSE for the
%   previous syntaxes.
%
%   See also FFT2MAGNITUDE_SPECTRUM, FFT2PHASE_SPECTRUM,
%   FFT2POSITIVE_PHASE_SPECTRUM, FFT2LOG_MAGNITUDE_SPECTRUM

% 2020 M Caetano SMT 0.1.2
% 2021 M Caetano SMT% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

% Defaults
if nargin == 1
    
    % Assume FFT_FRAME is NFFT X NFRAME
    [nfft,~] = size(fft_frame);
    
    % Do not compensate for the energy of negative frequencies
    nrgflag = false;
    
elseif nargin == 2
    
    % Do not compensate for the energy of negative frequencies
    nrgflag = false;
    
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

% Magnitude spectrum
magspec = fft2magnitude_spectrum(fft_frame);

% Positive magnitude spectrum
posmagspec = full_spectrum2positive_spectrum(magspec,nfft,nrgflag);

end
