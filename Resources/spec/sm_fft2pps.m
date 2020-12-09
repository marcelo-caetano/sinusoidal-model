function [phspec] = sm_fft2pps(fft_frame,nfft)
%FFT2PPS From FFT to positive phase spectrum.
%   [P] = FFT2PPS(FFTFR,NFFT) returns the phase spectrum from the 
%   positive (first) half of the complex FFT data as P = ANGLE(FFTFR), 
%   where P is the positive phase spectrum and FFTFR is an NFFT x NFR 
%   matrix with NFR frames of the NFFT-point FFT obtained with the STFT 
%   function.
%
%   See also FFT2PMS, FFT2MAG, FFT2PH, FS2HS, HS2FS, STFT

% 2020 M Caetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


% Positive half of FFT spectrum
half_spec = sm_fs2hs(fft_frame,nfft);

% Phase of the FFT
phspec = sm_fft2ph(half_spec);

end