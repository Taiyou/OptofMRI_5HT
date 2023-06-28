% This program is to calculate and plot the results of COPE between tphssk and control.
clear all;
close all;

addpath(fullfile(pwd, '/programs'))

datafolder1 = '/data/COPEResults/session3';
datafolder2 = '/data/COPEResults/session4';

% tphskk stimulation, Anesthesia1
tphskkblue_ane1 = 'tphB_ane1.mat';
tphskkblue_ane1 = load(fullfile(pwd, datafolder1, tphskkblue_ane1));
tphskkyellow_ane1 = 'tphY_ane1.mat';
tphskkyellow_ane1 = load(fullfile(pwd, datafolder1, tphskkyellow_ane1));
% tphskk stimulation, Anesthesia2
tphskkblue_ane2 = 'tphB_ane2.mat';
tphskkblue_ane2 = load(fullfile(pwd, datafolder2, tphskkblue_ane2));
tphskkyellow_ane2 = 'tphY_ane2.mat';
tphskkyellow_ane2 = load(fullfile(pwd, datafolder2, tphskkyellow_ane2));

% WT stimulation, Anesthesia1
contblue_ane1 = 'CONTB_ane1.mat';
contblue_ane1 = load(fullfile(pwd, datafolder1, contblue_ane1));
contyellow_ane1 = 'CONTY_ane1.mat';
contyellow_ane1 = load(fullfile(pwd, datafolder1, contyellow_ane1));
% WT stimulation, Anesthesia1
contblue_ane2 = 'CONTB_ane2.mat';
contblue_ane2 = load(fullfile(pwd, datafolder2, contblue_ane2));
contyellow_ane2 = 'CONTY_ane2.mat';
contyellow_ane2 = load(fullfile(pwd, datafolder2, contyellow_ane2));

% values for tphskk val
tphskkAneshtesia_cont = (tphskkblue_ane1.COPE_Ane1_tph_blue - tphskkyellow_ane1.COPE_Ane1_tph_yellow);
tphskkAwake_cont = (tphskkblue_ane2.COPE_Ane2_tph_blue - tphskkyellow_ane2.COPE_Ane2_tph_yellow);
% values for cont val
contAneshtesia_cont = (contblue_ane1.COPE_Ane1_cont_blue - contyellow_ane1.COPE_Ane1_cont_yellow);
contAwake_cont = (contblue_ane2.COPE_Ane2_cont_blue - contyellow_ane2.COPE_Ane2_cont_yellow); 

%tphskkval_cont = tphskkval_ane1 - tphskkval_ane2;
%contval_cont= contval_ane1 - contval_ane2;

% reshape the data points for violinplot
[ROWtph,COLtph] = size(tphskkAneshtesia_cont);
[ROWcont,COLcont] = size(contAneshtesia_cont);
tphskkAneshtesia_cont = reshape(tphskkAneshtesia_cont, ROWtph*COLtph, 1);
tphskkAwake_cont = reshape(tphskkAwake_cont, ROWtph*COLtph, 1);
contAneshtesia_cont = reshape(contAneshtesia_cont , ROWcont*COLcont, 1);
contAwake_cont = reshape(contAwake_cont, ROWcont*COLcont, 1);
% concatenate the results
val1 = vertcat(tphskkAneshtesia_cont, tphskkAwake_cont);
val2 = vertcat(contAneshtesia_cont, contAwake_cont);

for ii = 1:ROWtph*COLtph,
	groups1{ii,1} = 'Anesthesia';
end
for ii = ROWtph*COLtph+1:ROWtph*COLtph + ROWtph*COLtph,
	groups1{ii,1} = 'Awake';
end

for ii = 1:ROWcont*COLcont,
	groups2{ii,1} = 'Anesthesia';
end
for ii = ROWcont*COLcont+1:ROWcont*COLcont*2,
	groups2{ii,1} = 'Awake';
end

% load ROI names
ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

% contrast between anesthesia and awake in tph group
for iroi = 1:nROI,
	for jroi = (iroi-1)*ROWtph+1:iroi*ROWtph,
		roi1{jroi,1} = ROIname{iroi};
	end
end

for iroi = 1:nROI,
	for jroi = ROWtph*nROI+(iroi-1)*ROWtph+1:ROWtph*nROI+iroi*ROWtph,
		roi1{jroi,1} = ROIname{iroi};
	end
end

% contrast between anesthesia and awake in tph group
for iroi = 1:nROI,
	for jroi = (iroi-1)*ROWcont+1:iroi*ROWcont,
		roi2{jroi,1} = ROIname{iroi};
	end
end

for iroi = 1:nROI,
	for jroi = ROWcont*nROI+(iroi-1)*ROWcont+1:ROWcont*nROI+iroi*ROWcont,
		roi2{jroi,1} = ROIname{iroi};
	end
end


% set COPE struct
COPE1.roi = roi1;
COPE1.val = val1;
COPE1.groups = groups1;

COPE2.roi = roi2;
COPE2.val = val2;
COPE2.groups = groups2;

% print the results.

% 
COPE_anesthesia = (tphskkblue_ane1.COPE_Ane1_tph_blue - tphskkyellow_ane1.COPE_Ane1_tph_yellow);
COPE_awake = (tphskkblue_ane2.COPE_Ane2_tph_blue - tphskkyellow_ane2.COPE_Ane2_tph_yellow);
[Pvalues_cope1] = COPEComp(COPE_anesthesia,COPE_awake, ROIname);

fprintf('Statistically different beta values between session 3 and session4');
ROIname(find(fdr_bh(Pvalues_cope1)))

COPE2_anesthesia = (contblue_ane1.COPE_Ane1_cont_blue - contyellow_ane1.COPE_Ane1_cont_yellow);
COPE2_awake = (contblue_ane2.COPE_Ane2_cont_blue - contyellow_ane2.COPE_Ane2_cont_yellow); 
[Pvalues_cope2] = COPEComp(COPE2_anesthesia, COPE2_awake, ROIname);

%lot violinplot
savepath = fullfile(pwd, '/figures/Figure3/');
mkdir(savepath);
filename_TPH = 'COPEanalysis_AnesthesiaVSAwake_TPH';
filename_WT  = 'COPEanalysis_AnesthesiaVSAwake_WT';


% 
color1 = zeros(2, 3);
color2 = zeros(2, 3);

blue = [0, 1, 1];
mazenta = [1, 0, 1];
color1(2,:) = blue;
color1(1,:) = mazenta;

green = [0, 0.7, 0];
purple= [0.7294, 0.3333, 0.8275];
color2(2,:) = green;
color2(1,:) = purple;

plotONOFFStim(COPE1, filename_TPH, savepath, color1);
plotONOFFStim(COPE2, filename_WT, savepath, color2);
