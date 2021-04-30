function nframe = numframe(nsample,framelen,hop,causalflag)
%NFRAMES Number of frames.
%   F = NUMFRAME(NSAMPLE,M,H,CAUSALFLAG) returns the number of frames F that a
%   NSAMPLE-long signal will have when split into overlapping frames of
%   length M by a hop H and first window causalflaged at CAUSALFLAG. The string
%   CAUSALFLAG specifies the sample corresponding to the causalflag of the first
%   analysis window. CAUSALFLAG can be CAUSAL, NON, or ANTI.
%
%   See also NUMSAMPLE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% Offset for causal processing
offset = tools.dsp.causal_offset(framelen,causalflag);

% Number of times HOP fits into NSAMPLE (rounded up)
nframe = ceil((nsample + offset) / hop);

end
