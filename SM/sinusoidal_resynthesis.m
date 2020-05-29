function [sinusoidal,partials,amplitudes,frequencies] = sinusoidal_resynthesis...
    (amp,freq,phase,delta,framelen,hop,fs,nsample,cframe,maxnpeak,...
    winflag,cfwflag,synthflag,dispflag)
%SINUSOIDAL_RESYNTHESIS Resynthesis from the output of sinusoidal analysis [1].
%   [SIN,PART,AMP,FREQ] = SINUSOIDAL_RESYNTHESIS(A,F,P,DELTA,M,H,FS,...
%   NSAMPLE,CFR,MAXNPEAK,WINFLAG,CFWFLAG,SYNTHFLAG,DISPFLAG)
%   resynthesizes the sinusoidal model SIN from the output parameters of
%   SINUSOIDAL_ANALYSIS (A,F,P), where A=amplitudes, F=frequencies, and
%   P=phases estimated with a hop H and a frame size of M. DELTA
%   determines the frequency difference for peak continuation as described
%   in [1].
%
% [1] McAulay and Quatieri (1986) Speech Analysis/Synthesis Based on a
% Sinusoidal Representation, IEEE TRANSACTIONS ON ACOUSTICS, SPEECH,
% AND SIGNAL PROCESSING, VOL. ASSP-34, NO. 4.

% 2016 M Caetano
% Revised 2019 (SM 0.1.1)
% 2020 MCaetano SMT 0.1.1 (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

narginchk(13,14);

if nargin == 13
    
    dispflag = false;
    
end

% Check number of input arguments
% if nargin == 13
%
%     dblevel = 0;
%
% elseif nargin ~= 14
%
%     error('NumInArg:wrongNumber',['Wrong Number of Input Arguments.\n'...
%         'NORMDB takes 3 input arguments.\n'...
%         'Type HELP NORMDB for more information.\n'])
%
% end

% % Check type of input argument
% if not(isnumeric(dblevel))
%
%     error('TypeArg:wrongType',['Wrong Type of Input Argument.\n'...
%         'DBLEVEL must be class NUMERIC not %s.\n'...
%         'Type HELP NORMDB for more information.\n'],class(flag))
%
% end
%
% % Check type of input argument
% if not(ischar(flag))
%
%     error('TypeArg:wrongType',['Wrong Type of Input Argument.\n'...
%         'FLAG must be class CHAR not %s.\n'...
%         'Type HELP NORMDB for more information.\n'],class(flag))
%
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(synthflag)
    
    case 'ola'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % OVERLAP ADD
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Overlap-Add Resynthesis')
        
        [sinusoidal,partials,amplitudes,frequencies] = sinusoidal_resynthesis_OLA...
            (amp,freq,phase,framelen,hop,fs,nsample,cframe,winflag,cfwflag,dispflag);
        
    case 'pi'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % PARAMETER INTERPOLATION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Resynthesis by Parameter Interpolation')
        
        [sinusoidal,partials,amplitudes,frequencies] = sinusoidal_resynthesis_PI...
            (amp,freq,phase,delta,framelen,hop,fs,nsample,cframe,maxnpeak,cfwflag,dispflag);
        
        
    case 'prfi'
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ADDITIVE RESYNTHESIS WITHOUT PHASE
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        disp('Resynthesis by Phase Reconstruction via Frequency Integration')
        
        [sinusoidal,partials,amplitudes,frequencies] = sinusoidal_resynthesis_PRFI...
            (amp,freq,delta,framelen,hop,fs,nsample,cframe,maxnpeak,cfwflag,dispflag);
        
    otherwise
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % PARAMETER INTERPOLATION
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        warning(['NoSynthFlag: ', 'Undefined synthesis flag.\n'...
            'Synthesis flag entered was %s.\n'...
            'Using default PI (parameter interpolation) synthesis'],synthflag)
        
        disp('Resynthesis by Parameter Interpolation')
        
        [sinusoidal,partials,amplitudes,frequencies] = sinusoidal_resynthesis_PI...
            (amp,freq,phase,delta,hop,framelen,fs,nsample,cframe,maxnpeak,cfwflag,dispflag);
        
end

end
