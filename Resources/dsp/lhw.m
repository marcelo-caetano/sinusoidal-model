function lh = lhw(winlen)
%LHW Left half window.
%   LH = LHW(WINLEN) calculates the length LH in samples of the left
%   half of a WINLEN long window generated with MKCOLAWIN. LHW excludes 
%   the sample at the center of the window with sample position CW.
%   Thus WINLEN = LH + 1 + RH, where RH is the length of the right
%   half of the window.
%   For odd WINLEN (symmetric around CW), LH = RH = H and
%   WINLEN = 2*(H) + 1.
%   For even WINLEN (not symmetric around CW, RH = LH - 1 and
%   WINLEN = 2*LH = 2*RH + 1.
%   Consequently, CW is always an integer number of samples because
%   CW = LH + 1 = WINLEN - RH.
%
%   See also RHW, CFW, MKCOLAWIN

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% The periodic flag is useful for spectral analysis.
%
% Because there is an implicit periodic extension in the DFT/FFT,
% the periodic flag enables a signal that is windowed with a periodic
% window to have perfect periodic extension.
% When using windows for spectral analysis or other DFT/FFT purposes,
% the periodic option can be useful. When using windows for filter design,
% the symmetric flag should be used.

% Check length of window and make LH accordingly
if iseven(winlen)
    
    lh = winlen/2;
    
else
    
    lh = (winlen-1)/2;
    
end

end
