function rh = rightwin(framelen)
%RIGHTWIN Right half of analysis window.
%   RH = RIGHTWIN(M) returns the length RH in samples of the right half of
%   an M-sample long window generated with GENCOLAWIN. RIGHTWIN excludes
%   the sample at the center of the window with sample position CW, so
%   M = LH + 1 + RH, where LH is the length of the left half of the window.
%   For odd M (symmetric around CW), LH = RH = H and M = 2*(H) + 1. For
%   even M (not symmetric around CW), RIGHTWIN = LEFTWIN - 1 and
%   M = 2*LH = 2*RH + 1. Consequently, CW is always an integer number of
%   samples because CW = LH + 1 = M - RH.
%
%   See also LEFTWIN, CENTERWIN, MKCOLAWIN

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2021 M Caetano SM 0.7.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check length of window and make RH accordingly
if tools.misc.iseven(framelen)
    
    rh = framelen/2-1;
    
else
    
    rh = (framelen-1)/2;
    
end

end
