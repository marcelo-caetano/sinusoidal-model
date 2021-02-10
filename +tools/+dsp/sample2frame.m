function frame = sample2frame(sample,center_win,hop)
%SAMPLE2FRAME Convert sample to frame number.
%   F = SAMPLE2FRAME(S,CENTERWIN,R) returns the frame numbers F for each sample S
%   corresponding to the causalflag of an M-sample long sliding window by hops
%   of R samples. The sample S(1) corresponding to the causalflag of the first
%   window is CENTERWIN = CENTER_FIRST_WIN(M,C), C is a flag that specifies the causalflag of
%   the first window to be 'NON', 'CAUSAL', or 'NCAUSAL'.
%
%   See also FRAME2SAMPLE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.1 $Id


% Return frame number (column vector)
frame = (sample(:) - center_win) ./ hop + 1;

end
