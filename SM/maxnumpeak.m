function [amp,freq,ph] = maxnumpeak(peak_amp,peak_freq,peak_ph,maxnpeak)
%MAXNUMPEAK Maximum number of peaks.
%   [A,F,P] = MAXNUMPEAK(Ap,Fp,Pp,M) selects up to M peaks per frame with
%   the highest amplitude in the amplitudes Ap, frequencies Fp, and phases
%   Pp and returns A, F, and P with M peaks per frame.
%
%   See also ABSDB, RELDB

% 2020 MCaetano SMT 0.1.2 (Revised)

% Number of peaks and number of frames
[npeak,nframe] = size(peak_amp);

if maxnpeak >= npeak
    
    % Return the inputs
    amp = peak_amp;
    freq = peak_freq;
    ph = peak_ph;
    
else
    
    % Initialize variables
    amp = nan(npeak,nframe);
    freq = nan(npeak,nframe);
    ph = nan(npeak,nframe);
    
    % Sort peaks by DESCENDING amplitudes (placing NaN last)
    [~,index_sorted] = sort(peak_amp,'descend','MissingPlacement','last');
    
    % Get indices of MAXNPEAK peaks per frame
    trunc_index = index_sorted(1:maxnpeak,:);
    
    % Recover original position (in ascending frequency)
    sort_trunc_index = sort(trunc_index,'ascend','MissingPlacement','last');
    
    % Convert from row array indices (per column) to linear indices (address row and column correctly)
    sort_trunc_linear_index = sub2ind([npeak,nframe],sort_trunc_index,repmat(1:nframe,maxnpeak,1));
    
    % Return MAXNPEAK amplitudes
    amp(sort_trunc_linear_index) = peak_amp(sort_trunc_linear_index);
    
    % Return MAXNPEAK frequencies
    freq(sort_trunc_linear_index) = peak_freq(sort_trunc_linear_index);
    
    % Return MAXNPEAK phases
    ph(sort_trunc_linear_index) = peak_ph(sort_trunc_linear_index);
    
end

end
