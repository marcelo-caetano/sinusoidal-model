function nfft = fftsize(framelen)
%FFTSIZE Return size of the FFT as power of two.
%   NFFT = FFTSIZE(FRAMELEN) returns the size of the FFT NFFT that
%   corresponds to the next power of two greater than FRAMELEN.
%
%   See also FRAMESIZE, HOPSIZE, CEPSORDER

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


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

% Must be integer
if tools.misc.isfrac(framelen)
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be integer.\n'...
        'Value entered was %2.5g. Rounding off FRAMELEN\n'],framelen);
    
    framelen = ceil(framelen);
    
end

% Must be numeric
if ~isnumeric(framelen)
    
    warning(['SMT:wrongInputArgValue: ','FRAMELEN must be numerical.\n'...
        'Class of FRAMELEN entered was %s. Using default value NFFT = 1024\n'],...
        class(framelen));
    
    framelen = 1024;
    
end

%isfinite
if ~isfinite(framelen)
    
    warning('SMT:FFTSIZE:invalidInputArgument',...
        ['FRAMELEN must be finite.\n'...
        'Using default value NFFT = 1024']);
    
    framelen = 1024;
    
end

%ispositive
if framelen <= 0
    
    warning('SMT:FFTSIZE:invalidInputArgument',...
        ['FRAMELEN must be positive.\n'...
        'Value entered was %2.5g.\N'...
        'Using default value NFFT = 1024\n'],framelen);
    
    framelen = 1024;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make NFFT the next power of 2 larger than FRAMELEN
nfft = 2^nextpow2(framelen);

end
