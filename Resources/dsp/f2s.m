function sample = f2s(frame,cfw,hopsize)
%F2S Frame to sample.
%
%   S = F2S(F,CFW,R) returns the samples S at the center of the frames F 
%   obtained with an M-sample long sliding window by hops of R samples.
%   The sample S(1) corresponding to the center of the first window is
%   obtained as CFW = cfw(M,C), C is a flag that specifies the center of 
%   the first window to be 'ONE', 'HALF', or 'NHALF'.
%   
%   See also S2F

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2020 M Caetano SM 0.3.1-alpha.4 $Id


% Return sample number (column vector)
sample = cfw + (frame(:) - 1) .* hopsize;

end
