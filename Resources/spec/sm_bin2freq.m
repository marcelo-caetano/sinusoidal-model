function freq = sm_bin2freq(bin,fs,nfft,nnflag)
%BIN2FREQ Convert bin number to frequency in Hz.
%   F = BIN2FREQ(K,Fs,NFFT) converts the bin number K into frequency F in
%   Hertz for the sampling frequency given by Fs and 0 <= K <= NFFT - 1,
%   where NFFT is the size of the DFT. The DFT bins are Fs/NFFT Hertz apart,
%   so the conversion is F = (K * Fs)/NFFT. Fractional bin numbers will
%   result in frequencies between the bins of the DFT. Negative bin numbers
%   are accepted as long as -NFFT/2+1 <= K <= NFFT/2.
%
%   F = BIN2FREQ(K,Fs,NFFT,NNFLAG) uses NNFLAG to handle fractional bin
%   numbers because fractional bins result in frequencies F between the
%   bins of the DFT. NNFLAG = TRUE rounds off fractional bins prior to the
%   conversion and NNFLAG = FALSE simply performs the conversion. NNFLAG =
%   FALSE is the default and F = BIN2FREQ(K,Fs,NFFT,false) is equivalent to
%   F = BIN2FREQ(K,Fs,NFFT).
%
%   See also FREQ2BIN, FREQ2IND, IND2FREQ, BIN2IND, IND2BIN, MKFREQ, NYQ

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


% TODO: Check classes and dimensions of input arguments

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,4);

% Check number of input arguments
nargoutchk(0,1);

if nargin == 3
    
    nnflag = false;
    
end

if any(bin < -nfft/2+1 | bin > nfft-1,'all')
    
    error('SMT:ERROR: Bin numbers out of range');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONVERT FROM BIN TO FREQUENCY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nnflag
    
    bin = round(bin);
    
end

% Conversion
freq = (bin * fs) / nfft;

end
