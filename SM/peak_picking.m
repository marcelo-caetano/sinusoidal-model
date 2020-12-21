function [peakamp,peakfreq,peakph] = peak_picking(magspec,phspec,nfft,fs)
% PEAK_PICKING amplitudes, frequencies, and phases of the spectral peaks.
%   [A,F,P] = PEAK_PICKING(MAG,PH,NFFT,Fs) returns the amplitudes A, the 
%   frequencies F, and the phases P corresponding to the peaks of the 
%   DFT spectrum. MAG is the magnitude spectrum, PH is the phase spectrum,
%   NFFT is the size of the FFT, and Fs is the sampling frequency.
%
%   MAG is used to return A, PH is used to return P in radians, and NFFT 
%   and Fs are used to return F in Hertz. Both MAG and PH only have the
%   nonnegative frequency half of the DFT spectrum (from 0 to Nyquist), so
%   both are size NBIN x NFRAME, where NBIN = NFFT/2+1.
%
%   A, F, and P are used in the magnitude and phase interpolation steps of 
%   sinusoidal analysis. A, F, and P are size NBIN x NFRAME x 3. The 3 
%   pages correspond to the bin of the spectral peak and its immediate 
%   neighbors on the left and on the right. The output order is 
%   [left neighbor, spectral peak, right neighbor]. A, F, and P contain NaN 
%   for positions that do not correspond to peaks.
%
%   See also PEAKPICK, QUAD_INTERP, PHASE_INTERP

% 2016 M Caetano;
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(4,4);

% Check number of output arguments
nargoutchk(0,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CREATE ARRAY WITH FREQUENCY BINS IN HERTZ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of frequency bins and number of frames
[nbin,nframe] = size(magspec);

% Array of indices corresponding to frequency bins
ind = repmat((1:nbin)',1,nframe);

% Frequency array (Hz)
freq = ind2freq(ind,fs,nfft);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PICK INDICES OF PEAKS IN MAGNITUDE SPECTRUM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Peak picking: indices of spectral peaks (logical)
ipeak = peakpick(magspec);

% Indices of bins before the peaks (logical)
iprev = circshift(ipeak,-1);

% Indices of bins after the peaks (logical)
inext = circshift(ipeak,1);

% Final array of indices: NBIN x NFRAME x 3
ifull = repmat(ipeak,1,1,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RETURN AMPLITUDES, FREQUENCIES, AND PHASES CORRESPONDING TO PEAKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize amplitudes (NaN)
peakamp = nan(nbin,nframe,3);

% Initialize frequencies (NaN)
peakfreq = nan(nbin,nframe,3);

% Initialize phases (NaN)
peakph = nan(nbin,nframe,3);

% Magnitude of peaks (scaled)
peakamp(ifull) = cat(3,magspec(iprev),magspec(ipeak),magspec(inext));

% Frequency of peaks (Hz)
peakfreq(ifull) = cat(3,freq(iprev),freq(ipeak),freq(inext));

% Phase of peaks (rad)
peakph(ifull) = cat(3,phspec(iprev),phspec(ipeak),phspec(inext));

end
