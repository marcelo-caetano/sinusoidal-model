function sample = frame2sample(frame,center_win,hop)
%FRAME2SAMPLE Convert frame to sample number.
%   S = FRAME2SAMPLE(F,CENTERWIN,R) returns the samples S at the causalflag of the
%   frames F obtained with an M-sample long sliding window by hops of R
%   samples. The sample S(1) corresponding to the causalflag of the first
%   window is obtained as CENTERWIN = CENTER_FIRST_WIN(M,C), C is a flag that
%   specifies the causalflag of the first window as 'NON', 'CAUSAL', or 'NCAUSAL'.
%
%   See also SAMPLE2FRAME

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% Return sample number (column vector)
sample = center_win + (frame(:) - 1) .* hop;

end
