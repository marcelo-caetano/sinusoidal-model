function inyq = nyq_freq(nfft,nyqflag)
%NYQ_FREQ Return array index corresponding to Nyquist frequency.
%   N = NYQ_FREQ(NFFT) returns the array index corresponding to the
%   Nyquist frequency of an FFT with size NFFT.
%
%   N = NYQ_FREQ(NFFT,NYQFLAG) uses the character vector NYQFLAG to output
%   either the frequency bin or the array index (the default). NYQFLAG =
%   'BIN' outputs the frequency bin whereas NYQFLAG = 'IND' outputs the
%   array index.
%
%   See also MKFREQ, BIN2FREQ, FREQ2BIN

% 2020 MCaetano SMT 0.1.1% $Id 2021 M Caetano SM 0.5.0-alpha.1 $Id


%TODO: CHECK INPUT ARGUMENTS (integer and power of 2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    nyqflag = 'ind';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(nyqflag)
    
    case 'bin'
        
        % Bin number corresponding to Nyquist
        inyq = nfft/2;
        
    case 'ind'
        
        % Array index corresponding to Nyquist
        inyq = nfft/2 + 1;
        
    otherwise
        
        % Array index corresponding to Nyquist
        inyq = nfft/2 + 1;
        
end

end
