% RUN SINUSOIDAL MODEL PRODUCTION

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIGNAL PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sampling rate
fs = 16000;
% Fundamental frequency
freq_part = [412; 621];
% Phase shift
phi = [pi/2; 3*pi/2];
% Amplitude
amp = [0.5; 0.27];
% Signal length N
N = 1600;
% Time in signal reference
time = (0:N-1)'/fs;
% Input signal
wav = amp(1)*cos(2*pi*freq_part(1).*time + phi(1)) + amp(2)*cos(2*pi*freq_part(2).*time + phi(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ANALYSIS PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Maximum number of peaks to resynthesize
maxnpeak = 10;

% Relative threshold
relthres = -inf(1);

% Absolute threshold
absthres = -inf(1);

% Hann analysis window
winflag = 3;

% Flag for center of first window
cfwflag = {'nhalf','one','half'};
cf = 3;

% Normalize analysis window
normflag = true;

% Use zero phase window
zphflag = true;

% Magnitude spectrum scaling
magflag = {'nne','lin','log','pow'};
mf = 3;

% Resynthesis flag
synthflag = {'OLA','PI','PRFI'};
rf = 2;

% Display flag
dispflag = false;

% Frequency difference for peak matching (Hz)
delta = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SM PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fundamental freq of source sound
f0 = swipep(wav,fs,[75 500],1000/fs,[],1/20,0.5,0.2);

% Frame size
framelen = framesize(f0,fs,3);

% Hop size
hop = hopsize(framelen,0.5);

% FFT size
nfft = fftsize(framelen);

% Run sinusoidal analysis
[amp,freq,ph,nsample,dcval,center_frame] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,maxnpeak,relthres,absthres,winflag,cfwflag{cf},normflag,zphflag,magflag{mf},dispflag);

% Run sinusoidal resynthesis
sin = sinusoidal_resynthesis(amp,freq,ph,delta,framelen,hop,fs,nsample,center_frame,maxnpeak,winflag,cfwflag{cf},synthflag{rf});

% Plot Orig vs Sinusoidal
figure(1)
plot(time,wav,'o-r')
hold on
plot(time,sin,'.-k')
hold off
title('Original vs Sinusoidal')
legend('Original','Sinusoidal')
xlabel('Time (s)')
ylabel('Amplitude (linear)')

% Make residual
res = wav - sin;

% SRER
SRER = 20*log10(std(wav(framelen:end-framelen))/std(res(framelen:end-framelen)));

% Plot Orig vs Residual
figure(2)
plot(time,wav,'r')
hold on
plot(time,res,'k')
hold off
title(sprintf('Original vs Residual: SRER %d',SRER))
legend('Original','Residual')
xlabel('Time (s)')
ylabel('Amplitude (linear)')
