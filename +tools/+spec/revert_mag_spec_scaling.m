function magspec = revert_mag_spec_scaling(scaled_magspec,pow,magflag)
%REVERT_MAG_SPEC_SCALING Revert scaling of magnitude spectrum.
%   MAGSPEC = REVERT_MAG_SPEC_SCALING(SCALED_MAGSPEC,POW,MAGFLAG)
%
%   See also FFT2SCALED_MAG_SPEC

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.2 $Id


% Unscale the magnitude spectrum
switch lower(magflag)
    
    case {'nne','lin'}
        
        % No need to revert
        magspec = scaled_magspec;
        
    case 'log'
        
        % From log to linear
        magspec = tools.dsp.log2lin(scaled_magspec,'dbp');
        
    case 'pow'
        
        % From power to linear
        magspec = tools.dsp.pow2lin(scaled_magspec,pow);
        
    otherwise
        
        warning('SMT:FFT2SCALED_MAG_SPEC:invalidFlag',...
            ['Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be LOG, LIN, or POW.\n'...
            'MAGFLAG entered was %d.\n'...
            'Using default MAGFLAG = LOG.\n'],scaleflag)
        
        % From log to linear
        magspec = tools.dsp.log2lin(scaled_magspec,'dbp');
        
end

end
