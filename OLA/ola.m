function [olasynth,olawin] = ola(time_frame,framelen,hop,nsample,center_frame,winflag,cfwflag)
%OLA Overlap-Add time frames to resynthesize the original signal.
%
%   SYNTH = OLA(FR,M,H,NSAMPLE,CFR,WINFLAG,CFWFLAG) overlap-adds the time
%   frames FR by M - H, where M is the frame length and H is the hop size
%   used to make the time frames and returns SYNTH.
%
%   NSAMPLE is the length of the original signal in samples. NSAMPLE is
%   usually different than CFW+(NFRAME-1)*H because the last frame is
%   always zero-padded to M. Therefore, SYNTH must be truncated to NSAMPLE
%   to recover the original signal length.
%
%   CFR is an array with the samples corresponding to the center of the
%   frames.
%
%   WINFLAG is a numeric flag that specifies the following windows
%
%   1 - Rectangular
%   2 - Bartlett
%   3 - Hann
%   4 - Hanning
%   5 - Blackman
%   6 - Blackman-Harris
%   7 - Hamming
%
%   CFWFLAG is a flag that determines the center of the first analysis
%   window. CFWFLAG can be 'ONE', 'HALF', or 'NHALF'. The sample CFW
%   corresponding to the center of the first window is obtained as
%   CFW = cfw(M,CFWFLAG). See help cfw for further details.
%
%   [SYNTH,OLAWIN] = OLA(...) also returns the overlap-added window OLAWIN
%   specified by WINFLAG.

% 2016 M Caetano
% 2020 MCaetano SMT 0.1.1 (Revised)

% Ensure CFRAME is a column vector
if size(center_frame,1) == 1
    center_frame = center_frame';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ZERO-PADDING AT THE BEGINNING AND END OF SIGNAL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

switch lower(cfwflag)
    
    case 'one'
        
        % SHIFT is the number of zeros before CW
        shift = lhw(framelen);
        
    case 'half'
        
        % SHIFT is the number of zeros before CW
        shift = 0;
        
    case 'nhalf'
        
        % SHIFT is the number of zeros before CW
        shift = framelen;
        
    otherwise
        
        warning(['SMT:InvalidFlag: ','CFWFLAG must be ONE, HALF, or NHALF.\n'...
            'CFWFLAG entered was %s. Using default value ONE'],cfwflag);
        
        % SHIFT is the number of zeros before CW
        shift = lhw(framelen);
        
end

% Preallocate with zero-padding
olasynth = zeros(nsample+2*shift,1);
olawin = zeros(nsample+2*shift,1);

% Make synthesis window
synthesis_window = mkcolawin(framelen,winflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OVERLAP-ADD PROCEDURE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for cf = center_frame'
    
    % Frame number
    iframe = s2f(cf,cfw(framelen,cfwflag),hop);
    
    olasynth(cf-lhw(framelen)+shift:cf+rhw(framelen)+shift) = olasynth(cf-lhw(framelen)+shift:cf+rhw(framelen)+shift) + time_frame(:,iframe);
    
    olawin(cf-lhw(framelen)+shift:cf+rhw(framelen)+shift) = olawin(cf-lhw(framelen)+shift:cf+rhw(framelen)+shift) + synthesis_window;
    
end

% Remove zero-padding
olasynth = olasynth(1+shift:nsample+shift);
olawin = olawin(1+shift:nsample+shift);

end
