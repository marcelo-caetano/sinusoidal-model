function zero_phase = lp2zp(linear_phase,winlen)
%LP2ZP Linear phase to zero phase.
%   ZP = LP2ZP(LP,WINLEN) flips the linear phase signal LP around
%   the center CW of the window with WINLEN samples. CW = CFW(W,'HALF').
%
%   See also ZP2LP, FFTFLIP, IFFTFLIP

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% Left half of the window
leftwin = lhw(winlen);

% Flip left and right halves
zero_phase = [linear_phase(leftwin+1:end,:);linear_phase(1:leftwin,:)];

end
