function posspec = full_spec2pos_spec(fft_frame,nfft,nrgflag)
%FULL_SPEC2POS_SPEC Full spectrum to positive spectrum.
%   PS = FULL_SPEC2POS_SPEC(FFT) returns the _nonnegative_
%   frequency half of the complex FFT vector or matrix. FFT can be either a
%   NFFT x 1 colum vector or an NFFT x NFRAME matrix with NFRAME frames of
%   the STFT.
%
%   PS = FULL_SPEC2POS_SPEC(FFT,NFFT) uses NFFT for the size
%   of the FFT.
%
%   PS = FULL_SPEC2POS_SPEC(F,NFFT,NRGFLAG) uses the logical
%   flag NRGFLAG to specify if PS should also contain the spectral energy
%   of the negative frequency bins. NRGFLAG = TRUE adds the energy of the
%   negative frequency bins to the positive spectrum and NRGFLAG = FALSE
%   does not. The default is NRGFLAG = FALSE for the previous syntaxes.
%
%   See also POS_SPEC2FULL_SPEC,
%   FFT2POS_MAG_SPEC, FFT2POS_PHASE_SPEC

% 2020 M Caetano SMT 0.1.2
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.1 $Id


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
    
    warning('SMT:FULL_SPEC2POS_SPEC:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of FFT\n'...
        'FFT must be NFFT x NFRAME\nSize of FFT entered was %d x %d\n'...
        'NFFT entered was %d\nUsing NFFT = %d'],nrow,ncol,nfft,nrow);
    
    nfft = nrow;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nyquist index
inyq = tools.spec.nyq_freq(nfft);

% Positive half of FFT
posspec = fft_frame(1:inyq,:);

if nrgflag
    
    % Add spectral energy of negative half
    posspec(2:inyq-1,:) = 2*fft_frame(2:inyq-1,:);
    
end

end
