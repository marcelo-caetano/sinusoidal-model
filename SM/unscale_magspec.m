function [smagspec] = unscale_magspec(magspec,p,magflag)
%UNSCALE_MAGSPEC Revert effect of magnitude spectrum scaling.
%   [SMAG_SPEC] = UNSCALE_MAGSPEC(MAG,P,MAGFLAG)
%
%   See also

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.3.1-alpha.2 $Id


% Unscale the magnitude spectrum
switch lower(magflag)
    
    case {'nne','lin'}
        
        % No need to do anything
        smagspec = magspec;
        
    case 'log'
        
        smagspec = log2lin(magspec,'dbp');
        
    case 'pow'
        
        smagspec = nthroot(magspec,p);
        
    otherwise
        
        warning(['InvalidMagFlag: Invalid Magnitude Scaling Flag.\n'...
            'Flag for magnitude scaling must be LOG, LIN, or POW.\n'...
            'Using default magnitude scaling flag LOG'])
        
        smagspec = log2lin(magspec,'dbp');
        
end

end
