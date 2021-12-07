function [fig,figaxes,specgram,nrglbl,timelbl,freqlbl,titlelbl] = plotpeakgram(specpeak,time,frequency)
%PLOTPEAKGRAM Plot peakgram.
%   [FIG,FIGAXES,SPECGRAM,NRGLBL,TIMELBL,FREQLBL,TTL] = PLOTPEAKGRAM(P,T,F)
%
%   Input arguments:
%
%   P Log magnitude of spectral peaks (dB power)
%   T time vector (s)
%   F frequency vector (Hz)
%
%   Output arguments:
%
%   FIG handle to the figure with spectrogram
%   FIGAXES axes objects associated with FIG
%   SPECGRAM handle to the mesh plot object
%   NRGLBL handle to the text object used as energy label
%   TIMELBL handle to the text object used as time label
%   FREQLBL handle to the text object used as frequency label
%   TTL handle to the text object used as title
%
%   See also PLOTWAV, PLOTSPEC, PLOTSPECTROGRAM, PLOTPARTTRACK, PLOTSPECTROPEAKGRAM

% 2020 MCaetano SMT 0.2.0
% $Id 2021 M Caetano SM 0.9.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(3,3);

% Check number of output arguments
nargoutchk(0,7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFAULT PARAMETERS OF THE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Font Name ( type 'listfonts' for available system fonts)
% font = 'Times'; 

% Background color
bgc = [1 1 1]; % white

% Marker size
msize = 6;

% Marker type
mtype = '.';

% Line style
linsty = 'none';

% Mesh style
meshsty = 'row'; % Delineates time-varying amplitude

% Azimuth
az = 0.5;

% Elevation
el = 90;

% Spectral energy axis
dblbl = 'Energy Spectral Density (dB)';

% Time axis
tlbl = 'Time (s)';

% Frequency axis
flbl = 'Frequency (Hz)';

% Title
ttl = 'Peakgram';

% Colormap
cmap = 'jet';

% Time limits
tmin = time(1,1);
tmax = time(1,end);

% Frequency limits
fmin = min(frequency,[],'all','omitnan');
fmax = max(frequency,[],'all','omitnan');

% Spectral energy limits
dbmin = -120;
dbmax = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT PEAKGRAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
fig = figure('Color',bgc);

% Make axes
figaxes = axes('Parent',fig);

% Plot spectrogram
specgram = mesh(time,frequency,specpeak,'Parent',figaxes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET DEFAULT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Limits of time axis
xlim(figaxes,[tmin tmax]);

% Limits of frequency axis
ylim(figaxes,[fmin fmax]);

% Limits of energy axis
caxis(figaxes,[dbmin dbmax]);

% Set colormap
colormap(figaxes,cmap);

% Set marker type/marker size/line style/mesh style
set(specgram,'Marker',mtype,'MarkerSize',msize,'LineStyle',linsty,'MeshStyle',meshsty);

% Set view (from above)
view(figaxes,[az el]);

% Fit plot box tightly around data
%axis(figaxes,'image');

% Draw box around plot
box(figaxes,'on');

% Do not draw grid in plot background
grid(figaxes,'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add colorbar with scale in dB to plot
nrglbl = colorbar(figaxes);

% Add amplitude label to axes
lbl = get(nrglbl,'Label');
lbl.String = dblbl;

% Add time label to axes
timelbl = xlabel(figaxes,tlbl);

% Add frequency label to axes
freqlbl = ylabel(figaxes,flbl);

% Add title to plot
titlelbl = title(figaxes,ttl);

end
