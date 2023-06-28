% This program is to calculate and plot the results of COPE between tphssk and control.
%
% Figure 2b & Figure 5a
%
% Procedure:
%   1. extract COPE results of tph blue, tph yellow, wt blue, and wt
%   yellow.
%   2. plot ROI names
%   3. plot results
%
%
% by Hiro Taiyo Hamda, Araya Inc.,

clear all;
close all;

addpath(fullfile(pwd, '/programs'))

datafolder = '/data/COPEResults/session1';

%% 1. extract COPE results
% tphskk stimulation
tphskkblue = 'COPE_Phasic_tph_blue.mat';
tphskkblue = load(fullfile(pwd, datafolder, tphskkblue));
tphskkyellow = 'COPE_Phasic_tph_yellow.mat';
tphskkyellow = load(fullfile(pwd, datafolder, tphskkyellow));

% values for tphskk val and cont val
tphskk_blueval   = tphskkblue.COPE_Phasic_tph_blue;
tphskk_yellval   = tphskkyellow.COPE_Phasic_tph_yellow;

% reshape the data points for violinplot
[ROWtph,COLtph]   = size(tphskk_blueval);
[ROWcont,COLcont] = size(tphskk_yellval);
tphskk_blueval    = reshape(tphskk_blueval, ROWtph*COLtph, 1);
tphskk_yellval    = reshape(tphskk_yellval, ROWcont*COLcont, 1);
% concatenate the results
val               = vertcat(tphskk_blueval,tphskk_yellval);

for ii = 1:ROWtph*COLtph,
	groups{ii,1}  = 'transgenic, blue (n=8)';
end
for ii = ROWtph*COLtph+1:ROWtph*COLtph + ROWcont*COLcont,
	groups{ii,1}  = 'transgenic, yellow (n=8)';
end

%%  2.load ROI names
ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

% align ROIs for visualization, transgenic group
for iroi = 1:nROI,
	for jroi = (iroi-1)*ROWtph+1:iroi*ROWtph,
		roi{jroi,1} = ROIname{iroi};
	end
end

% align RIOs for visualization, control group
for iroi = 1:nROI,
	for jroi = nROI*ROWtph+(iroi-1)*ROWcont+1:nROI*ROWtph+iroi*ROWcont,
		roi{jroi,1} = ROIname{iroi};
	end
end

% set COPE struct
COPE.roi = roi;
COPE.val = val;
COPE.groups = groups;

%% 3. Plot results
% print the results.
COPE1 = tphskkblue.COPE_Phasic_tph_blue;
COPE2 = tphskkyellow.COPE_Phasic_tph_yellow;
[Pvalues_cope] = COPEComp(COPE1,COPE2, ROIname);

savename = 'Phasic_COPE_blueVSyellow_TPHandCONT_Figure2';
savepath = fullfile(pwd, '/figures/Figure2/');
mkdir(savepath)

blue = [0, 1, 1];
%gray = [0, 0.5, 0];
gray = [235, 186, 26]/255;
color(1,:) = blue;
color(2,:) = gray;

% plot violinplot
plotONOFFStim(COPE, savename, savepath, color);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Single plot for 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear COPE

for ii = 1:ROWtph*COLtph,
	groups1{ii,1} ='blue';
end

for iroi = 1:nROI,
	for jroi = (iroi-1)*ROWtph+1:iroi*ROWtph,
		roi1{jroi,1} = ROIname{iroi};
	end
end

COPE.roi    = roi1;
COPE.val    = tphskk_blueval;
COPE.groups = groups1;

savename = 'Phasic_COPE_blue_TPHandCONT_Figure5';
savepath = fullfile(pwd, '/figures/Figure2/');
mkdir(savepath)

% plot violinplot
plotONOFFStim2(COPE, savename, savepath);


