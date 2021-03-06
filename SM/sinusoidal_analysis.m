function [amp,freq,ph,nsample,dc,center_frame,npartial,nframe] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,maxnpeak,relthres,absthres,delta,...
    winflag,causalflag,normflag,zphflag,magflag,ptrackflag)
%SINUSOIDAL_ANALYSIS Perform sinusoidal analysis [1].
%   [A,F,P,L,DC,CFR,NPART] = SINUSOIDAL_ANALYSIS(S,M,H,NFFT,FS,MAXNPEAK,
%   RELTHRES,ABSTHRES,DELTA,WINFLAG,CAUSALFLAG,NORMFLAG,ZPHFLAG,MAGFLAG,DISPFLAG)
%   splits the input sound S into overlapping frames of length M with a hop
%   size H and returns the amplitudes A, frequencies F, and phases P of the
%   partials assumed to be the MAXNPEAK peaks with maximum power spectral
%   amplitude.
%
%   RELTHRES is a numeric value in dB that sets the minumum spectral energy
%   of a peak (relative to the maximum energy inside the frame) to be
%   included among the output spectral peaks. Spectral peaks whose relative
%   energy is lower than RELTHRES dB are discarded. Set RELTHRES = -Inf to
%   include all spectral peaks found inside each frame.
%
%   ABSTHRES is a numeric value in dB that sets the minumum spectral energy
%   of a peak (relative to the maximum energy of the entire waveform) to be
%   included among the output spectral peaks. Spectral peaks whose absolute
%   energy is lower than ABSTHRES dB are discarded. Set ABSTHRES = -Inf to
%   include all spectral peaks found across the duration of the waveform.
%
%   DELTA sets the frequency interval in Hz around each spectral peak used
%   in the peak-to-peak continuation algorithm (also P2P partial tracking).
%
%   WINFLAG is a numerical flag that controls the window used. Type HELP
%   WHICHWIN to see the possibilities.
%
%   CAUSALFLAG controls the placement of the causalflag of the first analysis window
%   CAUSALFLAG = 'NCAUSAL' places the first analysis window just before the
%   first sample of the waveform being analyzed, so the rightmost window
%   sample must be shifted by one position to the right to overlap with the
%   first sample of the waveform.
%   CAUSALFLAG = 'NON' places the sample at the causalflag of the first analysis
%   window at the first sample of the waveform, so the left half of the
%   window is outside the signal range and the right half of the window
%   overlaps with the waveform.
%   CAUSALFLAG = 'CAUSAL' places the first analysis window entirely overlapping
%   with the waveform being analyzed, so the leftmost window sample
%   coincides with the first sample of the waveform.
%
%   NORMFLAG is a logical flag that controls normalization of the analysis
%   window. Set NORMFLAG = TRUE to normalize and FALSE otherwise.
%
%   ZPHFLAG is a logical flag that controls if the analysis window has linear
%   phase or zero phase. Set ZPHFLAG = TRUE for zero phase and FALSE for
%   linear phase.
%
%   MAGFLAG controls the scaling of the magnitude spectrum for parameter
%   estimation.
%   MAGFLAG = 'NNE' uses nearest neighbor estimation
%   MAGFLAG = 'LIN' uses parabolic interpolation over linear scaling
%   MAGFLAG = 'LOG' uses parabolic interpolation over log scaling
%   MAGFLAG = 'POW' uses parabolic interpolation over power scaling
%
%   PTRACKFLAG controls partial tracking. Set PTRACKFLAG = 'P2P' to use
%   peak-to-peak partial tracking. PTRACKFLAG = '' (empty string) sets the
%   default behavior of no partial tracking.
%
%   See also SINUSOIDAL_RESYNTHESIS
%
% [1] McAulay and Quatieri (1986) Speech Analysis/Synthesis Based on a
% Sinusoidal Representation, IEEE TRANSACTIONS ON ACOUSTICS, SPEECH,
% AND SIGNAL PROCESSING, VOL. ASSP-34, NO. 4.

% 2016 M Caetano;
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.2 (Revised)
% 2020 MCaetano SMT 0.2.0
% $Id 2021 M Caetano SM 0.5.0-alpha.3 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(14,15);

% Check number of output arguments
nargoutchk(0,8);

if nargin == 14
    
    ptrackflag = '';
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Import namespace for STFT
% import STFT.stft

disp('Sinusoidal Analysis')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHORT-TIME FOURIER TRANSFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Short-Time Fourier Transform from namespace STFT
[fft_frame,nsample,dc,center_frame,nframe] = STFT.stft(wav,framelen,hop,nfft,winflag,causalflag,normflag,zphflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FOURIER SPECTRUM PRE-PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Scale the magnitude spectrum (Linear, Log, Power)
[mag_spec,pow] = tools.spec.fft2scaled_mag_spec(fft_frame,framelen,nfft,winflag,magflag);

% Unwrap the phase spectrum
ph_spec = tools.spec.fft2unwrapped_phase_spec(fft_frame,nfft,true);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETER ESTIMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peak picking
[amp_peak,freq_peak,ph_peak] = peak_picking(mag_spec,ph_spec,nfft,fs);

if strcmpi(magflag,'nne')
    
    % No interpolation for NNE (nearest neighbor estimation)
    amplitude = amp_peak(:,:,2);
    frequency = freq_peak(:,:,2);
    phase = ph_peak(:,:,2);
    
else
    
    % Magnitude interpolation (quadratic)
    [frequency,amplitude] = mag_interp(freq_peak,amp_peak);
    
    % Phase interpolation (linear)
    phase = phase_interp(freq_peak,ph_peak,frequency);
    
end

% Revert magnitude spectrum scaling
amplitude = tools.spec.revert_mag_spec_scaling(amplitude,pow,magflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPECTRAL POST-PROCESSING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Return only the MAXNPEAK highest amplitude peaks
[amplitude,frequency,phase] = maxnumpeak(amplitude,frequency,phase,maxnpeak,nfft,nframe);

% Apply absolute threshold
[amplitude,frequency,phase] = absdb(amplitude,frequency,phase,absthres);

% Apply relative threshold
[amplitude,frequency,phase] = reldb(amplitude,frequency,phase,relthres);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTIAL TRACKING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Handle partial tracking
if ~isempty(ptrackflag)
    
    % Partial tracking
    [amp,freq,ph,npartial] = partial_tracking(amplitude,frequency,phase,delta,hop,fs,nframe,ptrackflag);
    
else
    
    % Spectral peaks
    amp = amplitude;
    freq = frequency;
    ph = phase;
    npartial = maxnpeak;
    
end

end
