function magspec = fft2pms(fft_frame,nfft,nrgflag)
%FFT2PMS From FFT to positive magnitude spectrum.
%   [M] = FFT2PMS(FFTFR,NFFT) returns the magnitude spectrum from
%   the positive (first) half of the complex FFT data as M = ABS(FFTFR),
%   where M is the positive magnitude spectrum and FFTFR is an NFFT x NFR
%   matrix with NFR frames of the NFFT-point FFT obtained with the STFT
%   function.
%
%   See also FFT2PPS, FFT2MAG, FFT2PH, FS2HS, HS2FS, STFT

% 2020 M Caetano SMT 0.1.2% $Id 2020 M Caetano SM 0.3.1-alpha.3 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK INPUT ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    nrgflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Positive half of FFT spectrum
half_spec = fs2hs(fft_frame,nfft,nrgflag);

% Magnitude of FFT
magspec = fft2mag(half_spec);

end
