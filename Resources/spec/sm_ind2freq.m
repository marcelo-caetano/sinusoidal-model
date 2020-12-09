function freq = sm_ind2freq(ind,fs,nfft,freqlimflag)
%IND2FREQ Convert array index to frequency in Hz.
%   F = IND2FREQ(IND,Fs,NFFT) converts the array index IND into nonnegative
%   frequency F in Hertz for the sampling frequency given by Fs and
%   1 <= IND <= NFFT, where NFFT is the size of the DFT. This syntax
%   returns F with negative frequencies on the right-hand size of the
%   spectrum.
%
%   F = IND2FREQ(IND,Fs,NFFT,FREQLIMFLAG) uses FREQLIMFLAG to specify if
%   the zero frequency component of the spectrum must be shifted to the
%   center. FREQLIMFLAG = true shifts the zero frequency component to the
%   center and FREQLIMFLAG = false does not. FREQLIMFLAG = false is the
%   default and F = IND2FREQ(IND,Fs,NFFT,false) is equivalent to F =
%   (IND,Fs,NFFT).
%
%   The DFT bins are Fs/NFFT Hertz apart, so the conversion is
%   F = ((IND-1)*Fs)/NFFT. Fractional indices will return an error. Use
%   BIN2FREQ for fractional bin number support.
%
%   See also FREQ2IND, FREQ2BIN, BIN2FREQ, BIN2IND, IND2BIN, MKFREQ, NYQ

% 2020 MCaetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


% TODO: Check classes and dimensions of input arguments

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,4);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 3
    
    freqlimflag = false;
    
end

% Check for fractional indices (must be integers)
if any(not(isint(ind)),'all')
    
    error('SMT:NotInteger: Input IND must be integer');
    
end

if any(ind <= 0,'all')
    
    error('SMT:ERROR: Input IND must be positive');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONVERT FROM INDEX TO FREQUENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if freqlimflag
    
    % Index to NEGPOS bin
    bin = sm_ind2bin(ind,nfft);
    
    % Bin to frequency in Hz
    freq = sm_bin2freq(bin,fs,nfft);
    
else
    
    % Index to FULL bin
    bin = sm_ind2bin(ind);
    
    % Bin to frequency in Hz
    freq = sm_bin2freq(bin,fs,nfft);
    
end

end
