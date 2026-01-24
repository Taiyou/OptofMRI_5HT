function [COPE] = extCOPE(ContrastList, ROIlist)
% extCOPE - Extract Contrast of Parameter Estimates from NIfTI files
%
% This function extracts mean beta/contrast values from GLM analysis
% results for each ROI. COPE values represent the magnitude of neural
% activation during optogenetic stimulation vs. baseline.
%
% Syntax:
%   [COPE] = extCOPE(ContrastList, ROIlist)
%
% Input:
%   ContrastList - Structure array from makeList() containing paths to
%                  NIfTI contrast files (e.g., *_positiveBOLD_20.nii)
%                  Each file is a 3D contrast map from SPM GLM analysis
%
%   ROIlist      - Structure array from makeList() containing paths to
%                  ROI mask NIfTI files (ID*.nii in /ROIs/ directory)
%                  Binary masks defining 28 brain regions
%
% Output:
%   COPE - [nSub x nROI] matrix of mean contrast values
%          nSub: number of subjects (files in ContrastList)
%          nROI: number of ROIs (28 regions)
%          Values: mean beta within each ROI (NaN voxels excluded)
%
% Notes:
%   - Uses load_untouch_nii to preserve NIfTI header information
%   - NaN values in contrast maps are automatically excluded
%   - Positive COPE = activation, Negative COPE = deactivation
%
% Example:
%   ContrastList = makeList('/data/COPEResults/session1/BLUE/TPH/', 'TPH*.nii');
%   ROIlist = makeList('/ROIs/', 'ID*.nii');
%   [COPE] = extCOPE(ContrastList, ROIlist);
%
% See also: makeList, load_untouch_nii, COPEComp
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/Oct/21

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