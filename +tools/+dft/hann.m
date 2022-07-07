function mag = hann(bin,framelen,nfft,normflag,zphflag)
%HANN Discrete Fourier transform of the Hann window.
%   W = HANN(BIN,FRAMELEN,NFFT,NORMFLAG,ZPHFLAG) returns the size-NFFT DFT
%   of the Hann window with FRAMELEN samples over the range BIN. NORMFLAG
%   is a logical flag that determines if W is normalized by FRAMELEN.
%   NORMFLAG = TRUE sets normalization and NORMFLAG = FALSE does not.
%   ZPHFLAG is a logical flag that determines if W is zero phase or linear
%   phase. ZPHFLAG = TRUE sets zero-phase and ZPHFLAG = FALSE sets linear-phase.
%
%   The input BIN and the output W are structures containing the fields POS
%   and NEG with the positive and negative frequencies respectively.
%
%   See also RECT, HAMMING, BLACKMAN, BLACKMANHARRIS

% 2021 M Caetano SMT
% $Id 2022 M Caetano SM 0.11.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check the number of input arguments
narginchk(5,5);

% Check the number of output arguments
nargoutchk(0,1);

validateattributes(bin,{'struct'},{'real'},mfilename,'BIN',1)

validateattributes(framelen,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'FRAMELEN',2)

validateattributes(nfft,{'numeric'},{'scalar','finite','nonnan','integer','real','positive'},mfilename,'NFFT',3)

validateattributes(normflag,{'numeric','logical'},{'scalar','binary'},mfilename,'NORMFLAG',4)

validateattributes(zphflag,{'numeric','logical'},{'scalar','binary'},mfilename,'ZPHFLAG',5)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Coefficients
coeff1 = 0.5;
coeff2 = 0.5;

% Positive frequencies
mag.pos = tools.dft.doubledirich(bin.pos,framelen,nfft,coeff1,coeff2,normflag,zphflag);

% Negative frequencies
mag.neg = tools.dft.doubledirich(bin.neg,framelen,nfft,coeff1,coeff2,normflag,zphflag);

end
