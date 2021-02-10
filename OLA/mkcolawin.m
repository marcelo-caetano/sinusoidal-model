function win = mkcolawin(framelen,winflag)
%MKCOLAWIN Make COLA window.
%   W = MKCOLAWIN(WINLEN,WINFLAG) makes a window W that is WINLEN samples
%   long and that has the constant overlap-add (COLA) property. The flag
%   WINFLAG controls the window type. The possibilities for WINFLAG are:
%
%   1 - Rectangular
%   2 - Bartlett
%   3 - Hann
%   4 - Hanning
%   5 - Blackman
%   6 - Blackman-Harris
%   7 - Hamming
%
%   The window W is carefully designed to be COLA and to ensure that the
%   causalflag of W is an integer sample number. Consequently, even WINLEN
%   results in periodic windows, whereas odd WINLEN results in symmetric
%   windows. See the help for each window given by WINFLAG for further
%   information.
%
%   See also COLADEN, COLASUM, ISCOLA, COLAHOPSIZE, OVERLAP2HOPSIZE

% 2016 M Caetano
% 2019 MCaetano (Revised)
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2021 M Caetano SM 0.5.0-alpha.2 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

% Check WINLEN
if ~isnumeric(framelen)
    
    error('SMT:WrongWindowLength',['The window length must be numeric. '...
        'The window length entered is class %s.\n'],class(framelen))
    
elseif tools.misc.isfrac(framelen)
    
    error('SMT:WrongWindowLength',['The window length must be integer. '...
        'The window length entered is %f.\n'],framelen)
    
elseif framelen <= 0
    
    error('SMT:WrongWindowLength',['The window length must be positive. '...
        'The window length entered is %d.\n'],framelen)
    
end

% Check WINFLAG
if ~isnumeric(winflag)
    
    error('SMT:UnknownWindowFlag',['The window flag must be numeric. '...
        'The window flag entered is class %s.\n'],class(winflag))
    
elseif tools.misc.isfrac(winflag)
    
    error('SMT:UnknownWindowFlag',['The window flag must be integer. '...
        'The window flag entered is %f.\n'],winflag)
    
elseif winflag < 1 || winflag > 7
    
    warning('SMT:UnknownWindowFlag',['The flag entered is out of '...
        'the range [1,...,7].\n Using default HANN window.\n']);
    
    % Hann window
    winflag = 3;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BODY OF FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if tools.misc.iseven(framelen)
    
    % Even window length
    wflag = 'periodic';
    
else
    
    % Odd window length
    wflag = 'symmetric';
    
end

% Type of window
switch winflag
    
    case 1
        
        % RECTANGULAR
        win = rectwin(framelen);
        
    case 2
        
        % BARTLETT
        if tools.misc.iseven(framelen)
            win = bartlett(framelen+1);
            win(end)=[];
        else
            win = bartlett(framelen);
        end
        
    case 3
        
        % HANN
        win = hann(framelen,wflag);
        
    case 4
        
        % HANNING (OLA > 1)
        win = hanning(framelen,wflag);
        
    case 5
        
        % BLACKMAN
        win = blackman(framelen,wflag);
        
    case 6
        
        % BLACKMAN-HARRIS
        win = blackmanharris(framelen,wflag);
        
        if tools.misc.isodd(framelen)
            win(1) = win(1)/2;
            win(end) = win(end)/2;
        end
        
    case 7
        
        % HAMMING (OLA > 1)
        win = hamming(framelen,wflag);
        
        if tools.misc.isodd(framelen)
            win(1) = win(1)/2;
            win(end) = win(end)/2;
        end
        
end

end
