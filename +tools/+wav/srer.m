function rms_db = srer(sig,res,lmsflag)
%SRER Calculate the signal-to-resynthesis energy ratio.
%   E = SRER(S,R) returns the signal-to-resynthesis energy ratio E in dB
%   power between the signal S and the residual R. The SRER is defined as
%   E = 20*log10[RMS(S)/RMS(R)] dB. The residual R is obtained as
%   R = S - \hat(S), where \hat(S) is S resynthesized after a modeling
%   step. SRER works with mono, stereo, or multi-channel signals assuming
%   that each channel is a column of S.
%
%   E = SRER(S,R,LMSFLAG) uses LMSFLAG to determine the logarithmic scale
%   used in E. LMSFLAG can be 'DBR' for decibel root-power, 'DBP' for
%   decibel power, 'BEL' for bels, 'NEP' for neper, and 'OCT' for octave.
%   See HELP LIN2LOG for further details.
%
%   See also LIN2LOG, RMSDB

% 2021 M Caetano SMT 0.3.2% $Id 2021 M Caetano SM 0.5.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

% Default to dB power
if nargin == 2
    
    lmsflag = 'dbp';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Root-mean-squared signal
rms_sig = std(sig);

% Root-mean-squared residual
rms_res = std(res);

% Ratio of RMS
rms_ratio = rms_sig ./ rms_res;

% Logarithmic RMS ratio
rms_db = tools.dsp.lin2log(rms_ratio,lmsflag);

end
