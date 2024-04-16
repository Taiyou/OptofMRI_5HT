function [Pvalues_cope] = COPEComp(COPE1,COPE2, ROInames)
% This program is intended to extract constrast of parameter estimate and comparison between two contrasts.
% 
% input:
%	COPE1: contrast datasets1
%	COPE2: contrast datasets2
%	ROInames: a list of name of ROI list.
%
% output:
%	Pvalues_cope: comparison between COPE1 and COPE2 per ROI
%
% by Hiroaki Hamada, Araya Inc., 2019/10/15th

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