function [] = doAllROIextract(roipath, datapath, filename, type)
% This program is intended to extract regions of interest in a selected list as ascending manner.
%
% input:
% 	roipath: a selected list of rois
%	datapath: non-selective normalized atlas
%	filename: the name of the new atlas
%	type: output id (1: labels based on original ABA id, 2: labels from newly aligned ids)?
% output:
%	a selected ROI atlas
%
% usage:eg.
% >> roipath = '~/ABA_ROI.nii';
% >> datapath = '~/atlasFromABA.txt'; 
% >> filename = 'newAtlas.nii';
% >> doAllROIextract(roipath, datapath, filename);
% 
% by Hiroaki Hamada, oist, 2017/March/24th

% information about rois
% ID, ROIname, ROIs
ROItable = readtable(roipath,'Delimiter',',');
[row, column] = size(ROItable);

% extract .nii structure
nii = load_untouch_nii(datapath);
roi = nii.img;
[x,y,z]=size(roi);

if type == 1
	newroi = zeros(x,y,z);
else
	alignedroi = zeros(x,y,z);
end

Counter = 0;
for id = 1:row
	% extract ROIid
	ROIid = ROItable.ID(id);
	idx = (roi == ROIid);
	
	if type == 1
		newroi(idx) = ROIid;
    %elseif type == 2
    %   if sum((sum(sum(idx)))) ~= 0
    %       Counter = 1 + Counter;
    %       alignedroi(idx) = Counter;
    %   end
    else
        if sum((sum(sum(idx)))) > 0
            Counter = id;
        end
		alignedroi(idx) = id;
	end
end

sprintf('%s ROIs are extracted.', num2str(Counter))

% save nii file
if type == 1
	nii.img = newroi;
	save_untouch_nii(nii, filename);
else
	nii.img = alignedroi;
	save_untouch_nii(nii, filename);
end