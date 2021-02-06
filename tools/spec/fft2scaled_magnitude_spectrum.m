function [scaled_magspec,pow] = fft2scaled_magnitude_spectrum(fft_frame,framelen,nfft,winflag,scaleflag)
%FFT2SCALED_MAGNITUDE_SPECTRUM Scale magnitude spectrum.
%   [SMAGSPEC,POW] = FFT2SCALED_MAGNITUDE_SPECTRUM(FFTFR,M,NFFT,WINFLAG,MAGFLAG)
%
%   See also SCALED_MAGNITUDE_SPECTRUM2MAGNITUDE_SPECTRUM

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


% Scale the magnitude spectrum
switch lower(scaleflag)
    
    case {'nne','lin'}
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = fft2positive_magnitude_spectrum(fft_frame,nfft,true);
        
    case 'log'
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = fft2log_magnitude_spectrum(fft_frame,nfft,'dbp',true,true);
        
    case 'pow'
        
        % Power scaling
        pow = xqifft_temp(framelen,winflag);
        
        % Add negative spectral energy
        scaled_magspec = fft2power_magnitude_spectrum(fft_frame,nfft,pow,true,true);
        
    otherwise
        
        warning('SMT:FFT2SCALED_MAGNITUDE_SPECTRUM:invalidFlag',...
            ['Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be LOG, LIN, or POW.\n'...
            'MAGFLAG entered was %d.\n'...
            'Using default MAGFLAG = LOG.\n'],scaleflag)
        
        % Power scaling
        pow = 1;
        
        % Add negative spectral energy
        scaled_magspec = fft2log_magnitude_spectrum(fft_frame,nfft,'dbp',true,true);
        
end

end
