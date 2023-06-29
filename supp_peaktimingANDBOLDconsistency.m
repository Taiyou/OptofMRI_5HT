clear all; close all;

visualizeAllTimeSeriesSession1st
visualizeAllTimeSeriesSession2nd

color = zeros(2, 3);
blue  = [0, 1, 1];
black = [0, 0.2, 0.2];
color1(1,:) = blue;
color1(2,:) = black;

ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

val                 = (maxTIMES1_bsession1)*100;
[nSUB, nROI]        = size(val);
[sorted,peakINDICE]     = sort(mean(maxTIMES1_bsession1));
sortedval1           = val(:,peakINDICE);
sortedval1           = reshape(transpose(sortedval1), nSUB*nROI, 1);
sortROIname         = ROIname(peakINDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi1{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups1{jroi} = 'First';
	end
end

clear val sortedval groups roi
clear val2 sortedval2 groups2 roi2
val                 = (maxTIMES1_bsession2)*100;
[nSUB, nROI]        = size(val);
[sorted,peakINDICE] = sort(mean(maxTIMES1_bsession1));
sortedval2          = val(:,peakINDICE);
sortedval2          = reshape(transpose(sortedval2), nSUB*nROI, 1);
sortROIname         = ROIname(peakINDICE);

for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi2{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups2{jroi} = 'Second';
	end
end

% set COPE struct
COPE.roi    = vertcat(roi1, roi2);
COPE.val    = vertcat(sortedval1, sortedval2);
COPE.groups = horzcat(groups1, groups2);

%% 3. Plot results

savename = 'session1_BOLD_firstVSsecond';
savepath = fullfile(pwd,'/figures/FigureS8cd');
mkdir(savepath)

% plot violinplot
% plotting
g(1,1) = gramm('x',COPE.roi,'y',COPE.val,'color',COPE.groups);
g(1,1).stat_boxplot();
g(1,1).set_color_options('map','matlab');

%These functions can be called on arrays of gramm objects
g.set_names('x','ROIs','y','%BOLD','color',' ');
g.set_text_options('font','Courier',...
    'base_size', 36,...
    'label_scaling', 1,...
    'legend_scaling', 0.8,...
    'legend_title_scaling', 1.2,...
    'facet_scaling', 1,...
    'title_scaling', 1.2);
g.set_order_options('x',0);
g.axe_property('YLim',[-1 7]);

%g.set_color_options('map', [0, 174/255, 239/255; 255/255, 255/255, 0/255])
gf = copy(g);
g.axe_property('YLim',[-1 6]);

gf.axe_property('XTickLabelRotation',60);
figure('Position',[100 100 1800 600]);
gf.set_color_options('map', color1, 'lightness', 50)
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of fluctuation of brain peaks based on peak timing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi

val1                 = (maxTIMES1id_bsession1)-20;
[nSUB, nROI]         = size(val1);
[sorted,INDICE]      = sort(mean(maxTIMES1id_bsession1-20));
sortedval1           = val1(:,INDICE);
sortedval1           = reshape(transpose(sortedval1), nSUB*nROI, 1);
sortROIname          = ROIname(INDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi1{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups1{jroi} = 'First';
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi
clear val2 sortedval2 groups2 roi2

val2                 = (maxTIMES1id_bsession2)-20;
[nSUB, nROI]         = size(val2);
sortedval2           = val2(:,INDICE);
sortedval2           = reshape(transpose(sortedval2), nSUB*nROI, 1);
sortROIname          = ROIname(INDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi2{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups2{jroi} = 'Second';
	end
end

% set COPE struct
beta.roi    = vertcat(roi1, roi2);
beta.val    = vertcat(sortedval1, sortedval2);
beta.groups = horzcat(groups1, groups2);

%% 3. Plot results
savename = 'session1_BOLD_firstvssecond_peaktiming_session2';

% plot violinplot
% plotting
g(1,1) = gramm('x',beta.roi,'y',beta.val,'color',beta.groups);
g(1,1).stat_boxplot();
g(1,1).set_color_options('map','matlab');

%These functions can be called on arrays of gramm objects
g.set_names('x','ROIs','y','peak timing (s)','color','# stim');
g.set_text_options('font','Courier',...
    'base_size',36,...
    'label_scaling',1,...
    'legend_scaling',0.8,...
    'legend_title_scaling',1.2,...
    'facet_scaling',1,...
    'title_scaling',1.2);
g.set_order_options('x',0);

%g.set_color_options('map', [0, 174/255, 239/255; 255/255, 255/255, 0/255])
gf = copy(g);
g.axe_property('YLim',[0 20]);

gf.axe_property('XTickLabelRotation', 60);
figure('Position',[100 100 1800 600]);
gf.set_color_options('map', color1, 'lightness', 50)
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')









