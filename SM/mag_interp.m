function [amppeak,freqpeak,a] = mag_interp(amp,freq)
%QUAD_INTERP Quadratic interpolation.
%   [Xm,Ym] = QUAD_INTERP(X,Y) returns the points (Xm,Ym) corresponding to
%   the vertex of the parabola fit to [X,Y], where X = [x1 x2 x3] and
%   Y = [y1 y2 y3].
%
%   Y-Ym = a(X-Xm)^2
%
%   Xm = ((y2-y1)(x3-x1)(x3+x1)+(y1-y3)(x2-x1)(x2+x1))/(2(y3-y1)(x1-x2)+(y1-y2)(x1-x3));
%   a = (y2-y1)/((x2-x1)(x1+x2-2*amppeak));
%   Ym = y1-a*(x1-amppeak)^2;
%
%   Maximum
%   Xm = x0/(2*a);
%
%   Ym = a*(Xm-x0)^2+y0;

% 2016 M Caetano
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.1 (Revised)% $Id 2020 M Caetano SM 0.3.1-alpha.2 $Id


amppeak = ((freq(:,:,2) - freq(:,:,1)).*(amp(:,:,3) - amp(:,:,1)).*(amp(:,:,3) + amp(:,:,1)) + ...
    (freq(:,:,1) - freq(:,:,3)).*(amp(:,:,2) - amp(:,:,1)).*(amp(:,:,2) + amp(:,:,1)))...
    ./ ( 2*( (freq(:,:,3) - freq(:,:,1)).*(amp(:,:,1) - amp(:,:,2)) + (freq(:,:,1) - ...
    freq(:,:,2)).*(amp(:,:,1) - amp(:,:,3)) ) );

a = (freq(:,:,2) - freq(:,:,1)) ./ ( (amp(:,:,2) - amp(:,:,1)).*(amp(:,:,1) + amp(:,:,2) - 2*amppeak) );

freqpeak = freq(:,:,1) - a.*(amp(:,:,1) - amppeak).^2;

end
