function [phpeak,ph_slope,ph_intercept] = phase_interp(freq,ph,freqpeak)
%PHASE_INTERP Linear interpolation of phase value across frequency.
%   Detailed explanation goes here

% 2016 M Caetano
% 2019 MCaetano SMT 0.1.0 (Revised)
% 2020 MCaetano SMT 0.2.0% $Id 2020 M Caetano SM 0.3.1-alpha.2 $Id


% Number of frequency bins and number of frames
[nbin,nframe] = size(freqpeak);

% Initialize interpolated phase
phpos = nan(nbin,nframe);
phneg = nan(nbin,nframe);
freqpos = nan(nbin,nframe);
freqneg = nan(nbin,nframe);

% One-page array with FALSE
op = false(nbin,nframe);

% Two-page array with FALSE
tp = false(nbin,nframe,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQPEAK TO THE RIGHT OF FREQ(:,:,2) (POSITIVE RATIONAL BIN NUMBER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ibin = freqpeak > freq(:,:,2);

% Indices for third page
itp = cat(3,tp,ibin);

% Indices for second page
isp = cat(3,op,ibin,op);
%isp = circshift(itp,-1,3);

% Third page of PH
phpos(ibin) = ph(itp);

% Third page of FREQ
freqpos(ibin) = freq(itp);

% Second page of PH
phneg(ibin) = ph(isp);

% Second page of FREQ
freqneg(ibin) = freq(isp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FREQPEAK TO THE LEFT OF FREQ(:,:,2) (NEGATIVE RATIONAL BIN NUMBER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ibin = freqpeak < freq(:,:,2);

% Indices for first page
ifp = cat(3,ibin,tp);

% Indices for second page
isp = cat(3,op,ibin,op);
%isp = circshift(ifp,1,3);

% Second page of PH
phpos(ibin) = ph(isp);

% Second page of FREQ
freqpos(ibin) = freq(isp);

% First page of PH
phneg(ibin) = ph(ifp);

% First page of FREQ
freqneg(ibin) = freq(ifp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LINEAR INTERPOLATION OF PHASE USING 2-POINT LINE FIT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Slope
ph_slope = (phpos - phneg) ./ (freqpos - freqneg);

% Linear term (intercept)
ph_intercept = (freqneg.*phpos - freqpos.*phneg) ./ (freqneg - freqpos);

% Linear interpolation of phase
phpeak = ph_slope.*freqpeak + ph_intercept;

end
