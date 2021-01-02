function [amp,freq,ph] = absdb(amp,freq,ph,absthres)
%ABSDB Set absolute threshold in dB.
%   [A,F,P] = ABSDB(A,F,P,ABSTHRES) sets the amplitudes A, frequencies F,
%   and phases P that are below ABSTHRES to NaN.
%
%   See also RELDB

% 2020 MCaetano SMT 0.1.1% $Id 2020 M Caetano SM 0.3.1-alpha.4 $Id


% Convert log threshold into linear
linthres = log2lin(-(abs(absthres)),'dbp');

% Find indices of amplitudes below the threshold
ind = amp < linthres;

% Replace with NaN
amp(ind) = nan(1);
freq(ind) = nan(1);
ph(ind) = nan(1);

end
