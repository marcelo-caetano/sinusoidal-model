function harm_series = mkharm(f0,npart,nframe,nchannel)
%MKHARM Make time-varying harmonic series.
%   Detailed explanation goes here

harm_series = f0.*repmat((1:npart)',1,nframe,nchannel);
% $Id 2022 M Caetano SM 0.11.0-alpha.1 $Id


end
