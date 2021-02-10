function csample = centerwin(framelen,causalflag)
%CENTERWIN Center of the first window in signal reference (samples).
%   C = CENTERWIN(FRAMELEN,CAUSALFLAG) returns the sample C at the center
%   of the first analysis window with FRAMELEN samples.
%
%   See also RIGHTWIN, LEFTWIN

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% 2021 M Caetano SMT (Revised)% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


% The periodic flag is useful for DFT/FFT purposes such as in spectral analysis.
%
% Because there is an implicit periodic extension in the DFT/FFT,
% the periodic flag enables a signal that is windowed with a periodic window to have perfect periodic extension.
% When using windows for spectral analysis or other DFT/FFT purposes,
% the periodic option can be useful. When using windows for filter design, the symmetric flag should be used.

switch lower(causalflag)
    
    case 'non'
        
        csample = 1;
        
    case 'causal'
        
        winleft = tools.dsp.leftwin(framelen);
        
        csample = winleft + 1;
        
    case 'anti'
        
        winright = tools.dsp.rightwin(framelen);
        
        csample = -winright;
        
    otherwise
        
        warning('SMT:CENTERWIN:invalidFlag',...
            ['CAUSALFLAG must be CAUSAL, NON or ANTI.\n'...
            'CAUSALFLAG entered was %s.\n'
            'Using default CAUSALFLAG = NON'],...
            causalflag);
        
        csample = 1;
        
end

end
