function [ROISignals] = EXPext(niftiList, template, ROIIds)
% This program is intended to extract signal extraction from ROIs.
% 
% input:
%	niftiList: a list from nifti
%	template: atlas.nii
%	ROIIds: ROIs' list of atlas .nii
%
% output:
%	ROISignals: [List, signalExp]
%
% by Hiroaki Hamada, oist, 2019/04/22

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
