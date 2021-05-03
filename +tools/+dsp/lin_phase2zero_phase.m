function zeroph = lin_phase2zero_phase(linphase,framelen)
%LIN2ZERO Linear phase to zero phase.
%   ZP = LIN2ZERO(LP,WINLEN) flips the linear phase signal LP around
%   the causalflag CW of the window with WINLEN samples. CW = CENTERWIN(W,'CAUSAL').
%
%   See also ZERO2LIN, FFTFLIP, IFFTFLIP

% 2016 MCaetano
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Revised for stereo)
% $Id 2021 M Caetano SM 0.6.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Left half of the window
winleft = tools.dsp.leftwin(framelen);

% Flip left and right halves
zeroph = [linphase(winleft+1:end,:,:);linphase(1:winleft,:,:)];

end
