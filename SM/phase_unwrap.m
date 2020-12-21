function ph_spec = phase_unwrap(fft_frame,nfft)
%PHASE_UNWRAP Unwrap phase of FFT frames.
%   P = PHASE_UNWRAP(FFT_FR,NFFT) unwraps the phase of the FFT frames in
%   FFT_FR and returns the positive half of the phase spectrum in P.

% 2020 MCaetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.1-alpha.1 $Id


% From FFT to positive phase spectrum
ph_spec = fft2pps(fft_frame,nfft);

% Unwrap PPS
ph_spec = unwrap(ph_spec);

end

