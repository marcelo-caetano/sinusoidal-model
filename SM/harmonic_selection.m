function [harm_amp,harm_freq,harm_ph,nharm] = harmonic_selection(amp_part,freq_part,ph_part,npart,nframe,nchannel,f0,max_harm_dev)
%HARMONIC_SELECTION Selection of harmonic partials.
%   Detailed explanation goes here
%
%   See also

% 2022 MCaetano SMT
% $Id 2022 M Caetano SM 0.10.0-alpha.1 $Id


harmonic_series = permute(tools.harm.mkharm(f0,npart,nframe,nchannel),[1 4 2 3]);

cand_freq = permute(freq_part,[4 1 2 3]);

harm_dist = @(ref,cand) abs(tools.mus.hertz2cents(cand,ref));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HARMONIC SELECTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[harmonic_number,ind_harm_part] = tools.harm.harm_sel(cand_freq,harmonic_series,npart,nframe,nchannel,harm_dist,max_harm_dev);

% Initialize HARMONIC_PARTIAL so the assignment below will keep the shape
% of HARMONIC_PARTIAL the same as size(FREQ_PART)
tmp_harm_amp = nan(npart,nframe,nchannel);
tmp_harm_freq = nan(npart,nframe,nchannel);
tmp_harm_ph = nan(npart,nframe,nchannel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGN HARMONIC PARTIALS TO CORRESPONDING HARMONIC NUMBER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp_harm_amp(harmonic_number) = amp_part(ind_harm_part);
tmp_harm_freq(harmonic_number) = freq_part(ind_harm_part);
tmp_harm_ph(harmonic_number) = ph_part(ind_harm_part);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ONLY RETURN NHARM HARMONICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The highest harmonic number (row subscript) is the number of harmonics
[row,~,~] = ind2sub([npart,nframe,nchannel],harmonic_number);
nharm = max(row(:));

harm_amp = tmp_harm_amp(1:nharm,:,:);
harm_freq = tmp_harm_freq(1:nharm,:,:);
harm_ph = tmp_harm_ph(1:nharm,:,:);

end
