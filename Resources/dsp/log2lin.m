function [linmag] = log2lin(logmag,magflag)
%LIN2LOG Convert from log to linear amplitude.
%   [LINMAG] = LOG2LIN(LOGMAG,MAGFLAG) scales the log magnitude spectrum
%   LOGMAG to the linear scale specified by the string MAGFLAG, which
%   can be 'DBR' for decibel root-power, 'DBP' for decibel power, 'BEL' for
%   bels, 'NEP' for neper, and 'OCT' for octave.
%
%   DBR uses 10.^(LOGMAG/10), DBP uses 10.^(LOGMAG/20), BEL uses
%   10.^(LOGMAG), NEP uses EXP, and OCT uses 2.^(LOGMAG).
%
%   See also LIN2LOG

% 2020 MCaetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% TODO: Check inputs

switch lower(magflag)
    
    case 'dbr'
        
        magscale = @(x) 10.^(x/10);
        
    case 'dbp'
        
        magscale = @(x) 10.^(x/20);
        
    case 'bel'
        
        magscale = @(x) 10.^(x);
        
    case 'nep'
        
        magscale = @exp;
        
    case 'oct'
        
        magscale = @(x) 2.^(x);
        
    otherwise
        
        warning(['InvalidMagFlag: Invalid Magnitude Scaling Flag.\n'...
            'Flag for magnitude scaling must be DBR, DBP, NEP, OCT, or BEL.\n'...
            'Using default magnitude scaling flag DBP'])
        
        magscale = @(x) 10.^(x/20);
        
end

linmag = magscale(logmag);

end
