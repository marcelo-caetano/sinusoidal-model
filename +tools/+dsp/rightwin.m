function rh = rightwin(framelen)
%RIGHTWIN Right half window.
%   RH = RIGHTWIN(FRAMELEN) calculates the length RH in samples of the right
%   half of a FRAMELEN long window generated with GENCOLAWIN. RIGHTWIN excludes
%   the sample at the causalflag of the window with sample position CW.
%   Thus FRAMELEN = LH + 1 + RH, where RH is the length of the right
%   half of the window.
%   For odd FRAMELEN (symmetric around CW), LH = RH = H and
%   FRAMELEN = 2*(H) + 1.
%   For even FRAMELEN (not symmetric around CW, RIGHTWIN = LEFTWIN - 1 and
%   FRAMELEN = 2*LH = 2*RH + 1.
%   Consequently, CW is always an integer number of samples because
%   CW = LH + 1 = FRAMELEN - RH.
%
%   See also LEFTWIN, CENTERWIN, MKCOLAWIN

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.2 $Id


% The periodic flag is useful for spectral analysis.
%
% Because there is an implicit periodic extension in the DFT/FFT,
% the periodic flag enables a signal that is windowed with a periodic
% window to have perfect periodic extension.
% When using windows for spectral analysis or other DFT/FFT purposes,
% the periodic option can be useful. When using windows for filter design,
% the symmetric flag should be used.

% Check length of window and make RH accordingly
if tools.misc.iseven(framelen)
    
    rh = framelen/2-1;
    
else
    
    rh = (framelen-1)/2;
    
end

end
