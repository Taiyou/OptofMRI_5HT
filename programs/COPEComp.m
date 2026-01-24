function [Pvalues_cope] = COPEComp(COPE1, COPE2, ROInames)
% COPEComp - Statistical comparison of COPE values between two conditions
%
% This function performs paired t-tests comparing COPE (Contrast of 
% Parameter Estimates) values between two experimental conditions for
% each ROI. Used to assess significant differences in neural activation.
%
% Syntax:
%   [Pvalues_cope] = COPEComp(COPE1, COPE2, ROInames)
%
% Input:
%   COPE1    - [nSub x nROI] matrix of COPE values for condition 1
%              e.g., blue light stimulation
%
%   COPE2    - [nSub x nROI] matrix of COPE values for condition 2
%              e.g., yellow light control
%
%   ROInames - {1 x nROI} cell array of ROI names for reporting
%              e.g., {'FP', 'OFC', 'mPFC', ...}
%
% Output:
%   Pvalues_cope - [nROI x 1] vector of p-values from paired t-tests
%                  Should be corrected for multiple comparisons using fdr_bh
%
% Notes:
%   - Uses paired t-test (same subjects across conditions)
%   - Prints results to console for each ROI
%   - Apply FDR correction: fdr_bh(Pvalues_cope) for significance
%
% Example:
%   [pvals] = COPEComp(COPE_blue, COPE_yellow, ROIname);
%   sig_ROIs = ROIname(fdr_bh(pvals));  % FDR-corrected significant ROIs
%
% See also: ttest, fdr_bh, extCOPE
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/10/15

% the number of ROIs
nROI = length(ROInames);

% COPE
Pvalues_cope = zeros(nROI,1);

% extract of cope per ROI
for iroi = 1:nROI,

	% comparison between two groups
	[sig(iroi), Pvalues_cope(iroi,1)] = ttest(COPE1(:, iroi), COPE2(:, iroi));

	fprintf('ROI: %s, Pvalues for COPE = %f \n\n', ROInames{iroi}, Pvalues_cope(iroi,1));
end