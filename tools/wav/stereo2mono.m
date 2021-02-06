function [mono] = stereo2mono(stereo)
%STEREO2MONO Dowmix stereo audio to mono.
%   M = stereo2mono(S) downmixes stereo audio in S into mono audio in M.
%
%   S has one channel per column as returned by audioread. So S is L by N,
%   where L is the length of the audio file (total number of samples) and
%   N is the number of channels.
%
%   M = S when N = 1. M = 0.5*S(:,1)+0.5*S(:,2) when N=2. Finally,
%   stereo2mono returns an error whenever N>2.
%
%   See also downmix, audioread

% 2016 MCaetano (Revised)
% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0
% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


[~,nchannel] = size(stereo);

if isequal(nchannel,2)
    
    % Downmix from stereo to mono
    mono = 0.5*stereo(:,1) + 0.5*stereo(:,2);
    
elseif isequal(nchannel,1)
    
    % Bypass
    mono = stereo;
    
else
    
    error('WrongNumChan: Wrong number of Channels')
    
end

end
