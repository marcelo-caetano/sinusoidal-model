function [addsynth,partials,amplitude,phase_argument] = stationary_synthesis(amp,freq,ph,framesize,fs,cframe,winflag)
%STATIONARY_SYNTHESIS synthesize stationary sinusoid inside frame.
%   [Add] = STATIONARY_SYNTHESIS(A,F,P,M,Fs,WINTYPE,CFRAME)
%   Synthesize each partial as s(n) = A*cos(2*pi*F*T/SR + Theta)
%   Theta is the ph shift calculated as Theta = P - 2*pi*f*T/SR

% 2017 M Caetano; Revised 2019

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(7,7);

% Check number of output arguments
nargoutchk(0,5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of partials
npartial = length(amp);

% Make samples spanning frame framesize
samples = (cframe-lhw(framesize):cframe+rhw(framesize))';

% Make analysis window
synthwin = mkcolawin(framesize,winflag);

% Initialize variables
partials = zeros(framesize,npartial);
amplitude = zeros(framesize,npartial);
phase_argument = zeros(framesize,npartial);
addsynth = zeros(framesize,1);
phase_shift = zeros(npartial,1);

for ipartial = 1:npartial
    
    % Synthesize constant amplitude vector
    % amplitude(:,ipartial) = 2*amp(ipartial)*ones(framesize,1);
    
    % Calculate ph shift (using center of frame as reference)
    phase_shift(ipartial) = ph(ipartial) - freq(ipartial)*2*pi*cframe/fs;
    
    % Synthesize ph argument
    phase_argument(:,ipartial) = freq(ipartial)*2*pi*samples/fs + phase_shift(ipartial);
    
    % Synthesize partial
    % partials(:,ipartial) = 2*amp(ipartial)*cos(phase_argument(:,ipartial));
    partials(:,ipartial) = amp(ipartial)*cos(phase_argument(:,ipartial));
    
    % Add partial to final synthesis
    addsynth = addsynth + partials(:,ipartial);
    
end

addsynth = addsynth.*synthwin;

end
