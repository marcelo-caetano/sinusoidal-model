function [amp,freq,ph] = reldb(amp,freq,ph,relthres)
%RELDB Set the relative threshold in dB.
%   [A,F,P] = RELDB(A,F,P,RELTHRES) sets the amplitudes A, frequencies F,
%   and phases P that are RELTHRES below the maximum of each frame to NaN.
%
%   See also ABSDB

% 2019 MCaetano SMT 0.1.0
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.4.0-alpha.1 $Id


% Maximum amplitude per frame
maxamp = max(amp,[],1,'omitnan');

% Sum in dB
relampdB = lin2log(maxamp,'dbp') - abs(relthres);

% Convert from dB to linear to compare
ind = amp < log2lin(relampdB,'dbp');

% Replace with NaN
amp(ind) = nan(1);
freq(ind) = nan(1);
ph(ind) = nan(1);

end
