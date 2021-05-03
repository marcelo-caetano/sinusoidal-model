function rms_db = srer(sig,res,logflag,nanflag)
%SRER Calculate the signal-to-resynthesis energy ratio.
%   E = SRER(S,R) returns the signal-to-resynthesis energy ratio E in dB
%   power between the signal S and the residual R. The SRER is defined as
%   E = 20*log10[RMS(S)/RMS(R)] dB. The residual R is obtained as
%   R = S - \hat(S), where \hat(S) is S resynthesized after a modeling
%   step. SRER works with mono, stereo, or multi-channel signals assuming
%   that each channel is a column of S.
%
%   E = SRER(S,R,LOGFLAG) uses LOGFLAG to determine the logarithmic scale
%   used in E. LOGFLAG can be 'DBR' for decibel root-power, 'DBP' for
%   decibel power, 'BEL' for bels, 'NEP' for neper, and 'OCT' for octave.
%   See HELP LIN2LOG for further details.
%
%   See also LIN2LOG, RMSDB

% 2021 M Caetano SMT (Revised)
% $Id 2021 M Caetano SM 0.6.0-alpha.1 $Id


%   TODO: Add flag GLOBAL or LOCAL to control SRER

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,4);

% Check number of output arguments
nargoutchk(0,1);

% Default to dB power
if nargin == 2
    
    logflag = 'dbp';
    
    nanflag = false;
    
elseif nargin == 3
    
    nanflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get size of input
[~,nframe,nchannel] = size(sig);

% Root-mean-squared signal
rms_sig = std(sig);

% Reshape as columns
rms_sig = reshape(rms_sig,[nframe,nchannel]);

% Root-mean-squared residual
rms_res = std(res);

% Reshape as columns
rms_res = reshape(rms_res,[nframe,nchannel]);

if nanflag
    
    % Logical indices of zeros
    bool = rms_res == 0;
    
    % Replace 0 to avoid NaN
    rms_res(bool) = realmin;
    
end

% Ratio of RMS
rms_ratio = rms_sig ./ rms_res;

% Logarithmic RMS ratio
rms_db = tools.math.lin2log(rms_ratio,logflag);

end
