function [] = visualizeContrastMadinoHamada2(val1, val2, val3, texts, color)

% preparation for the 
count = 1;
clear COPE

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val2;
COPE.labels(count:nROI, 1) = {'peaks of ΔCBV(Grandjean2019)'};
COPE.color(count:nROI, 1)  = {'peaks of ΔCBV(Grandjean2019)'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val1;
COPE.second(count+1:nROI+count, 1) = val3;
COPE.labels(count+1:nROI+count, 1) = {'peaks of %BOLD(Session3)'};
COPE.color(count+1:nROI+count, 1)  = {'peaks of %BOLD(Session3)'};

g = gramm('x', COPE.first, 'y', COPE.second,'color', COPE.color);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_point_options('base_size', 15);
g.set_names('column', 'Stim', 'x', texts(1) ,'y', texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map', color);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', texts{3},'export_path', texts{4}, 'file_type', 'png');
