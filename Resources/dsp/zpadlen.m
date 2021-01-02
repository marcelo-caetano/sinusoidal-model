function shift = zpadlen(framelen,cfwflag)
%ZPADLEN Zero-pad length at start and end of signal for frame processing.
%   [SHIFT] = ZPADLEN(FRAMELEN,CFWFLAG) returns the length SHIFT of zero-padding
%   at the beginning and end of the signal to compensate for the position
%   of the center of the first window. FRAMELEN is the length of each
%   frame. CFWFLAG is a flag that determines the center of the first
%   analysis window. CFWFLAG can be 'ONE', 'HALF', or 'NHALF'. The sample
%   CFW corresponding to the center of the first window is obtained as
%   CFW = cfw(M,CFWFLAG). Type help cfw for further details.
%
%   ZPADLEN is meant to be used with other frame-based processing functions
%   such as OLA, SINUSOIDAL_RESYNTHESIS_OLA, SINUSOIDAL_RESYNTHESIS_PI,
%   and SINUSOIDAL_RESYNTHESIS_PRFI.
%
%   See also OLA, SINUSOIDAL_RESYNTHESIS_OLA, SINUSOIDAL_RESYNTHESIS_PI, SINUSOIDAL_RESYNTHESIS_PRFI

% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.3.1-alpha.4 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number if input arguments
narginchk(2,2);

% Check number if output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(cfwflag)
    
    case 'one'
        
        % SHIFT is the number of zeros at the beginning and end
        shift = lhw(framelen);
        
    case 'half'
        
        % SHIFT is the number of zeros at the beginning and end
        shift = 0;
        
    case 'nhalf'
        
        % SHIFT is the number of zeros at the beginning and end
        shift = framelen;
        
    otherwise
        
        warning(['SMT:InvalidFlag: ','CFWFLAG must be ONE, HALF, or NHALF.\n'...
            'CFWFLAG entered was %s. Using default value ONE'],cfwflag);
        
        % SHIFT is the number of zeros at the beginning and end
        shift = lhw(framelen);
        
end

end
