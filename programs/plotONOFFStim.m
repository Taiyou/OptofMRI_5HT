function [] = plotONOFFStim(COPE, savename, savepath, color)
% This program is intended to plot the contrast between transgenic and WT.
%
% input:
%	COPE.roi: (n,1) roinames
%	COPE.val: (n,1) valu
%	COPE.groups: (n,1) groups
%   datapath:
%
% output:
%   .png figure in a savepath
%
% by Hiroaki Hamada, Dec 18th, Araya

% plotting
g(1,1) = gramm('x',COPE.roi,'y',COPE.val,'color',COPE.groups);
g(1,1).stat_violin('normalization','width');

%These functions can be called on arrays of gramm objects
g.set_names('x','ROIs','y','beta (a.u.)','color','stim');
g.set_text_options('font','Courier',...
    'base_size',36,...
    'label_scaling',1,...
    'legend_scaling',0.8,...
    'legend_title_scaling',1.2,...
    'facet_scaling',1,...
    'title_scaling',1.2);
%g.set_order_options('x',-1);

%g.set_color_options('map', [0, 174/255, 239/255; 255/255, 255/255, 0/255])
gf = copy(g);

gf.axe_property('XTickLabelRotation',60);
gf.axe_property('YTickLabelRotation',0);
gf.axe_property('YLim',[-1 4]);
gf.set_order_options('x',0);
figure('Position',[100 100 1800 600]);
%gf.coord_flip();

gf.set_color_options('map', color, 'lightness', 50)
gf.draw();
gf.export('file_name', savename, 'export_path', savepath, 'file_type', 'png');
