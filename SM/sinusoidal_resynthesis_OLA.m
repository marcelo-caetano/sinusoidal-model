function [sinusoidal,partials,amplitudes,phases] = sinusoidal_resynthesis_OLA...
    (amp,freq,phase,framesize,hop,fs,nsample,cframe,winflag,cfwflag,dispflag)
%SINUSOIDAL_RESYNTHESIS_PI Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number if input arguments
narginchk(10,11);

if nargin == 10
    
    dispflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of time_frames
nframe = length(cframe);

% Initialize variables
time_frames = zeros(framesize,nframe);
partials = cell(nframe,1);
amplitudes = cell(nframe,1);
phases = cell(nframe,1);

for iframe = 1:nframe
    
    if dispflag
        
        fprintf(1,'OLA synthesis frame %d of %d\n',iframe,nframe);
        
    end
    
    [time_frames(:,iframe),partials{iframe},amplitudes{iframe},phases{iframe}] = ...
        stationary_synthesis(amp{iframe},freq{iframe},phase{iframe},framesize,fs,cframe(iframe),winflag);
    
end

% Overlap-add time_frames
olasin = ola(time_frames,framesize,hop,nsample,cframe,winflag,cfwflag);

% Scaling factor
sc = colasum(winflag)*(framesize/2)/hop;

% Scale OLA
sinusoidal = olasin/sc;

% Get frequencies as derivative of phases
% frequencies = gradient(phases);

end
