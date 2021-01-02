function [freq] = note2freq(note,ref)
%NOTE2FREQ Convert note in German system to frequency in Hertz.
%   F = NOTE2FREQ(NOTE,REF) returns the frequency in Hertz corresponding
%   to N steps above the reference REF Hz using the conversion F = REF*A^N,
%   where A = 2^(1/12) for the equal tempered scale.
%
%   F = STEP2FREQ(N) uses REF = 440 Hz as reference for A4.
%
%   NOTE must be a character array in the following format: LETTER(OPT)NUMBER
%   LETTER specifies the pitch class between A and G
%   OPT specifies that the pitch class is sharp (omit otherwise)
%   NUMBER specifies the octave between 0 and 8
%
%   Examples: A#3, G7, D0, F#6
%
%   See also FREQ2STEP, NOTE2FREQ, FREQ2NOTE

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% $Id 2020 M Caetano SM 0.3.1-alpha.4 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
if nargin > 2
    
    error('NumInArg:wrongNumber',['Wrong Number of Input Arguments.\n'...
        'NOTE2FREQ takes 1 or 2 input arguments.\n'...
        'Type HELP NOTE2FREQ for more information.\n'])
    
end

switch nargin
    
    case 1
        
        % Check input argument type
        if not(ischar(note))
            
            error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
                'NOTE must be class CHAR not %s.\n'...
                'Type HELP NOTE2FREQ for more information.\n'],class(note))
            
        end
        
    case 2
        
        % Check input argument type
        if not(ischar(note))
            
            error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
                'NOTE must be class CHAR not %s.\n'...
                'Type HELP NOTE2FREQ for more information.\n'],class(note))
            
        end
        
        % Check input argument type
        if not(isnumeric(ref))
            
            error('TypeInArg:wrongType',['Wrong Type of Input Argument.\n'...
                'REF must be class NUMERIC not %s.\n'...
                'Type HELP NOTE2FREQ for more information.\n'],class(ref))
            
        end
        
end

% Check that pitch class is between A(=65) and G(=71)
if double(note(1)) < 65 || double(note(1)) > 71
    
    error('ValInArg:outBound',['Input argument out of bounds.\n'...
        'NOTE(1) must be between A and G.\n'...
        'Type HELP NOTE2FREQ for more information.\n'])
    
end

% Check that octave is between 0 and 8
if str2double(note(end)) < 0 || str2double(note(end)) > 8
    
    error('ValInArg:outBound',['Input argument out of bounds.\n'...
        'NOTE(end) must be between 0 and 8.\n'...
        'Type HELP NOTE2FREQ for more information.\n'])
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convert from note (German system) to number of steps in equal tempered scale
step = note2step(note);

% Convert from number of steps in equal tempered scale to frequency in Hertz
if nargin == 2
    
    freq = step2freq(step,ref);
    
else
    
    freq = step2freq(step);
    
end

end
