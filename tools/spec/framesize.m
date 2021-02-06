function [framelen,f0] = framesize(f0,fs,mult,f0flag)
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

% 2020 MCaetano SMT% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,2);

% F0 condition
f0_bool = isfinite(f0) & f0 > 0;

% If no value in F0 matches condition
if all(~f0_bool(:))
    
    error(['SMT:invalidInputArg: ','F0 must have at least one finite positive value']);
    
else
    
    % Sanitizing f0 (eliminating Inf, NaN, and f0 <= 0)
    f0 = f0(f0_bool);
    
end

% If Fs is neither a scalar nor a positive integer
if numel(fs) ~= 1 || fs <= 0 || isfrac(fs)
    
    warning(['SMT:wrongInputArgValue: ', 'Fs must be a scalar positive integer.\n'...
        'Value entered was %6.2f. Rounding off Fs\n'],fs);
    
    % WARNING: Fs == 0 breaks this line
    fs = max(abs(ceil(fs)));
    
end

% If 2 input arguments
if nargin == 2
    
    % Fallback to default value
    mult = 3;
    
    % Fallback to default value
    f0flag = false;
    
elseif nargin == 3
    
    % If MULT is neither a scalar nor a positive integer
    if numel(mult) ~= 1 || mult <= 0 || isfrac(mult)
        
        [nrow,ncol] = size(mult);
        
        warning(['SMT:wrongInputArgValue: ', 'MULT must be a nonnegative'...
            ' integer scalar.\nSize of MULT entered was %dx%d.'...
            ' Value entered was %s.\nRounding off MULT and using the'...
            ' absolute value of the maximum'],nrow,ncol,num2str(mult));
        
        % WARNING: Fs == 0 breaks this line
        mult = max(abs(ceil(mult)));
        
        
    end
    
    % Fallback to default value
    f0flag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% F0 sanitization always returns a column vector, so median(f0) also works
framelen = ceil(mult*fs/median(f0(:)));

if ~f0flag
    
    f0 = median(f0(:));
    
end

end
