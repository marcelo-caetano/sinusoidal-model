function t = mktime(varargin)
%MKTIME Make time vector in seconds.
%   T = MKTIME(L,SR) makes a time vector T in seconds corresponding to the
%   length L in samples using the sample rate SR as T = (0:L-1)/SR.
%
%   T = MKTIME(S,E,SR) makes a time vector in seconds between the start
%   sample S and the end sample E using the sample rate SR as
%   T = (S-1:E-1)/SR.
%
%   See also MKFREQ

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% TODO: CHECK CLASS OF INPUT (ISNUMERIC)

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

% Initialize START_SAMPLE and END_SAMPLE
if nargin == 2
    
    start_sample = 1;
    end_sample = varargin{1};
    fs = varargin{2};
    
else
    
    start_sample = varargin{1};
    end_sample = varargin{2};
    fs = varargin{3};
    
end

% Generate samples from START_SAMPLE to END_SAMPLE
samples = (start_sample:end_sample)';

% Generate time in seconds
t = (samples-1)/fs;

end
