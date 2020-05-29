function [magspec] = fft2mag(fft_frame)
%FFT2MAG From FFT to magnitude spectrum.
%   M = FFT2MAG(FFTFR) returns the magnitude spectrum M of FFTFR.
%
%   See also FFT2PH, FS2HS, HS2FS, FFT2PMS, FFT2PPS

% 2020 M Caetano SMT 0.1.1

% Magnitude of the complex FFT
magspec = abs(fft_frame);

end