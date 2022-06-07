% RUN SINUSOIDAL MODEL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ADD FOLDER FROM CURRENTLY RUNNING SCRIPT TO MATLAB PATH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get full path & name of executing file
exeFile = mfilename('fullpath');

% Get full path of executing directory
exeDir = fileparts(exeFile);

% If EXEDIR is not on the path
if ~tools.iofun.isdironpath(exeDir)
    
    % Add EXEDIR (and all subfolders) to Matlab path
    tools.iofun.add2path(exeDir);
    
end

% Create environment variable SM with the absolute path to the base folder
setenv('SM',exeDir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL ANALYSIS PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peak selection
peakselflag = true;

% Track duration
trackdurflag = true;

% Harmonic selection
harmselflag = true;

% Blackman-Harris analysis window
winflag = 6;

% Display name of analysis window in the terminal
fprintf(1,'%s analysis window\n',tools.dsp.infowin(winflag,'name'));

% Flag for causality of first window
causalflag = {'causal','non','anti'};
cf = 3;

% Flag for log magnitude spectrum
logflag = {'dbr','dbp','nep','oct','bel'};
lmsf = 2;

% Flag for parameter estimation
paramestflag = {'nne','lin','log','pow'};
pef = 4;

% Partial tracking flag
ptrackflag = {'','p2p'};
ptf = 2;

% Number of fundamental periods
if peakselflag
    nT0 = 6;
    % Oversampling factor
    osfac = 4;
else
    nT0 = 4;
    osfac = 2;
end

% Normalize analysis window
normflag = true;

% Use zero phase window
zphflag = true;

% Maximum number of peaks to retrieve from analysis
maxnpeak = 150;

% Return MAXNPEAK frequency bins
npeakflag = true;

% Replace -Inf in spectrogram
nanflag = false;

% Peak shape threshold (normalized)
shapethres = 0.87;

% Peak range threshold (dB power)
rangethres = 15;

% Relative threshold (dB power)
relthres = -90;

% Absolute threshold (dB power)
absthres = -100;

% Minimum partial track segment duration (ms)
durthres = 10.5;

% Connect over (ms)
gapthres = 22.5;

% Resynthesis flag
synthflag = {'OLA','PI','PRFI'};
sf = 2;

% Display resynthesis info
dispflag = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ SOUND FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Absolute path of audio file (using EXEDIR)
sndfile = fullfile(exeDir,'audio','Tuba_oV_hA_2-120_ff_C3.wav');

% Get file path, name, and extension
[sndpath,sndname,fext] = fileparts(sndfile);

% Get sound file name
sndname = strrep(sndname,'_',' ');

% Print sound file name to the terminal
fprintf(1,'Sound %s\n',sndname);

% Read audio
[wav,fs] = audioread(sndfile);

% Convert from stereo to mono
wav = tools.wav.stereo2mono(wav);

% Fundamental freq of source sound
f0 = swipep_mod(wav,fs,[75 500],1000/fs,[],1/20,0.5,0.2);

% Reference f0
ref0 = tools.f0.reference_f0(f0);

% Frame size = n*T0
framelen = tools.dsp.framesize(f0,fs,nT0);

% 50% overlap
hop = tools.dsp.hopsize(framelen,0.5);

% FFT size
nfft = tools.dsp.fftsize(framelen,osfac);

% Frequency difference for peak matching (Hz)
freqdiff = tools.dsp.freq_diff4peak_matching(ref0);

% Maximum harmonic deviation (cents)
max_harm_dev = 80;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[amplitude,frequency,phase,center_frame,npartial,nframe,nchannel,nsample,dc] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,...
    winflag,maxnpeak,shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
    causalflag{cf},paramestflag{pef},ptrackflag{ptf},normflag,zphflag,npeakflag,peakselflag,trackdurflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HARMONIC SELECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if harmselflag
    
    disp('Harmonic Selection')
    [amplitude,frequency,phase,nharmonic] = harmonic_selection(amplitude,frequency,phase,npartial,nframe,nchannel,ref0,max_harm_dev);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'jet';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.msize = 7;
fig_layout.mtype = '.';
fig_layout.linsty = '-'; %'none'
fig_layout.meshsty = 'row'; %'both'
fig_layout.disp = 'on';
fig_layout.print = 'opengl';

% Axes label
axes_lbl.tlbl = 'Time (s)';
axes_lbl.flbl = 'Frequency (kHz)';
axes_lbl.dblbl = 'Spectral Energy (dB)';

% Axes limits
axes_lim.flim = [0 8];
axes_lim.dblim = [-120 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT PARTIAL TRACKING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Log Mag Amp peaks
plot_part.specpeak = tools.math.lin2log(amplitude,logflag{lmsf},nanflag);

if harmselflag
    npart = nharmonic;
else
    npart = npartial;
end

% Time peaks
plot_part.time = repmat(center_frame/fs,[1,npart])';

% Frequency peaks
plot_part.frequency = frequency/1000;

% Time limits
axes_lim.tlim = [plot_part.time(1,1) plot_part.time(1,end)];

% Title
if harmselflag
    axes_lbl.ttl = 'Harmonic Selection';
else
    axes_lbl.ttl = 'Partial Tracking';
end

% Make figure
tools.plot.mkfigpeakgram(plot_part,axes_lim,axes_lbl,fig_layout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL RESYNTHESIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sinusoidal,partial,amp_partial,freq_partial,phase_partial] = sinusoidal_resynthesis(amplitude,frequency,phase,...
    framelen,hop,fs,winflag,nsample,center_frame,npart,nframe,nchannel,durthres,gapthres,freqdiff,...
    causalflag{cf},synthflag{sf},ptrackflag{ptf},~trackdurflag,dispflag);

% Make residual
residual = wav - sinusoidal;

% Calculate signal-to-resynthesis energy ratio (SRER)
srer_db = tools.wav.srer(wav,residual);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIGURE PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot data
plot_wav.time = tools.plot.mktime(nsample,fs);
plot_wav.wav = wav;
plot_wav.wav(:,2) = sinusoidal;
plot_wav.wav(:,3) = residual;

% Figure layout
fig_layout.font = 'Times New Roman';
fig_layout.axesfs = 14;
fig_layout.titlefs = 22;
fig_layout.bckgdc = [1 1 1];
fig_layout.cmap = 'gray';
fig_layout.figsize = [15 10];
fig_layout.figpos = [0.5 0.5 fig_layout.figsize-0.5];
fig_layout.figunit = 'centimeters';
fig_layout.linsty = '-'; %'none'
fig_layout.linwidth = 1;
fig_layout.disp = 'on';
fig_layout.print = 'opengl';

% Legend
if harmselflag
    fig_layout.legdisp = ["Original";"Harmonics";"Residual"];
else
    fig_layout.legdisp = ["Original";"Sinusoidal";"Residual"];
end

% Axes label
axes_lbl.tlbl = 'Time (s)';
axes_lbl.albl = 'Amplitude (Normalized)';
axes_lbl.ttl = sprintf('SRER: %2.2fdB %s',srer_db,sndname);

% Axes limits
axes_lim.tlim = [plot_wav.time(1) plot_wav.time(end)];
axes_lim.alim = [min(plot_wav.wav,[],'all','omitnan') max(plot_wav.wav,[],'all','omitnan')];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SINUSOIDAL MODEL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Make figure
tools.plot.mkfigwav(plot_wav,axes_lim,axes_lbl,fig_layout);
