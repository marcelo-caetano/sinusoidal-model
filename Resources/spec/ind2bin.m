function bin = ind2bin(ind,nfft)
%IND2BIN Convert array index into frequency bin.
%   K = IND2BIN(IND) converts the array indices IND into nonnegative
%   frequency bin numbers K = IND - 1. IND can be a scalar, array, or matrix.
%   However, IND must be positive integers otherwise IND2BIN throws an error.
%
%   K = IND2BIN(IND,NFFT) converts IND into negative and positive bin
%   numbers using NFFT as reference.
%
%   See also BIN2IND, IND2FREQ, FREQ2IND, FREQ2BIN, BIN2FREQ, MKFREQ, NYQ

% 2020 MCaetano SMT 0.1.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    nfft = [];
    
    shift = 0;
    
else
    
    nyqbin = nyq(nfft,'bin');
    
    shift = -nyqbin + 1;
    
end

if not(isempty(nfft))
    
    if numel(nfft) ~= 1
        
        error(['SMT:ERROR:isArray: ','NFFT must be scalar.\n'...
            'NFFT entered is size %dx%d.\n'],size(nfft));
        
    elseif not(isnumeric(nfft))
        
        error(['SMT:ERROR:isNumeric: ','NFFT must be numeric.\n'...
            'NFFT entered is class %s.\n'],class(nfft));
        
    elseif not(isfinite(nfft))
        
        error(['SMT:ERROR:isFinite: ','NFFT must be finite.\n'...
            'NFFT entered is %f.\n'],nfft);
        
    elseif not(isint(nfft))
        
        error(['SMT:ERROR:isInteger: ','NFFT must be integer.\n'...
            'NFFT entered is %5.2f.\n'],nfft);
        
    elseif not(iseven(nfft))
        
        error(['SMT:ERROR:isOdd: ','NFFT must be a power of 2.\n'...
            'NFFT entered is %d.\n'],nfft);
        
    elseif length(ind) ~= nfft
        
        error(['SMT:ERROR:inconsistentInput Arguments: ',...
            'NFFT must be equal to length(IND).\n'...
            'NFFT entered is %d but length(IND) is %d.\n'],nfft,length(ind));
        
    end
    
end

% Check that IND is integer
if any(not(isint(ind)),'all')
    
    error('SMT:NotInteger: Input IND must be integers');
    
end

% Check that IND > 0
if any(ind <= 0,'all')
    
    error('SMT:NotPositive: Input IND must be positive');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONVERT FROM INDEX TO BIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Conversion
bin = ind - 1 + shift;

end
