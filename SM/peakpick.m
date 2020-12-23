function index = peakpick(mag)
% PEAKPICK pick indices of the peaks of the magnitude spectrum.
%   INDEX = PEAKPICK(MAG) returns a logical vector INDEX with the
%   indices of the peaks of the magnitude spectrum MAG.
%
%   MAG is NFREQ x NFRAME, where NFREQ is the number of frequency bins and
%   NFRAME is the number of frames of the STFT. Typically, NFREQ = NYQ(NFFT)
%   and NFRAME = NUMFRAME(NSAMPLE,M,H,CFWFLAG). Type HELP NYQ and HELP
%   NUMFRAME for their syntaxes.
%
%   INDEX is the same size as MAG and contains logical 1 for positions
%   that correspond to peaks and logical 0 otherwise.
%
%   See also PEAKFIND, NYQ, NUMFRAME

% 2016 M Caetano;
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2020 M Caetano SM 0.3.1-alpha.2 $Id


[~,nframe] = size(mag);

mag(isinf(mag)) = 0;

mag(isnan(mag)) = 0;

index = [false(1,nframe) ; mag(2:end-1,:) > mag(1:end-2,:) & mag(2:end-1,:) > mag(3:end,:) ; false(1,nframe)];

end
