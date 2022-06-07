function [harmonic_number,ind_harm_part] = harm_sel(cand_freq,harmonic_series,npart,nframe,nchannel,harmonic_distance_function,max_harm_dev)
%HARM_SEL Harmonic selection of partials.
%   Detailed explanation goes here

% DISTANCE USING HARMONICS AS REFERENCE
dist_mat = harmonic_distance_function(harmonic_series,cand_freq);
% $Id 2022 M Caetano SM 0.10.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 1: DECIDE WHICH PARTIAL IS HARMONIC AND WHICH IS SPURIOUS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MINIMUM DISTANCE ACROSS ROWS GIVES WHICH PARTIAL IS CLOSEST TO EACH
% HARMONIC
% IND_PARTIAL IS THE COLUMN CORRESPONDING TO THE PARTIAL
[min_dist_harm2part,sub_ind_partial] = min(dist_mat,[],2);

% Convert to linear indices of size(SUB_IND_PARTIAL) to access all the
% pages corresponding to the original frames
% IMPORTANT! LIN_IND_PARTIAL is also used to index FREQ_PART to select the
% harmonic partials
lin_ind_partial = sub2ind([npart 1 nframe nchannel], sub_ind_partial,...
    ones(npart,1,nframe,nchannel),...
    permute(repmat([1:nframe],npart,1,nchannel),[1 4 2 3]),...
    permute(permute([1:nchannel],[1 3 2]).*ones(npart,nframe),[1 4 2 3]));

% SELECTING THE DISTANCES BELOW THE THRESHOLD WILL GIVE TRUE ONLY FOR THE
% PARTIALS THAT ARE (CLOSE TO) HARMONIC
is_below_thresh = min_dist_harm2part < max_harm_dev;

% LINEAR INDEX OF PARTIALS THAT ARE HARMONIC
ind_harm_part = lin_ind_partial(is_below_thresh);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART 2: CHECK WHICH HARMONICS ARE PRESENT AMONG PARTIALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MINIMUM DISTANCE ACROSS COLUMNS GIVES WHICH HARMONIC IS CLOSEST TO EACH
% PARTIAL
% IND_HARMONIC IS THE ROW CORRESPONDING TO THE HARMONIC
[~,sub_ind_harmonic] = min(dist_mat);

% Convert SUB_IND_HARMONIC to linear indices corresponding to size(FREQ_PART)
lin_ind_harmonic = sub2ind([1 npart nframe nchannel],...
    ones(1,npart,nframe,nchannel), sub_ind_harmonic,...
    permute(repmat([1:nframe]',1,npart,nchannel),[4 2 1 3]),...
    permute(permute([1:nchannel],[1 3 2]).*ones(nframe,npart),[4 2 1 3]));

% SELECT ONLY PARTIALS THAT ARE HARMONIC TO GET THE LINEAR INDEX OF THE
% HARMONICS PRESENT AMONG THE PARTIALS
% HARMONIC_NUMBER is the linear index of the harmonics in FREQ_PART
harmonic_number = lin_ind_harmonic(ind_harm_part);

end
