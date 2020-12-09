function [amp,freq,ph,npart] = sm_peak2peak(amplitude,frequency,phase,delta,hop,fs,nframe)
%PEAK2PEAK Peak-to-peak frequency matching.
%   [Amp,Freq,Ph] = PEAK2PEAK(A,F,P,DELTA,HOP,FS,NFRAME) performs partial
%   tracking using the peak-to-peak frequency matching algorithm adapted
%   from [1].
%
% [1] McAulay and Quatieri (1986) Speech Analysis/Synthesis Based on a
% Sinusoidal Representation, IEEE TRANSACTIONS ON ACOUSTICS, SPEECH,
% AND SIGNAL PROCESSING, VOL. ASSP-34, NO. 4.

% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.3.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(7,7);

% Check number of output arguments
nargoutchk(0,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize variables
amp = amplitude(:,1);
freq = frequency(:,1);
ph = phase(:,1);

% Frame-to-frame frequency matching
for iframe = 2:nframe
    
    % Frequency matching
    [amp,freq,ph] = sm_freq_matching(amp,freq,ph,amplitude(:,iframe),frequency(:,iframe),phase(:,iframe),delta,hop,fs,iframe-1);
    
end

% Number of Partials
npart = size(amp,1);

end
