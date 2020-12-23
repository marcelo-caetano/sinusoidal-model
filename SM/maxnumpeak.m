function [amp,freq,ph] = maxnumpeak(peak_amp,peak_freq,peak_ph,maxnpeak,nbin,nframe,npeakflag)
%MAXNUMPEAK Maximum number of peaks.
%   [A,F,P] = MAXNUMPEAK(Ap,Fp,Pp,MAXNPEAK,NPEAK,NFRAME) selects up to
%   MAXNPEAKS peaks per frame with the highest amplitude. Ap are the
%   amplitudes of the spectral peaks returned by PEAK_PICKING, Fp are the
%   frequencies of the spectral peaks, and Pp are the phases. Ap, Fp, and
%   Pp are NBIN x NFRAME matrices, where NBIN is the number of positive
%   frequency bins and NFRAME is the number of frames. A, F, and P have a
%   fixed size with at most MAXNPEAK values, where NaN fills empty spaces.
%
%   See also ABSDB, RELDB

% 2020 MCaetano SMT 0.1.2 (Revised)% $Id 2020 M Caetano SM 0.3.1-alpha.2 $Id


% TODO: Add option to return only MAXNPEAK per frame: size(amp)=[MAXNPEAK,NFRAME]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK FUNCTION INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(6,6);

% Check number of output arguments
nargoutchk(0,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 6
    
    % Flag to return NBIN x NFRAME when TRUE and MAXNPEAK x NFRAME when false
    npeakflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isinf(maxnpeak)
    
    % Return the inputs
    amp = peak_amp;
    freq = peak_freq;
    ph = peak_ph;
    
elseif maxnpeak >= nbin
    
    % Return the inputs
    amp = peak_amp;
    freq = peak_freq;
    ph = peak_ph;
    
else
    
    % Sort peaks by DESCENDING amplitudes (placing NaN last)
    [~,index_sorted] = sort(peak_amp,'descend','MissingPlacement','last');
    
    % Get indices of MAXNPEAK peaks per frame
    trunc_index = index_sorted(1:maxnpeak,:);
    
    % Recover original position (ascending index == original frequency)
    sort_trunc_index = sort(trunc_index,'ascend');
    
    % IMPORTANT! The next step is necessary to address row and column correctly
    % PEAK_AMP(SORT_TRUNC_INDEX) with numerical indices requires linear
    % indexing but SORT sorts each column independently and returns indices
    % relative to each column. Logical indexing would avoid this step.
    
    % Convert from row array indices (per column) to linear indices
    sort_trunc_linear_index = sub2ind([nbin,nframe],sort_trunc_index,repmat(1:nframe,maxnpeak,1));
    
    if npeakflag
        
        % Initialize variables
        amp = nan(nbin,nframe);
        freq = nan(nbin,nframe);
        ph = nan(nbin,nframe);
        
        % Return NBIN amplitudes (with at most MAXNPEAK values)
        amp(sort_trunc_linear_index) = peak_amp(sort_trunc_linear_index);
        
        % Return NBIN frequencies (with at most MAXNPEAK values)
        freq(sort_trunc_linear_index) = peak_freq(sort_trunc_linear_index);
        
        % Return NBIN phases (with at most MAXNPEAK values)
        ph(sort_trunc_linear_index) = peak_ph(sort_trunc_linear_index);
        
    else
        
        % Return MAXNPEAK amplitudes
        amp = peak_amp(sort_trunc_linear_index);
        
        % Return MAXNPEAK frequencies
        freq = peak_freq(sort_trunc_linear_index);
        
        % Return MAXNPEAK phases
        ph = peak_ph(sort_trunc_linear_index);
        
    end
    
end

end
