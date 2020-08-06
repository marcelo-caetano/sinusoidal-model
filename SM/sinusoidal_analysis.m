function [amp,freq,ph,nsample,dc,center_frame] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,maxnpeak,...
    relthres,absthres,winflag,cfwflag,normflag,zphflag,magflag,dispflag)
%SINUSOIDAL_ANALYSIS Perform sinusoidal analysis [1].
%   [A,F,P,L,DC,CFR] = SINUSOIDAL_ANALYSIS(S,M,H,NFFT,FS,MAXNPEAK,
%   RELTHRES,ABSTHRES,WINFLAG,CFWFLAG,NORMFLAG,ZPHFLAG,MAGFLAG,DISPFLAG)
%   splits the input sound S into overlapping frames of length M with a hop
%   size H and returns the amplitudes A, frequencies F, and phases P of the
%   partials assumed to be the MAXNPEAK peaks with maximum power spectral
%   amplitude.
%
%   DISPFLAG is a logical flag that controls the display of information.
%   Set DISPFLAG to TRUE to use verbose mode and display information on
%   the screen during the analysis and to FALSE to run in silent mode.
%
%   See also SINUSOIDAL_RESYNTHESIS
%
% [1] McAulay and Quatieri (1986) Speech Analysis/Synthesis Based on a
% Sinusoidal Representation, IEEE TRANSACTIONS ON ACOUSTICS, SPEECH,
% AND SIGNAL PROCESSING, VOL. ASSP-34, NO. 4.

% 2016 M Caetano;
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.2 (Revised)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(13,14);

% Check number of output arguments
nargoutchk(0,6);

if nargin == 13
    
    dispflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Sinusoidal Analysis')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHORT-TIME FOURIER TRANSFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Short-Time Fourier Transform
[fft_frame,nsample,dc,center_frame] = smt_stft(wav,framelen,hop,nfft,winflag,cfwflag,normflag,zphflag);

% Number of frames
nframe = numframe(nsample,framelen,hop,cfwflag);

% Scale the magnitude spectrum (Linear, Log, Power)
[mag_spec,p] = scale_magspec(fft_frame,framelen,nfft,winflag,magflag);

% Unwrap the phase spectrum
ph_spec = phase_unwrap(fft_frame,nfft);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VECTORIZED SINUSOIDAL ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peak picking
[amp_peak,freq_peak,ph_peak] = peak_picking(mag_spec,ph_spec,nfft,fs);

% Magnitude interpolation (quadratic)
[frequency,amplitude] = mag_interp(freq_peak,amp_peak);

% Unscale magnitude spectrum
amplitude = unscale_magspec(amplitude,p,magflag);

% Phase interpolation (linear)
phase = phase_interp(freq_peak,ph_peak,frequency);

% Return only the MAXNPEAK highest amplitude peaks in MAG SPEC
[amplitude,frequency,phase] = maxnumpeak(amplitude,frequency,phase,maxnpeak);

% Absolute threshold (corrected for full spectral energy)
[amplitude,frequency,phase] = absdb(amplitude,frequency,phase,absthres);

% Relative threshold
[amplitude,frequency,phase] = reldb(amplitude,frequency,phase,relthres);

% Convert from array with all tracks to cell with only peaks found
[amp,freq,ph] = track2peak(amplitude,frequency,phase,nframe,dispflag);

end
