function [amp,freq,ph] = track2peak(amptrack,freqtrack,phasetrack,nframe,dispflag)
%TRACK2PEAK Convert frequency track to spectral peak representation.
%   [A,F,P] = TRACK2PEAK(At,Ft,Pt,NFRAME,DISPFLAG)
%
%   See also PEAK2TRACK

% 2020 MCaetano SMT 0.1.1 (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,5);

% Check number of output arguments
nargoutchk(0,3);

if nargin == 4
    
    dispflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

amp = cell(nframe,1);
freq = cell(nframe,1);
ph = cell(nframe,1);

for iframe = 1:nframe
    
    if dispflag
        
        fprintf(1,'Analyzing frame %d of %d\n',iframe,nframe);
        
    end
    
    amp{iframe} = amptrack(not(isnan(amptrack(:,iframe))),iframe);
    freq{iframe} = freqtrack(not(isnan(freqtrack(:,iframe))),iframe);
    ph{iframe} = phasetrack(not(isnan(phasetrack(:,iframe))),iframe);
    
end

end
