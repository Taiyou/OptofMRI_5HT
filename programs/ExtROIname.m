function [ROIname] = ExtROIname(roipath)
% This program is intended to 
%
% input:
%   roipath:
%
% output:
%
% by Hiroaki Hamada, Araya Inc., 2019/08/29th

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