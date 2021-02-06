function magspec = revert_magnitude_spectrum_scaling(scaled_magspec,pow,magflag)
%REVERT_MAGNITUDE_SPECTRUM_SCALING Revert scaling of magnitude spectrum.
%   MAGSPEC = REVERT_MAGNITUDE_SPECTRUM_SCALING(SCALED_MAGSPEC,POW,MAGFLAG)
%
%   See also FFT2SCALED_MAGNITUDE_SPECTRUM

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


% Unscale the magnitude spectrum
switch lower(magflag)
    
    case {'nne','lin'}
        
        % No need to revert
        magspec = scaled_magspec;
        
    case 'log'
        
        % From log to linear
        magspec = log2lin(scaled_magspec,'dbp');
        
    case 'pow'
        
        % From power to linear
        magspec = pow2lin(scaled_magspec,pow);
        
    otherwise
        
        warning('SMT:FFT2SCALED_MAGNITUDE_SPECTRUM:invalidFlag',...
            ['Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be LOG, LIN, or POW.\n'...
            'MAGFLAG entered was %d.\n'...
            'Using default MAGFLAG = LOG.\n'],scaleflag)
        
        % From log to linear
        magspec = log2lin(scaled_magspec,'dbp');
        
end

end
