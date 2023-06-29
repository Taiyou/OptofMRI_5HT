% this program is to check the consistency between sessions 1-2.
%
% by Hiro taiyo Hamada, Araya Inc.


clear all; close all;

% first experiments
visualizeAllTimeSeriesSession1st
visualizeAllTimeSeriesSession2nd
visualizeAllTimeSeriesSession3rd
visualizeAllTimeSeriesSession4th

% peaks of BOLD responses
% BOLD replication vs first
% blue stim transgenic
[cor(1), pval(1)] = corr(transpose(mean(maxTIMES1_bsession2)), transpose(mean(maxTIMES1_bsession1)))
% yellow stim transgenic
[cor(2), pval(2)] = corr(transpose(mean(maxTIMES2_ysession2)), transpose(mean(maxTIMES2_ysession1)))
% blue stim control
[cor(3), pval(3)] = corr(transpose(mean(maxTIMES1_CONTsession2)), transpose(mean(maxTIMES1_CONTsession1)))
% yellow stim control
[cor(4), pval(4)] = corr(transpose(mean(maxTIMES2_CONTsession2)), transpose(mean(maxTIMES2_CONTsession1)))

% timing of peak BOLD responses
% BOLD replication vs first
% blue stim transgenic
[cor(5), pval(5)] = corr(transpose(mean(maxTIMES1id_bsession2)), transpose(mean(maxTIMES1id_bsession1)))
% yellow stim transgenic
[cor(6), pval(6)] = corr(transpose(mean(maxTIMES2id_ysession2)), transpose(mean(maxTIMES2id_ysession1)))
% blue stim control
[cor(7), pval(7)] = corr(transpose(mean(maxTIMES1id_CONTsession2)), transpose(mean(maxTIMES1id_CONTsession1)))
% yellow stim control
[cor(8), pval(8)] = corr(transpose(mean(maxTIMES2id_CONTsession2)), transpose(mean(maxTIMES2id_CONTsession1)))

%% preparation for the visuzalition transgenic peak
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));
datapath = fullfile(pwd, 'figures/FigureS8');

% blue stim transgenic
peakBOLD.first(count:nROI, 1)     = transpose(mean(maxTIMES1_bsession1))*100;
peakBOLD.second(count:nROI, 1)    = transpose(mean(maxTIMES1_bsession2))*100;
peakBOLD.labels(count:nROI, 1)    = {'blue stim'};
peakBOLD.stim(count:nROI, 1)      = {'blue'};
peakBOLD.color(count:nROI, 1)     = 4;
count = nROI;
% yellow stim transgenic
peakBOLD.first(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2_ysession1))*100;
peakBOLD.second(count+1:nROI+count, 1) = transpose(mean(maxTIMES2_ysession2))*100;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'};
peakBOLD.color(count+1:nROI+count, 1)  = 2;

count = nROI + count;

% visualization of plots,
g = gramm('x', peakBOLD.first, 'y', peakBOLD.second,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.axe_property('YLim',[0 10]);
g.axe_property('XLim',[0 10]);
g.set_names('column', 'trans', 'x','peaks of %BOLD (first)','y','peaks of %BOLD (second)','color','# stim');
%g.set_title('Correlation between BOLD peaks between first and second sessions', 'FontSize', 28);
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 2000 800]);
g.draw();
g.export('file_name', 'peak_transgenicB_session1VSRepli','export_path', datapath, 'file_type', 'png');

%% preparation for the visuzalition transgenic peak
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));

% blue stim transgenic
peakBOLD.firstloc(count:nROI, 1)     = transpose(mean(maxTIMES1id_bsession1))-20;
peakBOLD.secondloc(count:nROI, 1)    = transpose(mean(maxTIMES1id_bsession2))-20;
peakBOLD.labels(count:nROI, 1)    = {'blue stim'};
peakBOLD.stim(count:nROI, 1)      = {'blue'};
count = nROI;
% yellow stim transgenic
peakBOLD.firstloc(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2id_ysession1))-20;
peakBOLD.secondloc(count+1:nROI+count, 1) = transpose(mean(maxTIMES2id_ysession2))-20;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'};

% visualization of plots,
g = gramm('x', peakBOLD.firstloc, 'y', peakBOLD.secondloc,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.axe_property('YLim',[4 12]);
g.axe_property('XLim',[4 12]);
g.set_names('column', 'trans', 'x','peak timing (s, first)','y','peak timing (s, second)','color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 35, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1800 800]);
g.draw();
g.export('file_name', 'peak_transgenicY_session1VSRepli','export_path', datapath, 'file_type', 'png');


%% preparation for visualization of WT.
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));

% blue stim control
peakBOLD.first(count:nROI, 1)  = transpose(mean(maxTIMES1_CONTsession1))*100;
peakBOLD.second(count:nROI, 1) = transpose(mean(maxTIMES1_CONTsession2))*100;
peakBOLD.labels(count:nROI, 1) = {'blue stim'};
peakBOLD.stim(count:nROI, 1)   = {'blue'};
count = nROI;
% yellow stim control
peakBOLD.first(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2_CONTsession1))*100;
peakBOLD.second(count+1:nROI+count, 1) = transpose(mean(maxTIMES2_CONTsession2))*100;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'}

% visualization of plots,
g = gramm('x', peakBOLD.first, 'y', peakBOLD.second,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'WT', 'x','peaks of %BOLD (first)','y','peaks of %BOLD (second)','color','# stim');
%g.set_title('Correlation between BOLD peaks between first and second sessions', 'FontSize', 28);
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', 'peak_WTB_session1VSRepli','export_path', datapath, 'file_type', 'png');


%% preparation for visualization of WT.
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));

% blue stim control
peakBOLD.first(count:nROI, 1)  = transpose(mean(maxTIMES1_CONTsession1))*100;
peakBOLD.second(count:nROI, 1) = transpose(mean(maxTIMES1_CONTsession2))*100;
peakBOLD.labels(count:nROI, 1) = {'blue stim'};
peakBOLD.stim(count:nROI, 1)   = {'blue'};
count = nROI;
% yellow stim control
peakBOLD.first(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2_CONTsession1))*100;
peakBOLD.second(count+1:nROI+count, 1) = transpose(mean(maxTIMES2_CONTsession2))*100;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'}

% visualization of plots,
g = gramm('x', peakBOLD.first, 'y', peakBOLD.second,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'WT', 'x','peaks of %BOLD (first)','y','peaks of %BOLD (second)','color','# stim');
%g.set_title('Correlation between BOLD peaks between first and second sessions', 'FontSize', 28);
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', 'peak_WTB_session1VSRepli','export_path', datapath, 'file_type', 'png');


%% preparation for visualization of trans peak timing.
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));

% blue stim control
peakBOLD.first(count:nROI, 1)  = transpose(mean(maxTIMES1id_CONTsession1)) - 20;
peakBOLD.second(count:nROI, 1) = transpose(mean(maxTIMES1id_CONTsession2)) - 20 ;
peakBOLD.labels(count:nROI, 1) = {'blue stim'};
peakBOLD.stim(count:nROI, 1)   = {'blue'};
peakBOLD.color(count:nROI, 1)  = 4;
count = nROI;
% yellow stim control
peakBOLD.first(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2id_CONTsession1)) - 20;
peakBOLD.second(count+1:nROI+count, 1) = transpose(mean(maxTIMES2id_CONTsession2)) - 20;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'}
peakBOLD.color(count+1:nROI+count, 1)  = 2;

% visualization of plots,
g = gramm('x', peakBOLD.first, 'y', peakBOLD.second,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

g.axe_property('YLim',[4 12]);
g.axe_property('XLim',[4 12]);
% get labelling
g.set_names('column', 'WT', 'x','peak timing (s, first)','y','peak timing (s, second)','color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', 'peak_WTY_session1VSRepli','export_path', datapath, 'file_type', 'png');

%% preparation for visualization of WT peak timing.
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession2));

% blue stim control
peakBOLD.first(count:nROI, 1)  = transpose(mean(maxTIMES1id_bsession1)) - 20;
peakBOLD.second(count:nROI, 1) = transpose(mean(maxTIMES1id_bsession2)) - 20 ;
peakBOLD.labels(count:nROI, 1) = {'blue stim'};
peakBOLD.stim(count:nROI, 1)   = {'blue'};
peakBOLD.color(count:nROI, 1)  = 4;
count = nROI;
% yellow stim control
peakBOLD.first(count+1:nROI+count, 1)  = transpose(mean(maxTIMES2id_ysession1)) - 20;
peakBOLD.second(count+1:nROI+count, 1) = transpose(mean(maxTIMES2id_ysession2)) - 20;
peakBOLD.labels(count+1:nROI+count, 1) = {'yellow stim'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'yell'}
peakBOLD.color(count+1:nROI+count, 1)  = 2;

% visualization of plots,
g = gramm('x', peakBOLD.first, 'y', peakBOLD.second,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'Trans', 'x','peak timing (s, first)','y','peak timing (s, second)','color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', 'peak_WTY_session1VSRepli','export_path', datapath, 'file_type', 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of fluctuation of brain peaks based on BOLD peaks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi

ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

val                 = (maxTIMES1_bsession1)*100;
[nSUB, nROI]        = size(val);
[sorted,peakINDICE]     = sort(mean(maxTIMES1_bsession1));
sortedval           = val(:,peakINDICE);
sortedval           = reshape(transpose(sortedval), nSUB*nROI, 1);
sortROIname         = ROIname(peakINDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups{jroi} = 'First';
	end
end

% set COPE struct
COPE.roi = roi;
COPE.val = sortedval;
COPE.groups = groups;

%% 3. Plot results

savename = 'session1_BOLD_blueVSyellow_peaks';
savepath = fullfile(pwd, 'figures/FigureS8');

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

gf.axe_property('XTickLabelRotation',60);
figure('Position',[100 100 1800 600]);
%gf.coord_flip();
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of fluctuation of brain peaks based on BOLD peaks 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi

val                 = (maxTIMES1_bsession2)*100;
[nSUB, nROI]        = size(val);
[sorted,peakINDICE]     = sort(mean(maxTIMES1_bsession1));
sortedval           = val(:,peakINDICE);
sortedval           = reshape(transpose(sortedval), nSUB*nROI, 1);
sortROIname         = ROIname(peakINDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups{jroi} = 'Second';
	end
end

% set COPE struct
COPE.roi = roi;
COPE.val = sortedval;
COPE.groups = groups;

%% 3. Plot results

savename = 'session1_BOLD_blueVSyellow_peaks2';
savepath = fullfile(pwd, '/figures/FigureS8');

% plot violinplot
% plotting
g(1,1) = gramm('x',COPE.roi,'y',COPE.val,'color',COPE.groups);
g(1,1).stat_boxplot();
g(1,1).set_color_options('map','matlab');
%g(1,1).geom_bar()

%These functions can be called on arrays of gramm objects
g.set_names('x','ROIs','y','%BOLD','color',' ');
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

gf.axe_property('XTickLabelRotation',60);
figure('Position',[100 100 1800 600]);
%gf.coord_flip();
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization of fluctuation of brain peaks based on peak timing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi

ROIpath           = '/ROIs';
ROIlist           = makeList(fullfile(pwd, ROIpath), 'ID*.nii');
roipath           = '/ROIs';
[ROIname]         = ExtROIname(fullfile(pwd,roipath));
nROI = length(ROIname);

val                 = (maxTIMES1id_bsession4)-20;
[nSUB, nROI]        = size(val);
[sorted,INDICE]     = sort(mean(maxTIMES1id_bsession4-20));
sortedval           = val(:,INDICE);
sortedval           = reshape(transpose(sortedval), nSUB*nROI, 1);
sortROIname         = ROIname(INDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups{jroi} = 'First';
	end
end

% set COPE struct
COPE.roi = roi;
COPE.val = sortedval;
COPE.groups = groups;

%% 3. Plot results

savename = 'session1_BOLD_blueVSyellow_peaktiming';
savepath = fullfile(pwd, '/figures/FigureS8');

% plot violinplot
% plotting
g(1,1) = gramm('x',COPE.roi,'y',COPE.val,'color',COPE.groups);
g(1,1).stat_boxplot();
g(1,1).set_color_options('map','matlab');
%g(1,1).geom_bar()

%These functions can be called on arrays of gramm objects
g.set_names('x','ROIs','y','peak timing (s)','color',' ');
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

gf.axe_property('XTickLabelRotation',60);
figure('Position',[100 100 1800 600]);
%gf.coord_flip();
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear val sortedval groups roi

val2                 = (maxTIMES1id_bsession2)-20;
[nSUB, nROI]        = size(val2);
%[sorted,INDICE]     = sort(mean(maxTIMES1id_bsession2-20));
sortedval2           = val2(:,INDICE);
sortedval2           = reshape(transpose(sortedval2), nSUB*nROI, 1);
sortROIname         = ROIname(INDICE);

% align ROIs for visualization, transgenic group
for iroi = 1:nSUB,
	for jroi = (iroi-1)*nROI+1:iroi*nROI,
		roi{jroi,1}  = sortROIname{jroi - (iroi-1)*nROI};
        groups2{jroi} = 'Second';
	end
end

% set COPE struct
beta.roi = roi;
beta.val = sortedval2;
beta.groups = groups2;

%% 3. Plot results
savename = 'session1_BOLD_blueVSyellow_peaktiming_session2';

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
g.axe_property('YLim',[4 12]);
g.axe_property('XLim',[4 12]);
gf.axe_property('XTickLabelRotation', 60);
figure('Position',[100 100 1800 600]);
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png')


% visualization of between peaks of BOLD and timing of BOLD.
count = 1;
clear peakBOLD
nROI = length(mean(maxTIMES1_bsession1));
savepath = fullfile(pwd, '/figures/FigureS8');

% blue stim transgenic
peakBOLD.peak(count:nROI, 1)     = transpose(mean(maxTIMES1_bsession1))*100;
peakBOLD.timing(count:nROI, 1)    = transpose(mean(maxTIMES1id_bsession1))-20;
peakBOLD.labels(count:nROI, 1)    = {'first'};
peakBOLD.stim(count:nROI, 1)      = {'blue (first)'};
peakBOLD.color(count:nROI, 1)     = 4;
count = nROI;
% yellow stim transgenic
peakBOLD.peak(count+1:nROI+count, 1)  = transpose(mean(maxTIMES1_bsession2))*100;
peakBOLD.timing(count+1:nROI+count, 1) = transpose(mean(maxTIMES1id_bsession2))-20;
peakBOLD.labels(count+1:nROI+count, 1) = {'second'};
peakBOLD.stim(count+1:nROI+count, 1)   = {'blue (second)'};
peakBOLD.color(count+1:nROI+count, 1)  = 2;

count = nROI + count;

% visualization of plots,
g = gramm('x', peakBOLD.peak, 'y', peakBOLD.timing,'color', peakBOLD.stim);
g.facet_grid([], peakBOLD.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'trans', 'x','peaks of %BOLD','y','peak timing','color','# stim');
%g.set_title('Correlation between BOLD peaks between first and second sessions', 'FontSize', 28);
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
%g.set_color_options('map','brewer1');
g.set_color_options('hue_range',[150 300],'chroma',40,'lightness',50);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', 'peak_and_timing_first','export_path', datapath, 'file_type', 'png');
