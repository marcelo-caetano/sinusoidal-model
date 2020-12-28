function fig = mkfigwav(plotdata,axeslim,axeslbl,figlayout)
%MKFIGWAV Make the figure with the plot of the waveform.
%   FIG = MKFIGWAV(PLOTDATA,AXESLIM,AXESLBL,FIGLAYOUT)
%
%   Input arguments are structures with fields:
%
%   PLOTDATA.WAV NSAMPLE vector containing the waveform
%   PLOTDATA.TIME NSAMPLE vector with time in (s)
%
%   AXESLIM.TLIM [TMIN TMAX] minimum and maximum display time (s)
%   AXESLIM.ALIM [AMIN AMAX] minimum and maximum display amplitude (Normalized)
%
%   AXESLBL.TLBL time label string
%   AXESLBL.ALBL amplitude label string
%   AXESLBL.TTL title string
%
%   FIGLAYOUT.FONT font name (DEFAULT 'Times New Roman')
%   FIGLAYOUT.AXESFS axes font size (DEFAULT 14)
%   FIGLAYOUT.TITLEFS title font size (DEFAULT 22)
%   FIGLAYOUT.LINWIDTH line width (DEFAULT 1.0)
%   FIGLAYOUT.BCKGDC background color (DEFAULT [1 1 1])
%   FIGLAYOUT.CMAP colormap (DEFAULT 'gray')
%   FIGLAYOUT.FIGSIZE figure size (DEFAULT [15 10])
%   FIGLAYOUT.FIGPOS figure position (DEFAULT [0.5 0.5 14.5 9.5])
%   FIGLAYOUT.FIGUNIT unit measurement of figure size (DEFAULT 'centimeters')
%   FIGLAYOUT.LINSTY line style (DEFAULT '-')
%   FIGLAYOUT.DISP figure visibility display (DEFAULT 'on')
%   FIGLAYOUT.PRINT renderer used to print figure (DEFAULT 'opengl')
%
%   See also MKFIGSPECTROGRAM, MKFIGSPECTROPEAKGRAM, MKFIGPARTTRACK

% 2020 MCaetano SMT 0.2.0
% $Id 2020 M Caetano SM 0.3.1-alpha.3 $Id


% https://www.mathworks.com/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html
% https://www.mathworks.com/help/matlab/ref/matlab.ui.figure-properties.html
% PaperSize [width height]
% PaperPosition [left bottom width height]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PRE-PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get number of waveforms to plot
[~,nwav] = size(plotdata.wav);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DEFINE DEFAULT FIGURE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define default font
if ~isfield(figlayout,'font')
    figlayout.font = 'Times New Roman';
end

% Define default axes font size
if ~isfield(figlayout,'axesfs')
    figlayout.axesfs = 14;
end

% Define default title font size
if ~isfield(figlayout,'titlefs')
    figlayout.titlefs = 22;
end

% Define background color
if ~isfield(figlayout,'bckgdc')
    figlayout.bckgdc = [1 1 1];
end

% Define colormap
if ~isfield(figlayout,'cmap')
    figlayout.cmap = 'gray';
end

% Define figure size
if ~isfield(figlayout,'figsize')
    figlayout.figsize = [15 10];
end

% Define figure position
if ~isfield(figlayout,'figpos')
    figlayout.figpos = [0.5 0.5 figlayout.figsize-0.5];
end

% Define figure unit
if ~isfield(figlayout,'figunit')
    figlayout.figunit = 'centimeters';
end

% Define line style
if ~isfield(figlayout,'linsty')
    figlayout.linsty = '-';
end

% Define line width
if ~isfield(figlayout,'linwidth')
    figlayout.linwidth = 1;
end

% Define display figure
if ~isfield(figlayout,'disp')
    figlayout.disp = 'on';
end

% Define figure renderer
if ~isfield(figlayout,'print')
    figlayout.facec = 'opengl';
end

% Define display legend
if ~isfield(figlayout,'legdisp')
    figlayout.legdisp = repmat("Waveform",1,nwav);
end

% Define legend font size
if ~isfield(figlayout,'legendfs')
    figlayout.legendfs = 12;
end

% Define legend orientation
if ~isfield(figlayout,'legorient')
    figlayout.legorient = 'vertical';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE PLOT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot first waveform
[fig,figaxes,wavform,timelbl,amplbl,titlelbl] = plotwav(plotdata.time,plotdata.wav(:,1));

% If multiple waveforms
if nwav > 1
    
    % Hold on axis
    hold(figaxes,'on');
    
    for iwav = 2:nwav
        
        % Plot each waveform
        wavform(iwav) = plot(plotdata.time,plotdata.wav(:,iwav));
        
    end
    
    % Hold off axis
    hold(figaxes,'off');
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LIMITS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Override default time axis limits
if isfield(axeslim,'tlim')
    set(figaxes,'XLim',axeslim.tlim);
end

% Override default frequency axis limits
if isfield(axeslim,'alim')
    set(figaxes,'YLim',axeslim.alim);
end

% Display box around axes
box(figaxes,'on');

% Display axes grid
grid(figaxes,'off');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET AXES LABELS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Customize text of time label
if isfield(axeslbl,'tlbl')
    set(timelbl,'String',axeslbl.tlbl);
end

% Customize text of frequency label
if isfield(axeslbl,'albl')
    set(amplbl,'String',axeslbl.albl);
end

% Customize text of title
if isfield(axeslbl,'ttl')
    set(titlelbl,'String',axeslbl.ttl);
end

% Customize font name
if isfield(figlayout,'font')
    
    % Customize time axis label font name
    set(timelbl,'FontName',figlayout.font);
    
    % Customize frequency axis label font name
    set(amplbl,'FontName',figlayout.font);
    
    % Customize axes marker font name
    set(figaxes,'FontName',figlayout.font);
    
    % Customize title font name
    set(titlelbl,'FontName',figlayout.font);
    
end

% Customize title font size
if isfield(figlayout,'titlefs')
    set(titlelbl,'FontSize',figlayout.titlefs);
end

% Customize axis font size
if isfield(figlayout,'axesfs')
    
    % Customize time axis label font size
    set(timelbl,'FontSize',figlayout.axesfs);
    
    % Customize frequency axis label font size
    set(amplbl,'FontSize',figlayout.axesfs);
    
    % Customize axes marker font size
    set(figaxes,'FontSize',figlayout.axesfs);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET FIGURE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set fig display (visibility)
set(fig,'Visible',figlayout.disp);

% Set fig print (renderer)
set(fig,'Renderer',figlayout.print);

% Set background color
set(fig,'Color',figlayout.bckgdc);

% Customize colormap
colormap(figaxes,figlayout.cmap);

% Set Paper Position Mode
set(fig,'PaperPositionMode','Auto');

% Set Paper unit [centimeters/inches]
set(fig,'PaperUnit',figlayout.figunit);

% Set Paper Size [width height]
set(fig,'PaperSize',figlayout.figsize);

% Set Paper Position [left bottom width height]
set(fig,'PaperPosition',figlayout.figpos);

% Set line style
set(wavform,'LineStyle',figlayout.linsty);

% Set line width
set(wavform,'LineWidth',figlayout.linwidth);

% For each waveform
for iwav = 1:nwav
    
    % Set waveform colors
    set(wavform(iwav),'Color',mklincolor(iwav));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SET LEGEND LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Legend
if nwav > 1
    
    %     % Set display names
    %     for iwav = 1:nwav
    %
    %         set(wavform(iwav),'DisplayName',mkdisplayname(figlayout.legdisp,iwav));
    %
    %     end
    
    % Create legend
    figlegend = legend(wavform,figlayout.legdisp);
    
    % Set legend orientation
    set(figlegend,'Orientation',figlayout.legorient);
    
    % Set legend font name
    set(figlegend,'FontName',figlayout.font);
    
    % Set legend font size
    set(figlegend,'FontSize',figlayout.legendfs);
    
end

end

% Private function to assign line colors
function lincolor = mklincolor(count)

% Define colors
col = [0 0 1;... % blue
    0.5 0.5 0.5;... % grey
    0 0 0;... % black
    1 0 0;... % red
    0.83 0.8 0.75;... % light grey
    1 1 0;... % yellow
    0.25 0.25 0.25;... % very dark grey
    1 0 1;... % magenta
    0.8 0.8 0.8;... % half tone
    0 1 1;... % cyan
    0.35 0.35 0.35;... % dark grey
    0 1 0;... % green
    0.95 0.95 0.95]'; % very light grey

% Assign color
lincolor = cyclethru(col,count);

end

% % Private function to assign legend
% function displayname = mkdisplayname(dname,count)
%
% displayname = cyclethru(dname,count);
%
% end

% Private function to cycle through vector
function valvec = cyclethru(vec,ind)

% Number of elements (assumes column vector)
[~,nelem] = size(vec);

% Element counter
elemcount = rem(ind,nelem);

if elemcount == 0
    
    % Assign last element
    valvec = vec(:,nelem);
    
else
    
    % Assign element counter
    valvec = vec(:,elemcount);
    
end

end
