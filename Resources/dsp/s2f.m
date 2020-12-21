function frame = s2f(sample,cfw,hopsize)
%S2F Sample to frame.
%
%   F = S2F(S,CFW,R) returns the frame numbers F for each sample S
%   corresponding to the center of an M-sample long sliding window by hops 
%   of R samples. The sample S(1) corresponding to the center of the first
%   window is CFW = cfw(M,C), C is a flag that specifies the center of 
%   the first window to be 'ONE', 'HALF', or 'NHALF'.
%   
%   See also F2S

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% Return frame number (column vector)
frame = (sample(:) - cfw) ./ hopsize + 1;

end
