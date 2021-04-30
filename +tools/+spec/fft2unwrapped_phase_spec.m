function unwrapped_phspec = fft2unwrapped_phase_spec(fft_frame,nfft,posfreqflag)
%FFT2UNWRAP_PHASE_SPEC From FFT to unwrapped phase spectrum.
%   UPS = FFT2UNWRAP_PHASE_SPEC(FFT) returns the unwrapped phase
%   spectrum of the complex FFT vector or matrix. FFT can be either an
%   NFFT x 1 colum vector or an NFFT x NFRAME matrix with NFRAME frames of
%   the STFT.
%
%   UPS = FFT2UNWRAP_PHASE_SPEC(FFT,NFFT) uses NFFT for the size of
%   the FFT.
%
%   UPS = FFT2UNWRAP_PHASE_SPEC(FFT) returns the unwrapped phase
%   spectrum of the positive half of the complex FFT vector or matrix. FFT
%   can be either an NFFT x 1 colum vector or an NFFT x NFRAME matrix with
%   NFRAME frames of the STFT. UPS is NFFT/2+1 x NFRAME, where NFFT/2+1 is
%   the number of _nonnegative_ frequency bins of the FFT.
%
%   See also FFT2POS_MAG_SPEC, FFT2MAG_SPEC,
%   FFT2PHASE_SPEC, FFT2LOG_MAG_SPEC

% 2021 M Caetano SMT% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


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
    
    % Default to full spectrum
    posfreqflag = false;
    
elseif nargin == 2
    
    % Default to full spectrum
    posfreqflag = false;
    
end

% Check that NFFT == SIZE(FFT_FRAME,1)
[nrow,ncol] = size(fft_frame);

if nfft ~= nrow
    
    warning('SMT:FFT2POS_MAG_SPEC:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of FFT\n'...
        'FFT must be NFFT x NFRAME\nSize of FFT entered was %d x %d\n'...
        'NFFT entered was %d\nUsing NFFT = %d'],nrow,ncol,nfft,nrow);
    
    nfft = nrow;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if posfreqflag
    
    % Positive phase spectrum
    phspec = tools.spec.fft2pos_phase_spec(fft_frame,nfft);
    
else
    
    % Full phase spectrum
    phspec = tools.spec.fft2phase_spec(fft_frame);
    
end

% Unwrap phase around PI
unwrapped_phspec = unwrap(phspec);

end
