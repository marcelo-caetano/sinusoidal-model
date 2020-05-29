function log_mag_spec = fft2lms(fft_frame,lmsflag,nfft,nrgflag,nanflag)
%FFT2LMS From complex FFT to log magnitude spectrum.
%   LMS = FFT2LMS(FFTFR,LMSFLAG) retuns the log magnitude spectrum LMS of
%   the complex Fourier spectrum FFTFR, which is the NFFT x NFR matrix
%   returned by STFT, where NFFT is the size of the FFT and NFR is the
%   number of frames. The string LMSFLAG controls the magnitude scaling as
%   'DBR' for dB root-power, 'DBP' for dB power, 'NEP' for neper, 'OCT' for
%   octave, and 'BEL' for bels.
%
%   PMS = FFT2LMS(FFTFR,LMSFLAG,NFFT) returns the _nonnegative_ half of the
%   log magnitude spectrum PMS of the complex Fourier spectrum FFTFR.
%   FFT2LMS returns the full log magnitude spectrum if NFFT is empty. So
%   FFT2LMS(FFTFR,LMSFLAG,[]) is equivalent to FFT2LMS(FFTFR,LMSFLAG).
%
%   PMS = FFT2LMS(FFTFR,LMSFLAG,NFFT,NRGFLAG) uses the logical flag NRGFLAG
%   to add the spectral energy of the _negative_ half of the spectrum to
%   the _nonnegative_ half. NRGFLAG = TRUE adds the negative energy and 
%   NRGFLAG = FALSE does not. The default is FALSE when FFT2LMS is called
%   with 2 or 3 input arguments.
%
%   PMS = FFT2LMS(...,NANFLAG) uses NANFLAG to handle the case FFTFR = 0.
%   NANFLAG = TRUE replaces 0 with eps(0) to avoid -Inf in LMS. NANFLAG =
%   FALSE ignores 0 in FFTFR. Use NANFLAG = TRUE to get only numeric values
%   in LMS. NANFLAG defaults to FALSE when FFT2LMS is called with either 2
%   or 3 input arguments. Use FFT2LMS(FFTFR,LMSFLAG,NFFT,NRGFLAG,NANFLAG)
%   for the _nonnegative_ half of the log magnitude spectrum and
%   FFT2LMS(FFTFR,LMSFLAG,[],NRGFLAG,NANFLAG) for the full log magnitude
%   spectrum (NRGFLAG is ignored).
%
%
%   See also FFT2RC, LIN2LOG, LOG2LIN, RCEPS, CCEPS, ICCEPS

% 2020 MCaetano SMT 0.1.2
% 2020 MCaetano SMT 0.2.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,5);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    nfft = [];
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 3
    
    nrgflag = false;
    
    nanflag = false;
    
elseif nargin == 4
    
    nanflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isempty(nfft)
    
    % Full magnitude spectrum
    mag_spec = fft2mag(fft_frame);
    
    % Log magnitude spectrum
    log_mag_spec = lin2log(mag_spec,lmsflag,nanflag);
    
else
    
    % Positive magnitude spectrum
    mag_spec = fft2pms(fft_frame,nfft,nrgflag);
    
    % Log magnitude spectrum
    log_mag_spec = lin2log(mag_spec,lmsflag,nanflag);
    
end

end
