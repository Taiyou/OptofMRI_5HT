function [ROIname] = ExtROIname(roipath)
% ExtROIname - Extract ROI names from NIfTI filenames
%
% This function parses ROI mask filenames (ID*_*.nii) to extract
% abbreviated region names. Used for labeling plots and tables.
%
% Syntax:
%   [ROIname] = ExtROIname(roipath)
%
% Input:
%   roipath - String path to ROI directory containing ID*.nii files
%             Expected format: ID##_RegionName.nii
%             e.g., '/Users/xxx/OptofMRI_5HT/ROIs'
%
% Output:
%   ROIname - {1 x nROI} cell array of region abbreviations
%             e.g., {'FP', 'OFC', 'mPFC', 'M2', 'ACC', ...}
%
% Expected ROI file naming convention:
%   ID01_FP.nii   -> 'FP'   (Frontal Pole)
%   ID02_OFC.nii  -> 'OFC'  (Orbitofrontal Cortex)
%   ID03_mPFC.nii -> 'mPFC' (Medial Prefrontal Cortex)
%   ... (28 ROIs total)
%
% Example:
%   roipath = fullfile(pwd, '/ROIs');
%   [ROIname] = ExtROIname(roipath);
%   disp(ROIname);  % {'FP', 'OFC', 'mPFC', ...}
%
% See also: makeList, extCOPE
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/08/29

listing_roi = makeList(roipath, 'ID*.nii');

nROI = length(listing_roi);

% extract ROInames and ROIindex
for nroi = 1:nROI,
	% extraction of ROI names
	roiname = strsplit(listing_roi(nroi).name,{'/', '.nii'});
	ROIname{nroi} = roiname{length(roiname)-1};
    roiname = strsplit(ROIname{nroi}, {'_'});
    ROIname{nroi} = roiname{2};
end