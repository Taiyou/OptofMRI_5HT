function [] = doOneROIExtract(AtlasData, ROIid, filename)
% This program is intetended to extract a ROI from atlas
%
% input
%	AtlasData: atlas for analysis
%	ROIid: ROIid for seed-based analysis
%	filename: the name of ROI
% ouput:
%
%
% by Hiroaki Hamada, oist, 2017/June/12th

% extract atlas voxel size
niidata = load_untouch_nii(AtlasData);
[x,y,z] = size(niidata.img);
nii=niidata.img;
newdata = zeros(x,y,z);
newdata = (nii==ROIid);
niidata.img = newdata;

% save the ROI while preserving voxel structure 
save_untouch_nii(niidata, filename);