function [amp,freq,ph,center_frame,npartial,nframe,nchannel,nsample,dc] = sinusoidal_analysis(wav,framelen,hop,nfft,fs,...
    winflag,maxnpeak,shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
    causalflag,paramestflag,ptrackflag,normflag,zphflag,npeakflag,peakselflag,trackdurflag)
%SINUSOIDAL_ANALYSIS Perform sinusoidal analysis [1].
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs) splits the input sound S into
%   overlapping frames of length M with a hop size of H, calculates the
%   short-time Fourier transform of S using N as the size of the FFT, and
%   returns the amplitudes A, frequencies F, and phases P of the underlying
%   sinusoids in S. Fs is the sampling frequency of S, which has L samples
%   per channel. A, F, and P are arrays of size NBIN x NFRAME x NCHANNEL,
%   where NBIN is the number of positive frequency bins, NFRAME is the
%   number of frames and NCHANNEL is the number of channels. NBIN is
%   obtained as NBIN = tools.spec.pos_freq_band(N). NOTE: The actual number
%   of rows in A, F, and P will be the number of partials NPART after
%   partial tracking. See below how to control partial tracking with the
%   flag PTRACKFLAG.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,WINFLAG) uses the numeric flag
%   WINFLAG to select the window function used for spectral analysis. Type
%   'help tools.dsp.whichwin' to see the windows available and their
%   corresponding values. The default is WINFLAG = 3, which uses the Hann
%   window.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,WINFLAG,MAXNPEAK) returns only
%   the MAXNPEAK peaks with highest spectral energy found in each frame of
%   the STFT as sinusoids in A, F, and P, which are arrays of size MAXNPEAK
%   x NFRAME x NCHANNEL. Note that some frames might have fewer values than
%   MAXNPEAK depending on how many spectral peaks were found in the frame.
%   For example, a frame where S is silence will simply contain MAXNPEAK
%   NaN in A, F, and P. The default is MAXNPEAK = 200. Set MAXNPEAK = Inf
%   to return all the peaks found, which internally sets MAXNPEAK = NBIN.
%   WARNING! MAXNPEAK = Inf causes the analysis to take very long. Typical
%   values for MAXNPEAK are in the range 100-200.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE) uses SHAPE as
%   the threshold for the peak selection by main-lobe shape criterion,
%   which compares the shape of each spectral peak found with the main lobe
%   of the spectral window used modulated by a stationary sinusoid whose
%   frequency is the center frequency of the corresponding spectral peak.
%   SHAPE varies between 0 and 1, where 0 means no similarity and 1 strict
%   similarity. The default is SHAPE = 0.8, which works well for sinusoids
%   that are relatively stationary inside each analysis window (e.g.,
%   musical instrument sounds). Lower values (0.6 <= SHAPE <= 0.75) might
%   be required for highly nonstationary sinusoids (speech). SHAPE = 0 will
%   retain all spectral peaks. SHAPE = 1 can be used to reject sidelobes in
%   purely synthetic sinusoids when there is no additive noise and the
%   sinusoids are always entirely contained inside the analysis window (to
%   avoid a distorted spectral image). Set SHAPE = 0.9 and MAXNPEAK to the
%   expected number of sinusoids for best results with synthetic sinusoids.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE) uses
%   RANGE as the threshold for the peak selection by amplitude range
%   criterion, which measures the difference in amplitude between the peak
%   maximum and each neighboring trough (local minimum) to the left and
%   right of the peak. RANGE varies between 0 and Inf dBp (20log10), where
%   RANGE = 0 rejects all peaks and RANGE = Inf ignores the RANGE
%   threshold. The default is RANGE = 20dBp.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL) uses
%   REL as the relative threshold for peak selection. The relative
%   threshold compares the maximum of each peak with the maximum of the
%   frame and rejects peaks with relative amplitudes lower than REL, which
%   varies between 0 and -Inf dBp. REL = 0 only keeps the maximum for each
%   frame and REL = -Inf ignores the REL threshold. The default is
%   REL = -100dBp, which rejects sidelobes for the Blackman-Harris window
%   in the absence of additive noise.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS)
%   uses ABS as the absolute threshold for peak selection. The absolute
%   threshold rejects peaks whose amplitudes are below ABS, which varies
%   between 0 and -InfdBp. ABS = 0 only keeps peaks with maximum amplitude
%   and ABS = -Inf ignores the ABS threshold. The default is ABS = -120dBp.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR) uses DUR as the threshold for the minimum duration of segments of
%   partial tracks. After partial tracking, any segments whose total
%   duration is below DUR will be discarded. DUR varies between 0 and Inf
%   ms. DUR = 0 ignores the duration threshold and DUR = Inf rejects all
%   peaks. The default is DUR = 20ms.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP) uses GAP as the threshold for the duration of the gaps between
%   segments of partial tracks to connect over. After partial tracking, any
%   segments with gaps whose duration is below GAP before and after will be
%   kept, independently of the duration of the segment (that is, even if
%   the duration of the segment is below DUR). GAP varies between 0 and Inf
%   ms. GAP = 0 does not allow any gaps between segments of partials and
%   GAP = Inf causes DUR to be ignored. The default is GAP = 17.5ms.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF) uses FREQDIFF as the maximum frequency interval in Hz
%   around each spectral peak used in the peak-to-peak continuation
%   algorithm. FREQDIFF varies between 0 and Inf Hz. FREQDIFF = 0 does not
%   connect peaks across frames and FREQDIFF = Inf will potentially search
%   for a candidate match across the entire frequency range. The default is
%   FREQDIFF = 20Hz.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG) uses the text flag CAUSALFLAG to control
%   the placement of the first analysis window. CAUSALFLAG = 'ANTI' places
%   the first analysis window just before the first sample of the waveform
%   being analyzed, so the rightmost window sample must be shifted by one
%   position to the right to overlap with the first sample of the waveform.
%   CAUSALFLAG = 'NON' places the center of the first analysis window at
%   the first sample of the waveform, so the left half of the window is
%   outside the signal range and the right half of the window overlaps with
%   the waveform. CAUSALFLAG = 'CAUSAL' places the first analysis window
%   entirely overlapping with the waveform being analyzed, so the analysis
%   window starts at the first sample of the waveform. The default is
%   CAUSALFLAG = 'CAUSAL'.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG) uses the text flag
%   PARAMESTFLAG to control the sinusoidal parameter estimation method.
%   PARAMESTFLAG = 'NNE' uses nearest neighbor estimation, PARAMESTFLAG =
%   'LIN' uses parabolic interpolation over linear scaling of the magnitude
%   spectrum, PARAMESTFLAG = 'LOG' uses parabolic interpolation over
%   log scaling of the magnitude spectrum, and PARAMESTFLAG = 'POW' uses
%   parabolic interpolation over power scaling of the magnitude spectrum.
%   The default is PARAMESTFLAG = 'POW'.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG) uses the text flag
%   PTRACKFLAG to control the partial tracking algorithm. PTRACKFLAG = 'P2P'
%   uses peak-to-peak partial tracking (as described in [1]) and
%   PTRACKFLAG = '' (empty string) specifies no partial tracking. The
%   default is PTRACKFLAG = 'P2P'.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG,NORMFLAG) uses the
%   logical flag NORMFLAG to control normalization of the analysis window.
%   NORMFLAG = TRUE normalizes the analysis window and NORMFLAG = FALSE
%   does not. The default is NORMFLAG = TRUE.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG,NORMFLAG,ZPHFLAG)
%   uses the logical flag ZPHFLAG to specify whether the analysis window
%   has linear phase or zero phase. ZPHFLAG = TRUE uses a zero phase
%   analysis window and ZPHFLAG = FALSE uses a linear phase analysis window.
%   The default is ZPHFLAG = TRUE.
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG,NORMFLAG,ZPHFLAG,
%   NPEAKFLAG) uses the logical flag NPEAKFLAG to specify whether to output
%   MAXNPEAK rows instead of NBIN rows for A, F, and P. NPEAKFLAG = TRUE
%   sets MAXNPEAK rows and NPEAKFLAG = FALSE sets NBIN rows. The default is
%   NPEAKFLAG = TRUE. NOTE: MAXNPEAK applies even when NPEAKFLAG = TRUE. In
%   this case, A, F, and P still have NBIN rows with at most MAXNPEAK
%   values per frame (the rest being NaN).
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG,NORMFLAG,ZPHFLAG,
%   NPEAKFLAG,PEAKSELFLAG) uses the logical flag PEAKSELFLAG to control the
%   application of the peak selection criteria. PEAKSEKFLAG = TRUE allows
%   application of each peak selection criterion individually as described
%   above and PEAKSEL = FALSE suppresses the application of all peak
%   selection criteria. The default is PEAKSELFLAG = TRUE. To control each
%   peak selection criterion individually, set their values appropriately
%   and use PEAKSELFLAG = TRUE.
%
%
%   [A,F,P] = SINUSOIDAL_ANALYSIS(S,M,H,N,Fs,MAXNPEAK,SHAPE,RANGE,REL,ABS,
%   DUR,GAP,FREQDIFF,CAUSALFLAG,PARAMESTFLAG,PTRACKFLAG,NORMFLAG,ZPHFLAG,
%   NPEAKFLAG,PEAKSELFLAG,TRACKDURFLAG) uses the logical flag TRACKDURFLAG
%   to control the application of the partial track duration criteria.
%   TRACKDURFLAG = TRUE allows application of each track duration criterion
%   individually as described above and TRACKDURFLAG = FALSE suppresses the
%   application of all track duration criteria. The default is TRACKDURFLAG
%   = TRUE. To control each track duration criterion individually, set
%   their values appropriately and use TRACKDURFLAG = TRUE.
%
%   [A,F,P,CFR,NPART,NFRAME,NCHANNEL,L,DC] = SINUSOIDAL_ANALYSIS(...) with
%   any of the syntaxes above also returns the array CFR containing the
%   positions of the center of the analysis window (so CFR/Fs is the time
%   vector), the final number of partials (after partial tracking) NPART,
%   the number of frames NFRAME, the number of audio channels NCHANNEL, the
%   total number of samples per channel L, and the DC value of S.
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
% 2021 M Caetano SMT (Revised)
% $Id 2021 M Caetano SM 0.9.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(5,22);

% Check number of output arguments
nargoutchk(0,9);

defaults = {3, 200, 0.8, 20, -100, -120, 20, 17.5, 20, 'causal', 'pow', 'p2p', true, true, true, true, true};

if nargin == 5
    
    [winflag,maxnpeak,shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{1:end};
    
elseif nargin == 6
    
    [maxnpeak,shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{2:end};
    
elseif nargin == 7
    
    [shapethres,rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{3:end};
    
elseif nargin == 8
    
    [rangethres,relthres,absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{4:end};
    
elseif nargin == 9
    
    [relthres,absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{5:end};
    
elseif nargin == 10
    
    [absthres,durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{6:end};
    
elseif nargin == 11
    
    [durthres,gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{7:end};
    
elseif nargin == 12
    
    [gapthres,freqdiff,...
        causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{8:end};
    
elseif nargin == 13
    
    [freqdiff,causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{9:end};
    
elseif nargin == 14
    
    [causalflag,paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{10:end};
    
elseif nargin == 15
    
    [paramestflag,ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{11:end};
    
elseif nargin == 16
    
    [ptrackflag,...
        normflag,zphflag,npeakflag,peakselflag,trackdurflag] =...
        defaults{12:end};
    
elseif nargin == 17
    
    [normflag,zphflag,npeakflag,peakselflag,trackdurflag] = defaults{13:end};
    
elseif nargin == 18
    
    [zphflag,npeakflag,peakselflag,trackdurflag] = defaults{14:end};
    
elseif nargin == 19
    
    [npeakflag,peakselflag,trackdurflag] = defaults{15:end};
    
elseif nargin == 20
    
    [peakselflag,trackdurflag] = defaults{16:end};
    
elseif nargin == 21
    
    [trackdurflag] = defaults{17:end};
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Sinusoidal Analysis')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SHORT-TIME FOURIER TRANSFORM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Short-Time Fourier Transform from namespace STFT
[fft_frame,center_frame,nsample,nframe,nchannel,dc] = STFT.stft(wav,framelen,hop,nfft,winflag,causalflag,normflag,zphflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SINUSOIDAL PARAMETER ESTIMATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate frequencies in Hz
frequnitflag = true;

% Estimation of parameters of sinusoids
[amplitude,frequency,phase,indmaxnpeak] = sinusoidal_parameter_estimation(fft_frame,framelen,nfft,fs,nframe,nchannel,maxnpeak,winflag,paramestflag,frequnitflag,npeakflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PEAK SELECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if peakselflag
    
    disp('Peak selection')
    
    [amplitude,frequency,phase] = sinusoidal_peak_selection(fft_frame,amplitude,frequency,phase,indmaxnpeak,...
        framelen,nfft,fs,nframe,nchannel,winflag,maxnpeak,shapethres,rangethres,relthres,absthres,normflag,zphflag,npeakflag);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARTIAL TRACKING & MINIMUM DURATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Handle partial tracking
if ~isempty(ptrackflag) && ~trackdurflag
    
    disp('Partial tracking')
    
    [amp,freq,ph,npartial] = partial_tracking(amplitude,frequency,phase,freqdiff,hop,fs,nframe,ptrackflag);
    
elseif ~isempty(ptrackflag) && trackdurflag
    
    disp('Partial tracking')
    
    [amplitude,frequency,phase,npartial] = partial_tracking(amplitude,frequency,phase,freqdiff,hop,fs,nframe,ptrackflag);
    
    disp('Minimum duration')
    
    [amp,freq,ph] = partial_track_duration(amplitude,frequency,phase,hop,fs,npartial,nframe,nchannel,durthres,gapthres,'ms');
    
else
    
    % Spectral peaks
    amp = amplitude;
    freq = frequency;
    ph = phase;
    npartial = maxnpeak;
    
end

end
