function [amp,freq,ph] = freq_matching(amp,freq,ph,A,F,P,delta,hop,fs,ifr)
%FREQ_MATCHING Match parameters of spectral peaks between consecutive
%frames [1].
%
%   [amp,freq,ph] = FREQ_MATCHING(amp,freq,ph,A,F,P,delta,hop,fs,ifr)
%
%   See also PEAK2TRACK, PARTIAL_MATCHING
%
% [1] McAulay,R.J. and T.F. Quatieri (1986, August). Speech analysis/synthesis
% based on a sinusoidal representation. IEEE Transactions on Acoustics,
% Speech, and Signal Processing ASSP-34(4),744-754.

% 2020 MCaetano SMT 0.2.1 (Revised)% $Id 2020 M Caetano SM 0.3.1-alpha.4 $Id


% Indices of numeric frequencies
ifreq_curr = find(~isnan(freq(:,end)));
ifreq_next = find(~isnan(F));

% Number of peaks
npeak_curr = length(ifreq_curr);
npeak_next = length(ifreq_next);

%%%%%%%%%%%%%%%
% GUIDELINES
%%%%%%%%%%%%%%%
% NaN: no data
% 0: Birth
% -1: Death
% n > 0: matching peak number (Match)

% No peaks in CURR => Only BIRTH
if isempty(ifreq_curr) && ~isempty(ifreq_next)
    
    % No data in CURR
    peak_curr = nan(npeak_curr,1);
    
    % NPEAK_NEXT peaks born in NEXT
    % BIRTH: NEXT == 0
    peak_next = zeros(npeak_next,1);
    
    % No peaks in NEXT => Only DEATH
elseif ~isempty(ifreq_curr) && isempty(ifreq_next)
    
    % NPEAK_CURR peaks die in CURR
    % DEATH: CURR == -1
    peak_curr = -ones(npeak_curr,1);
    
    % NPEAK_NEXT peaks born in NEXT
    peak_next = nan(npeak_next,1);
    
    % Silence
elseif isempty(ifreq_curr) && isempty(ifreq_next)
    
    % No data in CURR
    peak_curr = nan(npeak_curr,1);
    
    % No data in NEXT
    peak_next = nan(npeak_curr,1);
    
    % Both CURR and NEXT have peaks
else
    
    % Initialize auxiliary variables
    peak_curr = nan(npeak_curr,1);
    peak_next = zeros(npeak_next,1);
    
    % Initialize last peak matched
    last_match = 0;
    
    % For each peak of the CURR frame
    for ipeak_curr = 1:npeak_curr
        
        % Indices of unmatched peaks of the NEXT frame
        ipeak_next = last_match+1:npeak_next;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % STEP 1: FIND CANDIDATE MATCH
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % Frequency difference between CUR peak and unmatched peaks in NEXT
        candidate_freq_diff = abs(freq(ifreq_curr(ipeak_curr),end) - F(ifreq_next(ipeak_next)));
        
        % Indices of peaks in NEXT within matching interval DELTA
        ind_candidate_match = candidate_freq_diff <= delta;
        
        % If there are peaks in NEXT within DELTA
        if any(ind_candidate_match)
            
            % Candidate match gets the minimum frequency difference
            [min_freq_diff,ind_min_freq_diff] = min(candidate_freq_diff);
            
            % Keep index of matching NEXT peak to confirm match in STEP 2
            ind_cand_match = ipeak_next(ind_min_freq_diff);
            
        else
            
            % DEATH: CURR == -1
            ind_cand_match = -1;
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % STEP 2: CONFIRM CANDIDATE MATCH
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % If there was a match
        if ind_cand_match > 0
            
            % Frequency difference between all peaks above CURR and MATCH
            confirm_freq_diff = abs(freq(ifreq_curr(ipeak_curr+1:npeak_curr),end) - F(ifreq_next(ind_cand_match)));
            
            % Indices of peaks in CURR with smaller difference than MATCH
            ind_confirm_match = confirm_freq_diff < min_freq_diff;
            
            % Test if any higher frequency of current frame is a better match
            if any(ind_confirm_match)
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                % 2 CASES: FINAL MATCH or DEATH
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                
                % Check if previous peak in next frame in unmatched and within DELTA
                if ind_cand_match > 1 && ind_cand_match-1 ~= last_match && abs(freq(ifreq_curr(ipeak_curr),end)-F(ifreq_next(ind_cand_match-1))) < delta
                    
                    % FINAL MATCH: CURR matches with previous peak instead
                    peak_curr(ipeak_curr) = ind_cand_match - 1;
                    peak_next(ind_cand_match-1) = ipeak_curr;
                    
                    % Update LAST_MATCH
                    last_match = ind_cand_match - 1;
                    
                else
                    
                    % DEATH: CURR == -1
                    peak_curr(ipeak_curr) = -1;
                    
                end
                
            else % Confirm match
                
                % CURR matches with NEXT and vice-versa
                peak_curr(ipeak_curr) = ind_cand_match;
                peak_next(ind_cand_match) = ipeak_curr;
                
                % Update LAST_MATCH
                last_match = ind_cand_match;
                
            end
            
        else % No match: Death of CURR
            
            % DEATH: CURR == -1
            peak_curr(ipeak_curr) = -1;
            
        end % END If there was a match
        
    end % END For each peak of the CURR frame
    
end % END If CURR has peaks

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STEP 3: UNMATCHED PEAKS IN NEXT ARE BORN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Indices of Births (NPEAK_NEXT)
ipeak_birth = peak_next==0;

% Number of Births
npeak_birth = nnz(ipeak_birth);

% Indices of Deaths (NPEAK_CURR)
ipeak_death = peak_curr==-1;

% Number of Deaths
npeak_death = nnz(ipeak_death);

% Indices of matches (CURR)
ipeak_match_curr = peak_curr~=-1;

% Indices of matches (NEXT)
ipeak_match_next = peak_next~=0;

% Number of Matches
% npeak_match = nnz(ipeak_match_next); % (same as below)
npeak_match = nnz(ipeak_match_curr);

% Total number of partial tracks
npartial = npeak_birth + npeak_death + npeak_match;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT BIRTH FREQUENCIES INTO CORRESPONDING PARTIAL BY FREQUENCY
% Concatenate frequencies by event: [DEATH; MATCH; BIRTH] and sort the
% frequencies in ascending order. Compare the indices of the sorted
% frequencies with their original positions to insert the events into the
% corresponding frequency slot (i.e., partials arranged in ascending
% frequency)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concatenate frequencies by event: [DEATH; MATCH; BIRTH]
event_curr = [freq(ifreq_curr(ipeak_death),end);freq(ifreq_curr(ipeak_match_curr),end);F(ifreq_next(ipeak_birth))];
% event_next = [freq(ifreq_curr(ipeak_death),end);F(ifreq_next(ipeak_match_next));F(ifreq_next(ipeak_birth))];

% Sort frequencies in ascending order
[~,ind_curr] = sort(event_curr);
% [~,ind_next] = sort(event_next);

% Get indices in CURR by event: [DEATH; MATCH; BIRTH]
ipart_death_curr = ind_curr <= npeak_death;
ipart_match_curr = ind_curr > npeak_death & ind_curr <= npeak_death + npeak_match;
ipart_birth_curr = ind_curr > npeak_death + npeak_match;

% % Get indices in NEXT by event: [DEATH; MATCH; BIRTH]
% ipart_death_next = ind_next <= npeak_death;
% ipart_match_next = ind_next > npeak_death & ind_next <= npeak_death + npeak_match;
% ipart_birth_next = ind_next > npeak_death + npeak_match;

% if ~isequal(ipart_death_curr,ipart_death_next)
%     disp('Freak out!');
% end
%
% if ~isequal(ipart_match_curr,ipart_match_next)
%     disp('Indexes of MATCH changes');
% end
%
% if ~isequal(ipart_birth_curr,ipart_birth_next)
%     disp('Freak out!');
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASSIGN PARTIALS BY EVENT: BIRTH; DEATH; MATCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize variables
new_amp = nan(npartial,ifr+1);
new_freq = nan(npartial,ifr+1);
new_ph = nan(npartial,ifr+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle MATCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if npeak_match ~= 0
    
    % Convert subscripts to linear indexing (for previous frames)
    rowsub = repmat(ifreq_curr(peak_next(ipeak_match_next)),1,ifr);
    colsub = repmat(1:ifr,npeak_match,1);
    inext = sub2ind([npeak_curr ifr],rowsub,colsub);
    
    % Create multi-frame logical index matrix
    ipart = repmat(ipart_match_curr,1,ifr);
    
    % Between frame 1 and NFR
    new_amp(ipart) = amp(inext);
    new_freq(ipart) = freq(inext);
    new_ph(ipart) = ph(inext);
    
    % frame NFR+1
    new_amp(ipart_match_curr,ifr+1) = A(ifreq_next(peak_curr(ipeak_match_curr)));
    new_freq(ipart_match_curr,ifr+1) = F(ifreq_next(peak_curr(ipeak_match_curr)));
    new_ph(ipart_match_curr,ifr+1) = P(ifreq_next(peak_curr(ipeak_match_curr)));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle DEATH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if npeak_death ~= 0
    
    % Convert subscripts to linear indexing (for previous frames)
    rowsub = repmat(ifreq_curr(ipeak_death),1,ifr);
    colsub = repmat(1:ifr,npeak_death,1);
    iprev = sub2ind([npeak_curr ifr],rowsub,colsub);
    
    % Create multi-frame logical index matrix
    ipart = repmat(ipart_death_curr,1,ifr);
    
    % Between frame 1 and NFR
    new_freq(ipart) = freq(iprev);
    new_amp(ipart) = amp(iprev);
    new_ph(ipart) = ph(iprev);
    
    % frame NFR+1
    new_freq(ipart_death_curr,ifr+1) = freq(ifreq_curr(ipeak_death),ifr);
    new_amp(ipart_death_curr,ifr+1) = 0;
    new_ph(ipart_death_curr,ifr+1) = ph(ifreq_curr(ipeak_death),ifr) + 2*pi*freq(ifreq_curr(ipeak_death),ifr)*hop/fs;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle BIRTH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if npeak_birth ~= 0
    
    % Between frame 1 and NFR-1 (REBIRTH)
    
    % frame NFR
    new_freq(ipart_birth_curr,ifr) = F(ifreq_next(ipeak_birth));
    new_amp(ipart_birth_curr,ifr) = 0;
    new_ph(ipart_birth_curr,ifr) = P(ifreq_next(ipeak_birth)) - 2*pi*F(ifreq_next(ipeak_birth))*hop/fs;
    
    % frame NFR+1
    new_freq(ipart_birth_curr,ifr+1) = F(ifreq_next(ipeak_birth));
    new_amp(ipart_birth_curr,ifr+1) = A(ifreq_next(ipeak_birth));
    new_ph(ipart_birth_curr,ifr+1) = P(ifreq_next(ipeak_birth));
    
end

amp = new_amp;
freq = new_freq;
ph = new_ph;

end
