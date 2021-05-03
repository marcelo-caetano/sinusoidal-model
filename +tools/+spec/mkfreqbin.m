function [f,nbin] = mkfreqbin(nfft,fs,nframe,nchannel,freqlimflag,frequnitflag)
%FREQBIN Make frequency array in bins or in Hertz.
%   F = FREQBIN(NFFT,Fs,NFRAME,NCHANNEL) returns a frequency array F in
%   Hertz corresponding to the full frequency range of the DFT spectrum. F
%   is size NFFT x NFRAME x NCHANNEL.
%
%   F = FREQBIN(NFFT,Fs,NFRAME,NCHANNEL,FREQLIMFLAG) uses FREQLIMFLAG to
%   control the limits of the frequency axis. FREQLIMFLAG can be 'POS',
%   'FULL', or 'NEGPOS'. The default is FREQLIMFLAG = 'FULL'.
%
%   FREQLIMFLAG = 'POS' generates frequencies from 0 to Nyquist. Use 'POS'
%   to get the positive half of the spectrum. F is size NFFT/2+1 x NFRAME x
%   NCHANNEL.
%
%   FREQLIMFLAG = 'FULL' generates frequencies from 0 to NFFT-1. Use 'FULL'
%   to get the full frequency range output by the FFT. F is size NFFT x
%   NFRAME x NCHANNEL.
%
%   FREQLIMFLAG = 'NEGPOS' generates the negative and positive halves. Use
%   'NEGPOS' to get the full frequency range with the zero-frequency
%   component in the middle of the spectrum. Use FFTFLIP to plot the
%   spectrum. F is size NFFT x NFRAME x NCHANNEL.
%
%   F = FREQBIN(NFFT,Fs,NFRAME,NCHANNEL,FREQLIMFLAG,FUNITFLAG) uses the
%   logical flag FUNITFLAG to control the unit of the frequency vector.
%   FUNITFLAG = TRUE outputs frequencies in Hertz and FUNITFLAG = FALSE
%   outputs frequencies in binDFT . The default is FUNITFLAG = FALSE.
%
%   [F,NBIN] = MKFREQBIN(...) also outputs the number of frequency bins
%   corresponding to the fist dimension of the array F. NBIN = NFFT when
%   FREQLIMFLAG = 'FULL' or FREQLIMFLAG = 'NEGPOS' and NBIN = NFFT/2+1 when
%   FREQLIMFLAG = 'POS'.
%
%   See also MKTIME, NYQ_FREQ, FFTFLIP

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT
% $Id 2021 M Caetano SM 0.6.0-alpha.1 $Id


% TODO: CHECK FUNCTION ARGUMENTS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,6);

% Check number of output arguments
nargoutchk(0,2);

if nargin == 4
    
    freqlimflag = 'full';
    
    frequnitflag = false;
    
elseif nargin == 5
    
    frequnitflag = false;
    
end

% WARNING! Check how FFT handles odd NFFT
if ~tools.misc.iseven(nfft)
    
    error('Size of DFT must be a power of 2');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preprocessing for each case
switch lower(freqlimflag)
    
    case 'pos'
        
        % Do NOT shift zero frequency to the middle of the spectrum
        shift = 0;
        
        % ISPOS flag
        ispos = true;
        
    case 'full'
        
        % Do NOT shift zero frequency to the middle of the spectrum
        shift = 0;
        
        % ISPOS flag
        ispos = false;
        
    case 'negpos'
        
        % Shift zero frequency to the middle of the spectrum
        shift = -nfft/2 + 1;
        
        % ISPOS flag
        ispos = false;
        
    otherwise
        
        warning('SMT:MKFREQBIN:unknownFlag',['Unknown FREQLIMFLAG.\n'...
            'FREQLIMFLAG must be FULL, POS, or NEGPOS.\nValue entered'...
            'was %s\nUsing default value FREQLIMFLAG = FULL'],freqlinflag)
        
        % Do NOT shift zero frequency to the middle of the spectrum
        shift = 0;
        
        % ISPOS flag
        ispos = false;
        
end

% Make index vector
ivec = (1:nfft)';

% Make index array
ind = repmat(ivec,1,nframe,nchannel);

% Make frequency bins
bin = tools.spec.ind2bin(ind);

% Shift zero frequency bin
bin = bin + shift;

if ispos
    
    % Bins corresponding to positive half of frequency spectrum
    bin = tools.fft2.full_spec2pos_spec(bin,nfft);
    
    % Number of positive frequency bins
    nbin = tools.spec.pos_freq_band(nfft);
    
else
    
    % Number of frequency bins
    nbin = nfft;
    
end

if frequnitflag
    
    % Convert index to frequency in Hz
    f = tools.spec.bin2freq(bin,fs,nfft);
    
else
    
    % Frequency bin numbers
    f = bin;
    
end

end
