function win = sm_mkcolawin(winlen,winflag)
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
%   center of W is an integer sample number. Consequently, even WINLEN
%   results in periodic windows, whereas odd WINLEN results in symmetric
%   windows. See the help for each window given by WINFLAG for further
%   information.
%
%   See also COLADEN, COLASUM, ISCOLA, COLAHS, OL2HS

% 2016 M Caetano
% 2019 MCaetano (Revised)
% 2020 MCaetano SMT 0.1.1 (Revised)
% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,1);

% Check WINLEN
if ~isnumeric(winlen)
    
    error('SMT:WrongWindowLength',['The window length must be numeric. '...
        'The window length entered is class %s.\n'],class(winlen))
    
elseif ~isint(winlen)
    
    error('SMT:WrongWindowLength',['The window length must be integer. '...
        'The window length entered is %f.\n'],winlen)
    
elseif winlen <= 0
    
    error('SMT:WrongWindowLength',['The window length must be positive. '...
        'The window length entered is %d.\n'],winlen)
    
end

% Check WINFLAG
if ~isnumeric(winflag)
    
    error('SMT:UnknownWindowFlag',['The window flag must be numeric. '...
        'The window flag entered is class %s.\n'],class(winflag))
    
elseif ~isint(winflag)
    
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

if sm_iseven(winlen)
    
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
        win = rectwin(winlen);
        
    case 2
        
        % BARTLETT
        if sm_iseven(winlen)
            win = bartlett(winlen+1);
            win(end)=[];
        else
            win = bartlett(winlen);
        end
        
    case 3
        
        % HANN
        win = hann(winlen,wflag);
        
    case 4
        
        % HANNING (OLA > 1)
        win = hanning(winlen,wflag);
        
    case 5
        
        % BLACKMAN
        win = blackman(winlen,wflag);
        
    case 6
        
        % BLACKMAN-HARRIS
        win = blackmanharris(winlen,wflag);
        
        if sm_isodd(winlen)
            win(1) = win(1)/2;
            win(end) = win(end)/2;
        end
        
    case 7
        
        % HAMMING (OLA > 1)
        win = hamming(winlen,wflag);
        
        if sm_isodd(winlen)
            win(1) = win(1)/2;
            win(end) = win(end)/2;
        end
        
end

end
