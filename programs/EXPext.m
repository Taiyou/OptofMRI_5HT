function [ROISignals] = EXPext(niftiList, template, ROIIds)
% EXPext - Extract mean signal values from NIfTI images within atlas ROIs
%
% This function extracts mean values from 5-HT receptor expression maps
% or projection density maps for each ROI defined in an atlas template.
% Used for correlation analysis between receptor expression and BOLD response.
%
% Syntax:
%   [ROISignals] = EXPext(niftiList, template, ROIIds)
%
% Input:
%   niftiList - Structure array from makeList() containing paths to
%               NIfTI images (e.g., 5-HT receptor expression maps)
%               Expected files: htr1a.nii, htr1b.nii, htr1f.nii, 
%                              htr2a.nii, htr2c.nii, htrproj.nii
%
%   template  - Path to atlas NIfTI file (atlas.nii)
%               Contains integer labels for each brain region
%
%   ROIIds    - {1 x nROI} cell array of atlas region IDs
%               e.g., {1, 26, 24, 4, 23, ...} corresponding to 28 ROIs
%               IDs match labels in the atlas template
%
% Output:
%   ROISignals - [nROI x nSignal] matrix of mean values
%                nROI: number of ROIs (28)
%                nSignal: number of input NIfTI images (6 for receptors)
%                Columns: 1=5HT1A, 2=5HT1B, 3=5HT1F, 4=5HT2A, 5=5HT2C, 6=projection
%
% Notes:
%   - Zero values within ROIs are excluded from mean calculation
%   - Used in main_corr5HTprojAndCOPE.m for structure-function correlation
%   - Receptor expression data derived from Allen Brain Atlas
%
% Example:
%   niftiList = makeList('/5HTR', '*.nii');
%   template = '/atlas.nii';
%   ROIIds = {1, 26, 24, ...};  % 28 ROI IDs
%   [HTExpSignals] = EXPext(niftiList, template, ROIIds);
%
% See also: load_untouch_nii, main_corr5HTprojAndCOPE
%
% Author: Hiroaki Hamada, OIST
% Date: 2019/04/22

% extract the number of list 
nSignal = length(niftiList);

% extract the number of ROIs
nROI = length(ROIIds);

ROISignals = zeros(nROI, nSignal);

% extract template info
templateNii = load_untouch_nii(template);
tempMatrix = templateNii.img;

for nsignal = 1:nSignal,

	% extract concurrent image infor
	contimage = load_untouch_nii(niftiList(nsignal).name);
	contmatrix = contimage.img;

	% ROI info
	for nroi = 1:nROI,
		% extract region of interest
		roiIDX = find(tempMatrix==ROIIds{nroi});
		data = contmatrix(roiIDX);
		data = mean(data(data~=0));

		% store the info about 
		ROISignals(nroi, nsignal) = data;
	end
end
