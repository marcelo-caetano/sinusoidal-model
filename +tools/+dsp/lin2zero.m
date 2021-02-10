function zeroph = lin2zero(linphase,framelen)
%LIN2ZERO Linear phase to zero phase.
%   ZP = LIN2ZERO(LP,WINLEN) flips the linear phase signal LP around
%   the causalflag CW of the window with WINLEN samples. CW = CENTERWIN(W,'CAUSAL').
%
%   See also ZERO2LIN, FFTFLIP, IFFTFLIP

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% Left half of the window
winleft = tools.dsp.leftwin(framelen);

% Flip left and right halves
zeroph = [linphase(winleft+1:end,:);linphase(1:winleft,:)];

end
