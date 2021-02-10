function linmag = log2lin(logmag,magflag,realflag,tol)
%LIN2LOG Convert from log to linear amplitude.
%   LINMAG = LOG2LIN(LOGMAG,MAGFLAG) scales the log magnitude spectrum
%   LOGMAG to the linear scale specified by the string MAGFLAG, which
%   can be 'DBR' for decibel root-power, 'DBP' for decibel power, 'BEL' for
%   bels, 'NEP' for neper, and 'OCT' for octave.
%
%   DBR uses 10.^(LOGMAG/10), DBP uses 10.^(LOGMAG/20), BEL uses
%   10.^(LOGMAG), NEP uses EXP, and OCT uses 2.^(LOGMAG).
%
%   LINMAG = LOG2LIN(LOGMAG,MAGFLAG,REALFLAG) uses the logical flag
%   REALFLAG to handle complex LOGMAG. REALFLAG = TRUE forces LINMAG to be
%   real and the default LINMAG = FALSE outputs complex LINMAG when the
%   following condition fails ALL(IMAG(LINMAG) < TOL). The default value
%   TOL = 1E-10 can be customized by calling LOG2LIN with four input
%   arguments as described below.
%
%   LINMAG = LOG2LIN(LOGMAG,MAGFLAG,REALFLAG,TOL) uses TOL to specify the
%   minimum tolerance to consider the value of imaginary part as
%   floating-point conversion error. Use TOL to guarantee that LOG2LIN
%   reverses the effect of LIN2LOG for negative input. The condition
%   LOG2LIN(LIN2LOG(-2)) == -2 is satisfied if REALFLAG = TRUE or if
%   ALL(IMAG(LINMAG) < TOL).
%
%   See also LIN2LOG, LIN2POW, POW2LIN

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% TODO: Check inputs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,4);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    realflag = false;
    
    tol = 1e-10;
    
elseif nargin == 3
    
    tol = 1e-10;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(magflag)
    
    case 'dbr'
        
        magscale = @(x) 10.^(x/10);
        
    case 'dbp'
        
        magscale = @(x) 10.^(x/20);
        
    case 'bel'
        
        magscale = @(x) 10.^(x);
        
    case 'nep'
        
        magscale = @exp;
        
    case 'oct'
        
        magscale = @(x) 2.^(x);
        
    otherwise
        
        warning('SMT:LOG2LIN:InvalidMagFlag', ['Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be DBR, DBP, NEP, OCT, or BEL.\n'...
            'Flag entered was %s\n.'...
            'Using default magnitude scaling flag DBP'],magflag)
        
        magscale = @(x) 10.^(x/20);
        
end

% Convert from log to linear
linmag = magscale(logmag);

% Output realpart when either condition is met
if realflag || isAllImagPartNegligible(linmag,tol)
    
    linmag = real(linmag);
    
end

end

% Local function to check if imaginary part is negligible
function bool = isAllImagPartNegligible(lin,tol)

% Make LIN into column vector
lin_vec = lin(:);

% TRUE when magnitude of imaginary part is smaller than TOL
bool = all(abs(imag(lin_vec)) < tol);

end
