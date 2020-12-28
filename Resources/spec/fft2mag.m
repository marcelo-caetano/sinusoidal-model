function magspec = fft2mag(fft_frame)
%FFT2MAG From FFT to magnitude spectrum.
%   M = FFT2MAG(FFTFR) returns the magnitude spectrum M of FFTFR.
%
%   See also FFT2PH, FS2HS, HS2FS, FFT2PMS, FFT2PPS

% 2020 M Caetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.1-alpha.3 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Magnitude of the complex FFT
magspec = abs(fft_frame);

end
