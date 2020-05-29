function phspec = fft2ph(fft_frame,phflag)
%FFT2PH From FFT to phase spectrum.
%   PS = FFT2PH(FFTFR) returns the phase spectrum PS of FFTFR.
%
%   PS = FFT2PH(FFTFR.PHFLAG) uses the logical flag PHFLAG to control phase
%   unwrapping of PS. PHFLAG = TRUE returns unwrapped phase and PHFLAG =
%   FALSE does not. The default is PHFLAG = FALSE when FFT2PH is called
%   with only one input argument.
%
%   See also FFT2MAG, FS2HS, HS2FS, FFT2PMS, FFT2PPS

% 2020 M Caetano SMT 0.1.1

% Check number of input arguments
narginchk(1,2);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 1
    
    phflag = false;
    
end

% Phase of the complex FFT
phspec = angle(fft_frame);

% Unwrap phase
if phflag
    
    phspec = unwrap(phspec);
    
end

end
