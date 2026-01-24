function [BOLDresponse] = extBOLDresponse(timeseries)
% extBOLDresponse - Extract BOLD responses for all subjects from group time series
%
% This function processes group-level time series data to extract
% stimulus-locked BOLD responses for each subject. It serves as a
% wrapper for extSingleBOLDresponse, processing all subjects in a group.
%
% Syntax:
%   [BOLDresponse] = extBOLDresponse(timeseries)
%
% Input:
%   timeseries - [nSub x nTime x nROI] 3D array of group time series
%                nSub: number of subjects in the group
%                nTime: total time points per session (typically 680)
%                nROI: number of ROIs (28)
%
% Output:
%   BOLDresponse - [nSub x 120 x 5 x nROI] 4D array of BOLD responses
%                  nSub: number of subjects
%                  120: time window per trial (-20 to +99 seconds)
%                  5: number of stimulation trials
%                  nROI: number of ROIs
%
% Notes:
%   - Calls extSingleBOLDresponse for each subject
%   - Time window: 120 points (20 pre-stim + 100 post-stim)
%   - Data is baseline-corrected (mean of pre-stimulus period subtracted)
%
% Example:
%   listing = makeList('/data/session1', '*TPH*');
%   timeseries = extGroupTSROI(listing, 'blue', 'tph');
%   BOLDresponse = extBOLDresponse(timeseries);
%
% See also: extSingleBOLDresponse, extGroupTSROI, visualizeBOLDresponses
%
% Author: Hiroaki Taiyo Hamada, Araya Inc.
% Date: 2019/Sep/22

% nSub, nTIm, nROI
[nSub, nTime, nROI] = size(timeseries);
nTime2 = 120;

BOLDresponse = zeros(nSub,nTime2,5,nROI);

for nsub = 1:nSub,
    tempsignal = squeeze(timeseries(nsub,:,:));
    BOLDresponse(nsub,:,:,:) = extSingleBOLDresponse(tempsignal);
end