function [] = visualizeContrastMadinoHamada2(val1, val2, texts, color)
% visualizeContrastMadinoHamada2 - Simple correlation plot for Mandino comparison
%
% This function creates a single scatter plot with linear regression
% comparing responses between the current study and external dataset.
%
% Syntax:
%   visualizeContrastMadinoHamada2(val1, val2, texts, color)
%
% Input:
%   val1   - [nROI x 1] First variable (y-axis)
%
%   val2   - [nROI x 1] Second variable (x-axis)
%
%   texts  - {1 x 4} cell array of plot labels:
%            texts{1}: x-axis label
%            texts{2}: y-axis label
%            texts{3}: output filename
%            texts{4}: save path
%
%   color  - [1 x 3] RGB color for data points
%
% Output:
%   PNG figure saved to texts{4}/texts{3}.png
%
% Notes:
%   - Used for Supplementary Figure S14
%   - Requires Gramm toolbox
%   - Includes linear regression line (stat_glm)
%
% See also: visualizeContrastMadinoHamada1, suppS14_extraction_TSdata_madino
%
% Author: Hiro Taiyo Hamada

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