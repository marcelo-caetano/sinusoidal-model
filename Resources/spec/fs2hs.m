function half_spec = fs2hs(full_spec,nfft,nrgflag)
%FS2HS Full spectrum to half spectrum.
%   H = FS2HS(F,NFFT) returns the non-negative frequency half H of the
%   complex-valued NFFT-point full FFT spectrum F.
%
%   H = FS2HS(F,NFFT,NRGFLAG) uses THE logical flag NRGFLAG to add the 
%   spectral energy of the negative frequency band into H. NRGFLAG = TRUE
%   adds the negative energy AND NRGFLAG = FALSE does not. The default is
%   FALSE when FS2HS(F,NFFT).
%
%   See also HS2FS, FFT2MAG, FFT2PH, FFT2PMS, FFT2PPS

% 2020 M Caetano SMT 0.1.2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(2,3);

% Check number of output arguments
nargoutchk(0,1);

if nargin == 2
    
    nrgflag = false;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Nyquist index
inyq = nyq(nfft);

% Positive half of FFT
half_spec = full_spec(1:inyq,:);

if nrgflag
    
    % Add spectral energy of negative half
    half_spec(2:inyq-1,:) = 2*full_spec(2:inyq-1,:);
    
end

end
