function [] = plotCORR(val1, val2, label, stim, COPE_texts, color)
% This code is to plot the correlation between two groups
%
%
% inputs:
%   val1:
%   val2:
%   label:
%   stim:
%   COPE_texts:
%   flag:
%
%
% by Hiro Taiyo Hamada, 2020/12/17,

clear COPE; close all;

count = 1;
n1    = length(val1);
index = find(~isnan(val1))

COPE.vals1(count:n1, 1)  = val1;
COPE.vals2(count:n1, 1)  = val2;
COPE.label(count:n1, 1)  = label;
COPE.stim(count:n1, 1)   = stim;

% visualization of plots,
g = gramm('x', COPE.vals1, 'y', COPE.vals2,'color', COPE.stim);
%g.facet_grid([], COPE.label);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'transgenic', 'x',COPE_texts{1},'y',COPE_texts{2},'color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map', color);
g.axe_property('YLim',[-1.4 1]);

figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');