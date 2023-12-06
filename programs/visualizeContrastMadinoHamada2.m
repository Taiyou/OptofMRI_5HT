function [] = visualizeContrastMadinoHamada(val1, val2, texts, color)

% preparation for the 
count = 1;
clear COPE


nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val2;
COPE.labels(count:nROI, 1) = {'Anesthesia (Mandino2022vsSession3)'};
COPE.color(count:nROI, 1)  = {'Anesthesia (Mandino2022vsSession3)'};
count = nROI;

g = gramm('x', COPE.second, 'y', COPE.first,'color', COPE.color);

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
figure('Position', [100 100 1000 1400]);
g.draw();
g.export('file_name', texts{3},'export_path', texts{4}, 'file_type', 'png');