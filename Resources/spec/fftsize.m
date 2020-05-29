function nfft = fftsize(framelen)
%FFTSIZE Return size of the FFT as power of two.
%   NFFT = FFTSIZE(FRAMELEN) returns the size of the FFT NFFT that
%   corresponds to the next power of two greater than FRAMELEN.
%
%   See also FRAMESIZE, HOPSIZE, CEPSORDER

% 2020 MCaetano SMT 0.1.1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(1,1);

% Number of output arguments
nargoutchk(0,1);

%numel == 1
if numel(framelen) ~= 1
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be a scalar.\n'...
        'Value entered was %2.5g. Using default value NFFT = 1024\n'],framelen);
    
    framelen = 1024;
    
end

%~isint
if not(isint(framelen))
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be integer.\n'...
        'Value entered was %2.5g. Rounding off FRAMELEN\n'],framelen);
    
    framelen = ceil(framelen);
    
end

%isnumeric
if not(isnumeric(framelen))
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be numerical.\n'...
        'Class of FRAMELEN entered was %s. Using default value NFFT = 1024\n'],...
        class(framelen));
    
    framelen = 1024;
    
end

%isfinite
if not(isfinite(framelen))
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be finite.'...
        ' Using default value NFFT = 1024']);
    
    framelen = 1024;
    
end

%ispositive
if framelen <= 0
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be positive.\n'...
        'Value entered was %2.5g. Using default value NFFT = 1024\n'],framelen);
    
    framelen = 1024;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY OF FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nfft = 2^nextpow2(framelen);

end
