% test_sinusoidal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIGNAL PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sampling rate
sr = 16000;
% Fundamental frequency
f0 = [412; 621];
% Fundamental period
T0 = fix(sr./f0);
% Phase shift
phi = [pi/2; 3*pi/2];
% Amplitude
amp = [0.5; 0.27];
% Signal length N
N = 1600;
% Time in signal reference
time = (0:N-1)'/sr;
% Input signal
sig = amp(1)*cos(2*pi*f0(1).*time+phi(1)) + amp(2)*cos(2*pi*f0(2).*time+phi(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SM PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maximum number of peaks to resynthesize
maxnpeak = 2;

% window size
% winlen = 3*(2^nextpow2(max(T0)));
% winlen = 2^nextpow2(3*max(T0));
% winlen = 6*max(T0);
winlen = 512;

hopsize = fix(winlen/2);
% hopsize = 256;

% nfft = 2^nextpow2(8*winlen);
nfft = 4096;

% Normalize window during analysis and preserve energy upon resynthesis
normflag = true;

% Use zero phase window
zphflag = true;

% Magnitude spectrum scaling
magflag = {'lin','log','pow'};
mf = 3;

% Hann analysis window
wintype = 3;

% Store window name
winname = whichwin(wintype);

% Position of the center of the first analysis window
cflag = {'nhalf','one','half'};
cf = 3;

% Resynthesis algorithm
rsflag = {'OLA','PI'};
rsf = 2;

sig_in = sig;

bin = sr/nfft;

freqs = 0:bin:sr/2;

delta = 20;

[amplitude,frequency,phase,duration,dc,cframe] = sinusoidal_analysis(sig_in,freqs,nfft,hopsize,winlen,wintype,cflag{cf},normflag,zphflag,magflag{mf},maxnpeak);

[sin_model] = sinusoidal_resynthesis(amplitude,frequency,phase,delta,hopsize,winlen,sr,duration,wintype,cflag{cf},cframe,rsflag{rsf},maxnpeak);

% Plot Orig vs Sinusoidal
figure(1)
plot(time,sig,'o-r')
hold on
plot(time,sin_model,'.-k')
hold off
title('Original vs Sinusoidal')
legend('Original','Sinusoidal')
xlabel('Time (s)')
ylabel('Amplitude (linear)')

% Make residual
res = sig - sin_model;

% SRER = 20*log10(mean(sqrt(sig_in(winlen:end-winlen).^2))/mean(sqrt(res(winlen:end-winlen).^2)));
SRER = 20*log10(std(sig_in(winlen:end-winlen))/std(res(winlen:end-winlen)));

% Plot Orig vs Residual
figure(2)
plot(time,sig,'r')
hold on
plot(time,res,'k')
hold off
title(sprintf('Original vs Residual: SRER %d',SRER))
legend('Original','Residual')
xlabel('Time (s)')
ylabel('Amplitude (linear)')
