function [smagspec] = unscale_magspec(magspec,p,magflag)

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
