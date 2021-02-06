function logmagspec = fft2log_magnitude_spectrum(fft_frame,nfft,lmsflag,posfreqflag,nrgflag,nanflag)
%FFT2LOG_MAGNITUDE_SPECTRUM From complex FFT to log magnitude spectrum.
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT) retuns the log magnitude spectrum
%   LMS of the full frequency range of the complex FFT vector or matrix in
%   dB power. FFT can be either an NFFT x 1 column vector or NFFT x NFRAME
%   matrix with NFRAME frames of the STFT. LMS is the same size as FFT.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT) uses NFFT as the size of the
%   FFT.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT,LMSFLAG) uses the string
%   LMSFLAG to specify the magnitude scaling of the spectrum. LMSFLAG can
%   be 'DBR' for dB root-power, 'DBP' for dB power, 'NEP' for neper, 'OCT'
%   for octave, and 'BEL' for bels.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT,LMSFLAG,POSFREQFLAGFLAG) uses
%   the logical flag POSFREQFLAG to specify the frequency range of LMS.
%   POSFREQFLAG = FALSE is the default to output the full frequency range
%   of the log magnitude spectrum. POSFREQFLAG = TRUE forces
%   FFT2LOG_MAGNITUDE_SPECTRUM to output the positive half of the FFT.
%   LMS is NFFT/2+1 x NFRAME, where NFFT/2+1 is the number of _nonnegative_
%   frequency bins of the FFT.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT,LMSFLAG,POSFREQFLAGFLAG,
%   NRGFLAG) uses the logical flag NRGFLAG to specify if LMS should also
%   contain the spectral energy of the negative frequency bins.
%   NRGFLAG = TRUE adds the negative frequency energy to the log magnitude
%   spectrum and NRGFLAG = FALSE does not. The default is NRGFLAG = FALSE.
%   POSFREQFLAG must be TRUE when NRGFLAG = TRUE.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT,LMSFLAG,POSFREQFLAGFLAG,
%   NRGFLAG,NANFLAG) uses the logical flag NANFLAG to handle the case
%   FFT = 0. NANFLAG = TRUE replaces 0 with eps(0) to avoid -Inf in LMS
%   because log(0) = -Inf. NANFLAG = FALSE does not replace 0 in FFT. Use
%   NANFLAG = TRUE to get only numeric values in LMS. NANFLAG defaults to
%   FALSE for the previous syntaxes.
%
%   LMS = FFT2LOG_MAGNITUDE_SPECTRUM(FFT,NFFT,LMSFLAG,POSFREQFLAGFLAG,
%   NRGFLAG,NANFLAG)
%
%   See also FFT2UNWRAPPED_PHASE_SPECTRUM, FFT2MAGNITUDE_SPECTRUM,
%   FFT2PHASE_SPECTRUM, FFT2POSITIVE_MAGNITUDE_SPECTRUM,
%   FFT2POSITIVE_PHASE_SPECTRUM

% 2020 MCaetano SMT 0.1.2
% 2020 MCaetano SMT 0.2.1
% 2021 M Caetano SMT (Revised)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,6);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    [nfft,~] = size(fft_frame);
    
    lmsflag = 'dbp';
    
    posfreqflag = false;
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 2
    
    lmsflag = 'dbp';
    
    posfreqflag = false;
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 3
    
    posfreqflag = false;
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 4
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 5
    
    nanflag = false;
    
end

% Check that NFFT == SIZE(FFT_FRAME,1)
[nrow,ncol] = size(fft_frame);

if nfft ~= nrow
    
    warning('SMT:LOG_MAGNITUDE_SPECTRUM:wrongInputArgument',...
        ['Input argument NFFT does not match the dimensions of FFT.\n'...
        'FFT must be NFFT x NFRAME.\nSize of FFT entered was %d x %d.\n'...
        'NFFT entered was %d.\nUsing NFFT = %d'],nrow,ncol,nfft,nrow);
    
    nfft = nrow;
    
end

% POSFREQFLAG must be TRUE when NRGFLAG is TRUE
if nrgflag && ~posfreqflag
    
    warning('SMT:LOG_MAGNITUDE_SPECTRUM:wrongFlagCombination',...
        ['POSFREQFLAG must be TRUE when NRGFLAG is TRUE.\n'...
        'POSFREQFLAG entered was %d but NRGFLAG entered was %d.\n'...
        'Using POSFREQFLAG = TRUE'],posfreqflag,nrgflag);
    
    posfreqflag = true;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if posfreqflag
    
    % Positive magnitude spectrum
    magspec = fft2positive_magnitude_spectrum(fft_frame,nfft,nrgflag);
    
else
    
    % Full magnitude spectrum
    magspec = fft2magnitude_spectrum(fft_frame);
    
end

% Log magnitude spectrum
logmagspec = lin2log(magspec,lmsflag,nanflag);

end