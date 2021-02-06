function res = iseven(num)
%ISEVEN Test if a number is even.
%   RES = ISEVEN(NUM) returns TRUE when NUM is even and FALSE otherwise.
%
%   See also ISODD, ISINT

% 2020 MCaetano SMT 0.1.1


% TODO: Output logical array when input is numeric array

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

if isfrac(num)
    
    error(['SMT:ISEVEN:notInteger','Input argument NUM must be an integer.\n'...
        'NUM entered was %5.2f.'],num);
    
end

if ~isnumeric(num)
    
    error(['SMT:ISEVEN:notNumeric','Input argument NUM must be an integer.\n'...
        'NUM entered was %5.2f.'],num);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK REMAINDER AFTER DIVISION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

res = ~isodd(num);

end