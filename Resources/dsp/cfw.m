function center = cfw(framelen,cfwflag)
%CFW Center of the first window in signal reference (samples).
%   [C] = CFW(WINSIZE,CENTER) returns the sample C at the CENTER of the
%   first analysis window with WINSIZE samples.
%
%   CFW returns the sample corresponding to the analysis time
%
%   See also RHW, LHW

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% The periodic flag is useful for DFT/FFT purposes such as in spectral analysis.
%
% Because there is an implicit periodic extension in the DFT/FFT,
% the periodic flag enables a signal that is windowed with a periodic window to have perfect periodic extension.
% When using windows for spectral analysis or other DFT/FFT purposes,
% the periodic option can be useful. When using windows for filter design, the symmetric flag should be used.

switch lower(cfwflag)
    
    case 'one'
        
        center = 1;
        
    case 'half'
        
        center = lhw(framelen) + 1;
        
    case 'nhalf'
        
        center = -rhw(framelen);
        
    otherwise
        
        center = 1;
        warning(['SMT:InvalidFlag: ','CFWFLAG must be ONE, HALF, or NHALF.\n'...
            'CFWFLAG entered was %s. Using default value ONE'],cfwflag);
        
end

end

