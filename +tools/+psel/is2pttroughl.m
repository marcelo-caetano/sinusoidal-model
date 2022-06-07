function bool_trough = is2pttroughl(mag)
% IS2PTTROUGHL True for left symmetrical troughs of the magnitude spectrum.
%   BOOL = IS2PTTROUGHL(MAG) returns a logical vector BOOL with the
%   positions of the left symmetrical troughs of MAG. BOOL is the same size
%   as MAG and contains TRUE for positions that correspond to left symmetrical
%   troughs and FALSE otherwise. A left symmetrical trough is defined as a
%   spectral magnitude MAG that is equal to its immediate neighbor to the
%   left and lower than its immediate neighbor to the right.
%
%   See also IS3PTPEAK, ISPEAK

% 2016 M Caetano;
% Revised 2019 SMT 0.1.1
% 2020 MCaetano SMT 0.1.1 (Revised)
% 2021 M Caetano SMT (Stereo processing)
% $Id 2022 M Caetano SM 0.10.0-alpha.1 $Id


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHECK ARGUMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Check number of input arguments
narginchk(1,1);

% Check number of output arguments
nargoutchk(0,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of frames and number of channels
[~,nframe,nchannel] = size(mag);

% Positions of the symmetrical troughs of the magnitude spectrum
% bool_trough = [false(1,nframe,nchannel) ; mag(1:end-2,:,:) == mag(2:end-1,:,:) & mag(2:end-1,:,:) < mag(3:end,:,:) ; false(1,nframe,nchannel)];

% First and last positions are always FALSE (No symmetrical troughs in DC or Nyquist)
notrough = false(1,nframe,nchannel);

% TRUE when left MAG is equal to right MAG
bool_left = mag(1:end-2,:,:) == mag(2:end-1,:,:);

% TRUE when right MAG is lower than left MAG
bool_right = mag(2:end-1,:,:) < mag(3:end,:,:);

% TRUE for symmetrical trough (Left MAG is equal and right MAG is lower)
bool_lr = bool_left & bool_right;

% Concatenate vertically
% bool_trough = cat(1,notrough,bool_lr,notrough);
% bool_trough = vertcat(notrough,bool_lr,notrough);
bool_trough = [notrough ; bool_lr ; notrough];

end
