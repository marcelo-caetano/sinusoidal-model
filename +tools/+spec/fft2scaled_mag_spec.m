function [scaled_magspec,pow] = fft2scaled_mag_spec(fft_frame,framelen,nfft,winflag,scaleflag)
%FFT2SCALED_MAG_SPEC Scale magnitude spectrum.
%   [SMAGSPEC,POW] = FFT2SCALED_MAG_SPEC(FFTFR,M,NFFT,WINFLAG,MAGFLAG)
%
%   See also SCALED_MAGNITUDE_SPECTRUM2MAGNITUDE_SPECTRUM

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0% $Id 2021 M Caetano SM 0.5.0-alpha.1 $Id


% Scale the magnitude spectrum
switch lower(scaleflag)
    
    case {'nne','lin'}
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = tools.spec.fft2pos_mag_spec(fft_frame,nfft,true);
        
    case 'log'
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = tools.spec.fft2log_mag_spec(fft_frame,nfft,'dbp',true,true);
        
    case 'pow'
        
        % Power scaling
        pow = xqifft_temp(framelen,winflag);
        
        % Add negative spectral energy
        scaled_magspec = tools.spec.fft2pow_mag_spec(fft_frame,nfft,pow,true,true);
        
    otherwise
        
        warning('SMT:FFT2SCALED_MAG_SPEC:invalidFlag',...
            ['Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be LOG, LIN, or POW.\n'...
            'MAGFLAG entered was %d.\n'...
            'Using default MAGFLAG = LOG.\n'],scaleflag)
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = tools.spec.fft2log_mag_spec(fft_frame,nfft,'dbp',true,true);
        
end

end
