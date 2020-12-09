function [framelen,f0] = sm_framesize(f0,fs,mult,f0flag)
%FRAMESIZE Returns the frame size.
%   M = FRAMESIZE(F0,Fs) returns the frame size M corresponding to 3
%   periods of the fundamental frequency F0 at a sampling frequency Fs. The
%   period is T0 = Fs/F0 samples, so M = ceil(3*Fs/F0). F0 can be a scalar
%   or a multidimensional array.
%
%   M = FRAMESIZE(F0,Fs,MULT) returns M = ceil(MULT*Fs/F0), where MULT must
%   be a nonnegative integer. Otherwise, MULT falls back to the default
%   value of MULT = 3.
%
%   [M,F'0] = FRAMESIZE(F0,Fs,MULT) also returns the median of the input F0
%   in F'0. This is equivalent to [M,F'0] = FRAMESIZE(...,F0FLAG) when
%   F0FLAG = false. Set F0FLAG = true to return a column vector of valid
%   values of F0.
%
%   See also HOPSIZE, FFTSIZE, CEPSORDER

% 2020 MCaetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of input arguments
narginchk(2,4);

% Number of output arguments
nargoutchk(0,2);

if all(not(isfinite(f0) & f0 > 0),'all')
    
    error(['SMT:invalidInputArg: ','F0 must have at least one finite positive value']);
    
else
    
    % Sanitizing f0 (eliminating Inf, NaN, and f0 <= 0)
    f0 = f0(isfinite(f0) & f0 > 0);
    
end

if numel(fs) ~= 1 || not(isint(fs))
    
    warning(['SMT:wrongInputArgValue: ', 'Fs must be a scalar integer.\n'...
        'Value entered was %6.2f. Rounding off Fs\n'],fs);
    
    fs = max(ceil(fs));
    
end

if nargin == 2
    
    mult = 3;
    
    f0flag = false;
    
elseif nargin == 3
    
    if numel(mult) ~= 1
        
        warning(['SMT:wrongInputArgValue: ', 'MULT must be a scalar.\n'...
            'Value entered was %6.5g. Using default value MULT = 3\n'],mult);
        
        mult = 3;
        
        
    end
    
    if mult <= 0 || not(isint(mult))
        
        warning(['SMT:wrongInputArgValue: ', 'MULT must be a nonnegative integer.\n'...
            'Value entered was %6.5g. Using default value MULT = 3\n'],mult);
        
        mult = 3;
        
    end
    
    f0flag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY OF FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% F0 sanitization always returns a column vector, so median(f0) also works
framelen = ceil(mult*fs/median(f0,'all'));

if not(f0flag)
    
    f0 = median(f0,'all');
    
end

end
