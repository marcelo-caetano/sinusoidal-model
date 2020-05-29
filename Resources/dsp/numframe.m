function nframe = numframe(nsample,framelen,hop,cfwflag)
%NFRAMES Number of frames
%   F = NUMFRAME(NSAMPLE,M,H,CFWFLAG) returns the number of frames F that a 
%   NSAMPLE-long signal will have when split into overlapping frames of 
%   length M by a hop H and first window centered at CFWFLAG. The string
%   CFWFLAG specifies the sample corresponding to the center of the first 
%   analysis window. CFWFLAG can be ONE, HALF, or NHALF.
%
%   See also NUMSAMPLE

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

switch lower(cfwflag)
    
    case 'one'
        
        offset = 0;
        
    case 'half'
        
        offset = -rhw(framelen) - lhw(framelen);
        
    case 'nhalf'
        
        offset = rhw(framelen) + 1 + lhw(framelen) + 1;
        
    otherwise
        
        warning(['SMT:InvalidFlag: ', 'Flag that specifies the cfwflag of'...
            ' the first analysis window must be ONE, HALF, or NHALF.\n'...
            'CFWFLAG entered was %s. Using default flag ONE'],cfwflag);
        offset = 0;
        
end

% Number of times HOP fits into NSAMPLE (rounded up)
nframe = ceil((nsample + offset) / hop);

end
