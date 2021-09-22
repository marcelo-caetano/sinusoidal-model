function [bin,nbin] = mkbin(nfft,nframe,nchannel,freqlimflag)
%MKBIN Make frequency bin array.
%   K = MKBIN(NFFT,NFRAME,NCHANNEL) returns a frequency bin array K 
%   corresponding to the full frequency range of the DFT spectrum.
%   K is size NFFT x NFRAME x NCHANNEL.
%
%   K = MKBIN(NFFT,NFRAME,NCHANNEL,FREQLIMFLAG) uses FREQLIMFLAG to
%   control the limits of the frequency axis. FREQLIMFLAG can be 'POS',
%   'FULL', or 'NEGPOS'. The default is FREQLIMFLAG = 'FULL'.
%
%   FREQLIMFLAG = 'POS' generates frequencies from 0 to Nyquist. Use
%   'POS' to get the positive half of the spectrum. K is size
%   NBIN x NFRAME x NCHANNEL, where NBIN is the number of positive
%   frequency bins.
%
%   FREQLIMFLAG = 'FULL' generates frequencies from 0 to NFFT-1. Use
%   'FULL' to get the full frequency range output by the FFT. K is size
%   NFFT x NFRAME x NCHANNEL.
%
%   FREQLIMFLAG = 'NEGPOS' generates the negative and positive halves of
%   the frequency spectrum. Use 'NEGPOS' to get the full frequency range
%   with the zero-frequency component in the middle of the spectrum. Use
%   FFTFLIP to plot the spectrum. K is size NFFT x NFRAME x NCHANNEL.
%
%   [K,NBIN] = MKBIN(...) also outputs the number of frequency bins
%   corresponding to the fist dimension of the array K. NBIN = NFFT when
%   FREQLIMFLAG = 'FULL' or FREQLIMFLAG = 'NEGPOS' and NBIN = NFFT/2
%   when FREQLIMFLAG = 'POS'.
%
%   See also NYQ, NYQ_FREQ, FFTFLIP

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT
% $Id 2021 M Caetano SM 0.7.0-alpha.2 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,4);

% Check number of output arguments
nargoutchk(0,2);

if nargin == 3
    
    freqlimflag = 'full';
    
end

% Validate NFFT
validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',1)

% Validate NFRAME
validateattributes(nframe,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFRAME',2)

% Validate NCHANNEL
validateattributes(nchannel,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NCHANNEL',3)

% Validate FREQLIMFLAG
validateattributes(freqlimflag,{'char','string'},{'scalartext','nonempty'},mfilename,'FREQLIMFLAG',4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Preprocessing for each case
switch lower(freqlimflag)
    
    case 'pos'
        
        % Do NOT shiftflag zero frequency to the middle of the spectrum
        shiftflag = false;
        
        % ISPOS flag
        ispos = true;
        
    case 'full'
        
        % Do NOT shiftflag zero frequency to the middle of the spectrum
        shiftflag = false;
        
        % ISPOS flag
        ispos = false;
        
    case 'negpos'
        
        % Shift zero-frequency bin to the center of the spectrum
        shiftflag = true;
        
        % ISPOS flag
        ispos = false;
        
    otherwise
        
        warning('SMT:MKBIN:UnknownFlag',['Unknown FREQLIMFLAG.\n'...
            'FREQLIMFLAG must be FULL, POS, or NEGPOS.\nValue entered'...
            'was %s\nUsing default value FREQLIMFLAG = FULL'],freqlinflag)
        
        % Do NOT shiftflag zero frequency to the middle of the spectrum
        shiftflag = false;
        
        % ISPOS flag
        ispos = false;
        
end

% Make bin vector
bvec = (0:nfft-1)';

% Make bin array
bin = repmat(bvec,1,nframe,nchannel);

if shiftflag
    
    % Shift zero frequency bin
    bin = tools.spec.binshift(bin,nfft);
    
end

if ispos
    
    % Bins corresponding to positive half of frequency spectrum
    bin = tools.fft2.full_spec2pos_spec(bin,nfft);
    
    % Number of positive frequency bins
    nbin = tools.spec.pos_freq_band(nfft);
    
else
    
    % Number of frequency bins
    nbin = nfft;
    
end

end
