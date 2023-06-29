function [COPE] = extCOPE(ContrastList,ROIlist)
% This program is intended to extract COPE.
%
% input:
%   ContrastList:
%   ROIlist:
%
% output:
%   COPE: nSub x nROI
%
%
% by Hiroaki Hamada, Araya Inc., 2019/Oct/21st

% check No. Subjects
nSub = length(ContrastList);

% check No. ROIs
nROI = length(ROIlist);

COPE = zeros(nSub, nROI);

for iroi = 1:nROI,
    tempROI = load_untouch_nii(ROIlist(iroi).name);
    tempROIIDX{iroi} = find(tempROI.img); 
end

for isub = 1:nSub,
    tempSub = load_untouch_nii(ContrastList(isub).name);
    tempnii = tempSub.img;
    
    for iroi = 1:nROI,
        niidata = tempnii(tempROIIDX{iroi});
        NaNdata = isnan(niidata);
        statIDX = find(~NaNdata);
        COPE(isub, iroi) = mean(niidata(statIDX));
    end
end