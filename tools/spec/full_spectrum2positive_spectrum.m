function posspec = full_spectrum2positive_spectrum(fft_frame,nfft,nrgflag)
%FULL_SPECTRUM2POSITIVE_SPECTRUM Full spectrum to positive spectrum.
%   PS = FULL_SPECTRUM2POSITIVE_SPECTRUM(FFT) returns the _nonnegative_
%   frequency half of the complex FFT vector or matrix. FFT can be either a
%   NFFT x 1 colum vector or an NFFT x NFRAME matrix with NFRAME frames of
%   the STFT.
%
%   PS = FULL_SPECTRUM2POSITIVE_SPECTRUM(FFT,NFFT) uses NFFT for the size
%   of the FFT.
%
%   PS = FULL_SPECTRUM2POSITIVE_SPECTRUM(F,NFFT,NRGFLAG) uses the logical
%   flag NRGFLAG to specify if PS should also contain the spectral energy
%   of the negative frequency bins. NRGFLAG = TRUE adds the energy of the
%   negative frequency bins to the positive spectrum and NRGFLAG = FALSE
%   does not. The default is NRGFLAG = FALSE for the previous syntaxes.
%
%   See also POSITIVE_SPECTRUM2FULL_SPECTRUM,
%   FFT2POSITIVE_MAGNITUDE_SPECTRUM, FFT2POSITIVE_PHASE_SPECTRUM

% 2020 M Caetano SMT 0.1.2
% 2021 M Caetano SMT (Revised)% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,3);

% Check number of output arguments
nargoutchk(0,1);

% Defaults
if nargin == 1
    
    % Assume FFT_FRAME is NFFT X NFRAME
    [nfft,~] = size(fft_frame);
    
    nrgflag = false;
    
elseif nargin == 2
    
    % Do not compensate for the energy of negative frequencies
    nrgflag = false;
    
end

% Check that NFFT == SIZE(FFT_FRAME,1)
[nrow,ncol] = size(fft_frame);

if nfft ~= nrow
    
    warning('SMT:FULL_SPECTRUM2POSITIVE_SPECTRUM:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of FFT\n'...
        'FFT must be NFFT x NFRAME\nSize of FFT entered was %d x %d\n'...
        'NFFT entered was %d\nUsing NFFT = %d'],nrow,ncol,nfft,nrow);
    
    nfft = nrow;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nyquist index
inyq = nyq(nfft);

% Positive half of FFT
posspec = fft_frame(1:inyq,:);

if nrgflag
    
    % Add spectral energy of negative half
    posspec(2:inyq-1,:) = 2*fft_frame(2:inyq-1,:);
    
end

end
