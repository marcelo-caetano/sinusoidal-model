function logmag = sm_lin2log(linmag,lmsflag,nanflag)
%LIN2LOG Convert from linear to log amplitude.
%   LOGMAG = LIN2LOG(LINMAG,LMSFLAG) scales the linear magnitude spectrum
%   LINMAG to the logarithmic scale specified by the string LMSFLAG, which
%   can be 'DBR' for decibel root-power, 'DBP' for decibel power, 'BEL' for
%   bels, 'NEP' for neper, and 'OCT' for octave. DBR uses 10*log10, DBP 
%   uses 20*log10, BEL uses log10, NEP uses ln, and OCT uses log2.
%
%   LOGMAG = LINS2LOG(LINMAG,LMSFLAG,NANFLAG) uses NANFLAG to handle the
%   case LINMAG = 0. NANFLAG = TRUE replaces 0 with eps(0) to avoid -Inf in
%   LOGMAG. NANFLAG = FALSE ignores 0 in LINMAG. Use NANFLAG = TRUE to get 
%   numeric values in LOGMAG. NANFLAG defaults to FALSE when LIN2LOG is 
%   called with only two input arguments.
%
%   See also LOG2LIN

% 2020 MCaetano SMT 0.1.1
% TODO: Check inputs% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    nanflag = false;
    
end

switch lower(lmsflag)
    
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
            'LMSFLAG must be DBR, DBP, NEP, OCT, or BEL.\n'...
            'LMSFLAG entered was %d. Using default LMSFLAG = DBP'],lmsflag);
        
        magscale = @(x) 20*log10(x);
        
end

if nanflag
    
    linmag(linmag==0) = eps(0);
    
end

logmag = magscale(linmag);

end
