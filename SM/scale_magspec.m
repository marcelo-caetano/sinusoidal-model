function [smagspec,p] = scale_magspec(fft_frame,framelen,nfft,winflag,magflag)

% Scale the magnitude spectrum
switch lower(magflag)
    
    case {'nne','lin'}
        
        p = 1;
        smagspec = fft2pms(fft_frame,nfft);
        
    case 'log'
        
        p = 1;
        smagspec = fft2lms(fft_frame,'dbp',nfft,true);
        
    case 'pow'
        
        p = xqifft_temp(framelen,winflag);
        smagspec = fft2pms(fft_frame,nfft).^p;
        
    otherwise
        
        warning(['SMT:invalidFlag: ','Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be LOG, LIN, or POW.\nMAGFLAG entered was %d.\n'...
            'Using default magnitude scaling flag LOG.\n'],magflag)
        
        p = 1;
        smagspec = fft2lms(fft_frame,'dbp',nfft,true);
        
end

end
