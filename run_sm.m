% RUN SINUSOIDAL MODEL

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL ANALYSIS PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

partselflag = true;

% Blackman-Harris analysis window
winflag = 6;

% Display name of analysis window in the terminal
% fprintf(1,'%s analysis window\n',tools.dsp.infowin(winflag,'name'));

% Flag for causality of first window
causalflag = {'causal','non','anti'};
cf = 3;

% Flag for log magnitude spectrum
logflag = {'dbr','dbp','nep','oct','bel'};
lmsf = 2;

% Flag for parameter estimation
paramestflag = {'nne','lin','log','pow'};
mf = 4;

% Partial tracking flag
ptrackflag = {'','p2p'};
ptrck = 2;

% Number of fundamental periods
if partselflag
    nT0 = 6;
else
    nT0 = 4;
end

% Normalize analysis window
normflag = true;

% Use zero phase window
zphflag = true;

% Estimate frequencies in Hz
frequnitflag = true;

% Maximum number of peaks to retrieve from analysis
maxnpeak = 150;

% MAXNPEAK frequency bins
npeakflag = true;

% Replace -Inf in spectrogram
nanflag = false;

% Peak shape threshold (normalized)
shapethres = 0.8;

% Peak range threshold (dB power)
rangethres = 20;

% Relative threshold (dB power)
% relthres = -inf(1);
relthres = -80;

% Absolute threshold (dB power)
% absthres = -inf(1);
absthres = -100;

% Resynthesis flag
synthflag = {'OLA','PI','PRFI'};
rf = 2;

% Display flag
dispflag = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% READ SOUND FILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Relative path for audio file
sndfile = fullfile('.','audio','Tuba_oV_hA_2-120_ff_C3.wav');

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

% Oversampling factor
osfac = 4;

% FFT size
nfft = tools.dsp.fftsize(framelen,osfac);

% Frequency difference for peak matching (Hz)
freqdiff = tools.dsp.freq_diff4peak_matching(ref0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[amplitude,frequency,phase,center_frame,npartial,nsample,nframe,nchannel,dc] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,...
    maxnpeak,shapethres,rangethres,relthres,absthres,freqdiff,...
    winflag,causalflag{cf},paramestflag{mf},ptrackflag{ptrck},normflag,zphflag,frequnitflag,npeakflag,partselflag);

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

% Time peaks
plot_part.time = repmat(center_frame/fs,[1,npartial])';

% Frequency peaks
plot_part.frequency = frequency/1000;

% Time limits
axes_lim.tlim = [plot_part.time(1,1) plot_part.time(1,end)];

% Title
axes_lbl.ttl = 'Partial Tracking';

% Make figure
tools.plot.mkfigpeakgram(plot_part,axes_lim,axes_lbl,fig_layout);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL RESYNTHESIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sinusoidal,partial,amp_partial,freq_partial,phase_partial] = sinusoidal_resynthesis(amplitude,frequency,phase,...
    framelen,hop,fs,nsample,center_frame,npartial,nframe,freqdiff,winflag,causalflag{cf},synthflag{rf},ptrackflag{ptrck},dispflag);

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
fig_layout.legdisp = ["Original";"Sinusoidal";"Residual"];

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
