function [fig,figaxes,wavform,timelbl,amplbl,titlelbl] = plotwav(timesample,wav)
%PLOTWAV Plot waveform.
%   [FIG,FIGAXES,SPECGRAM,AMPLBL,TIMELBL,AMPLBL,TTL] = PLOTWAV(T,W)
%
%   Input arguments:
%
%   T sample time vector (s)
%   W waveform (Normalized)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrogram
%   FIGAXES axes objects associated with FIG
%   WAVFORM handle to the line plot object
%   TIMELBL handle to the text object used as time label
%   AMPLBL handle to the text object used as amplitude label
%   TTL handle to the text object used as title
%
%   See also PLOTSPEC, PLOTSPECTROGRAM, PLOTPEAKGRAM, PLOTPARTTRACK, PLOTSPECTROPEAKGRAM

% 2020 MCaetano SMT 0.2.0
% $Id 2021 M Caetano SM 0.7.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,2);

% Check number of output arguments
nargoutchk(0,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT PARAMETERS OF THE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Font Name ( type 'listfonts' for available system fonts)
% font = 'Times';

% Background color
bckgdc = [1 1 1]; % white

% Waveform color
grey = [0.5 0.5 0.5]; %grey

% Line style
linsty = '-';

% Line width
lwidth = 1;

% Time axis
tlbl = 'Time (s)';

% Amplitude axis
albl = 'Amplitude (Normalized)';

% Title
ttl = 'Waveform';

% Time limits
tmin = timesample(1);
tmax = timesample(end);

% Frequency limits
amin = min(wav,[],'all','omitnan');
amax = max(wav,[],'all','omitnan');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   PLOT PARTIAL TRACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bckgdc);

% Make axes
figaxes = axes('Parent',fig);

% Plot spectrogram
wavform = plot(timesample,wav,'Parent',figaxes);

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS WAVEFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of time axis
xlim(figaxes,[tmin tmax]);

% Limits of frequency axis
ylim(figaxes,[amin amax]);

% Set default parameters
set(wavform,'Color',grey,'LineStyle',linsty,'LineWidth',lwidth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add time label to axes
timelbl = xlabel(figaxes,tlbl);

% Add amplitude label to axes
amplbl = ylabel(figaxes,albl);

% Add title to plot
titlelbl = title(figaxes,ttl);

end
