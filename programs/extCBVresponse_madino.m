function [CBVresponse] = extCBVresponse_madino(timeseries)
% extCBVresponse_madino - Extract CBV responses for Mandino/Grandjean dataset
%
% This function processes group-level CBV (Cerebral Blood Volume) time series 
% from the Mandino/Grandjean dataset to extract stimulus-locked responses.
% Used for cross-study validation with the main BOLD-fMRI results.
%
% Syntax:
%   [CBVresponse] = extCBVresponse_madino(timeseries)
%
% Input:
%   timeseries - [nSub x nTime x nROI] 3D array of CBV time series
%                nSub: number of subjects
%                nTime: total time points per session
%                nROI: number of ROIs
%
% Output:
%   CBVresponse - [nSub x 35 x 6 x nROI] 4D array of CBV responses
%                 nSub: number of subjects
%                 35: time window per trial (-5 to +29)
%                 6: number of stimulation trials (Mandino protocol)
%                 nROI: number of ROIs
%
% Notes:
%   - Mandino dataset uses CBV-fMRI (different from BOLD-fMRI in main study)
%   - 6 stimulation trials vs 5 in main study
%   - Shorter baseline window (5 points vs 20 points)
%
% Reference:
%   Grandjean et al. dataset: https://doi.org/10.18112/openneuro.ds001541.v1.1.2
%
% See also: extSingleCBVresponse_madino, extBOLDresponse
%
% Author: Hiroaki Taiyo Hamada, Araya Inc.
% Date: 2019/Sep/22

% nSub, nTIm, nROI
[nSub, nTime, nROI] = size(timeseries);
nTime2 = 35;

CBVresponse = zeros(nSub,nTime2,6,nROI);

for nsub = 1:nSub,
    tempsignal = squeeze(timeseries(nsub,:,:));
    CBVresponse(nsub,:,:,:) = extSingleCBVresponse_madino(tempsignal);
end