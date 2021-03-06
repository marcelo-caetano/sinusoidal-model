function logmag = lin2log(linmag,magflag,nanflag)
%LIN2LOG Convert from linear to log amplitude.
%   LOGMAG = LIN2LOG(LINMAG,MAGFLAG) scales the linear magnitude spectrum
%   LINMAG to the logarithmic scale specified by the string MAGFLAG, which
%   can be 'DBR' for decibel root-power, 'DBP' for decibel power, 'BEL' for
%   bels, 'NEP' for neper, and 'OCT' for octave. DBR uses 10*log10, DBP
%   uses 20*log10, BEL uses log10, NEP uses ln, and OCT uses log2.
%
%   LOGMAG = LIN2LOG(LINMAG,MAGFLAG,NANFLAG) uses NANFLAG to handle the
%   case LINMAG = 0. NANFLAG = TRUE replaces 0 with eps(0) to avoid -Inf in
%   LOGMAG. NANFLAG = FALSE ignores 0 in LINMAG. Use NANFLAG = TRUE to get
%   numeric values in LOGMAG. NANFLAG defaults to FALSE when LIN2LOG is
%   called with only two input arguments.
%
%   See also LOG2LIN, LIN2POW, POW2LIN

% 2020 MCaetano SMT 0.1.1
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% TODO: Check inputs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 2
    
    nanflag = false;
    
end

switch lower(magflag)
    
    case 'bel'
        
        magscale = @log10;
        
    case 'dbr'
        
        magscale = @(x) 10*log10(x);
        
    case 'dbp'
        
        magscale = @(x) 20*log10(x);
        
    case 'nep'
        
        magscale = @log;
        
    case 'oct'
        
        magscale = @log2;
        
    otherwise
        
        warning(['SMT:InvalidMagFlag: Invalid Magnitude Scaling Flag.\n'...
            'MAGFLAG must be DBR, DBP, NEP, OCT, or BEL.\n'...
            'MAGFLAG entered was %d. Using default MAGFLAG = DBP'],magflag);
        
        magscale = @(x) 20*log10(x);
        
end

if nanflag
    
    linmag(linmag==0) = eps(0);
    
end

logmag = magscale(linmag);

end
