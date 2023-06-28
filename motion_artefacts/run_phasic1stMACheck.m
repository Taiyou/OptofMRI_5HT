% This program is intended to check statistics of motion artefacts on
% behaviorss
%
% Procedure
% %% 1. datapath to the 6 motions data
% %% 2. make list of the datasets
% %% 3. extract time series of motion artefact
% %% 4. make contract between two groups
% %% 5. preparation for visualization
% %% 6. Visualize the results, think after the results are done.
%
%
% by Hiro Taiyo Hamada, Araya Inc., 2020/12/02

%% 1. datapath to the 6 motions data
trans_blue_path = fullfile(pwd, '/phasic1stday/transgenic/blue');
trans_yell_path = fullfile(pwd, '/phasic1stday/transgenic/yellow');
wildt_blue_path = fullfile(pwd, '/phasic1stday/WT/blue');
wildt_yell_path = fullfile(pwd, '/phasic1stday/WT/yellow');
savepath        = fullfile(pwd, '/figures/motion_artefacts');
mkdir(savepath)


%% 2. make list of the datasets
trans_blue_listing = makeList(trans_blue_path, '*blue.txt');
trans_yell_listing = makeList(trans_yell_path, '*yell.txt');
wildt_blue_listing = makeList(wildt_blue_path, '*blue.txt');
wildt_yell_listing = makeList(wildt_yell_path, '*yell.txt');


%% 3. extract time series of motion artefact
% and extract statistical parameters
[ts_trans_blue, SP_trans_blue, SP_trans_blue_stim, StdP_trans_blue, StdP_trans_blue_stim] = extractTS(trans_blue_listing, 680, [81, 201, 321, 441, 561], 60);
[ts_trans_yell, SP_trans_yell, SP_trans_yell_stim, StdP_trans_yell, StdP_trans_yell_stim] = extractTS(trans_yell_listing, 680, [81, 201, 321, 441, 561], 60);
[ts_wildt_blue, SP_wildt_blue, SP_wildt_blue_stim, StdP_wildt_blue, StdP_wildt_blue_stim] = extractTS(wildt_blue_listing, 680, [81, 201, 321, 441, 561], 60); 
[ts_wildt_yell, SP_wildt_yell, SP_wildt_yell_stim, StdP_wildt_yell, StdP_wildt_yell_stim] = extractTS(wildt_yell_listing, 680, [81, 201, 321, 441, 561], 60);
 
%% 4. make contract between two groups
% mean difference between groups
[sig, p_trans_BY] = ttest(SP_trans_blue, SP_trans_yell);
fprintf('Contract of transgenic betweeen blue and yellow: pval = %f \n \n', p_trans_BY);

[sig, p_wildt_BY] = ttest(SP_wildt_blue, SP_wildt_yell);
fprintf('Contract of wild-type betweeen blue and yellow: pval = %f \n \n', p_wildt_BY);

[sig, p_TW_B]     = ttest2(SP_trans_blue, SP_wildt_blue);
fprintf('Contract of blue betweeen transgenic and wild-type: pval = %f \n \n', p_TW_B);

[sig, p_TW_Y]     = ttest2(SP_trans_yell, SP_wildt_yell);
fprintf('Contract of yellow betweeen transgenic and wild-type: pval = %f \n \n', p_TW_Y);

for ii = 1:6,
    [p_TW_BY(ii), sig]       = ranksum(SP_trans_blue(:,ii)-SP_trans_yell(:,ii), SP_wildt_blue(:,ii)-SP_wildt_yell(:,ii));
    [p_stim_TW_BY(ii), sig]  = ranksum(SP_trans_blue_stim(:,ii)-SP_trans_yell_stim(:,ii), SP_wildt_blue_stim(:,ii)-SP_wildt_yell_stim(:,ii));
end

p_TW_BY
p_stim_TW_BY

% std difference between groups
[sig, p_trans_BY_std] = ttest(StdP_trans_blue, StdP_trans_yell);
fprintf('Contract of transgenic betweeen blue and yellow: pval = %f \n \n', p_trans_BY_std);

[sig, p_wildt_BY_std] = ttest(StdP_wildt_blue, StdP_wildt_yell);
fprintf('Contract of wild-type betweeen blue and yellow: pval = %f \n \n', p_wildt_BY_std);

[sig, p_TW_B_std]     = ttest2(StdP_trans_blue, StdP_wildt_blue);
fprintf('Contract of blue betweeen transgenic and wild-type: pval = %f \n \n', p_TW_B_std);

[sig, p_TW_Y_std]     = ttest2(StdP_trans_yell, StdP_wildt_yell);
fprintf('Contract of yellow betweeen transgenic and wild-type: pval = %f \n \n', p_TW_Y_std);

for ii = 1:6,
    [p_TW_BY_std(ii), sig]       = ranksum(StdP_trans_blue(:,ii)-StdP_trans_yell(:,ii), StdP_wildt_blue(:,ii)-StdP_wildt_yell(:,ii));
    [p_stim_TW_BY_std(ii), sig]  = ranksum(StdP_trans_blue_stim(:,ii)-StdP_trans_yell_stim(:,ii), StdP_wildt_blue_stim(:,ii)-StdP_wildt_yell_stim(:,ii));
end

p_TW_BY_std
p_stim_TW_BY_std


%% 5. preparation for visualization
[nSubject1, npara] = size(SP_trans_blue)
[nSubject2, npara] = size(SP_wildt_blue)

ndata = 0;

for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz{ii, :}   = 'x';
    motionlabel_rot{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz(ii,1)     = 20*(SP_trans_blue(ii-ndata, 1) - SP_trans_yell(ii-ndata, 1));
    motiondata_xyz_std(ii,1) = (StdP_trans_blue(ii-ndata, 1) - StdP_trans_yell(ii-ndata, 1));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_trans_blue(ii-ndata, 4) - SP_trans_yell(ii-ndata, 4);
    motiondata_rot_std(ii,1) = StdP_trans_blue(ii-ndata, 4) - StdP_trans_yell(ii-ndata, 4);
    % group label
    stimtype{ii, :}          = 'trasgenic (n=8)';
end


ndata = ndata + nSubject1;
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz{ii, :}   = 'x';
    motionlabel_rot{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz(ii,1)     = 20*(SP_wildt_blue(ii-ndata, 1) - SP_wildt_yell(ii-ndata, 1));
    motiondata_xyz_std(ii,1) = (StdP_wildt_blue(ii-ndata, 1) - StdP_wildt_yell(ii-ndata, 1));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_wildt_blue(ii-ndata, 4) - SP_wildt_yell(ii-ndata, 4);
    motiondata_rot_std(ii,1) = StdP_wildt_blue(ii-ndata, 4) - StdP_wildt_yell(ii-ndata, 4);
    % group label
    stimtype{ii, :}          = 'wild-type (n=6)';
end

ndata = ndata + nSubject2;
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz{ii, :}   = 'y';
    motionlabel_rot{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz(ii,1)     = 20*(SP_trans_blue(ii-ndata, 2) - SP_trans_yell(ii-ndata, 2));
    motiondata_xyz_std(ii,1) = (StdP_trans_blue(ii-ndata, 2) - StdP_trans_yell(ii-ndata, 2));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_trans_blue(ii-ndata, 5) - SP_trans_yell(ii-ndata, 5);
    motiondata_rot_std(ii,1) = StdP_trans_blue(ii-ndata, 5) - StdP_trans_yell(ii-ndata, 5);
    % group label
    stimtype{ii, :}          = 'trasgenic (n=8)';
end

ndata = ndata + nSubject1;
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz{ii, :}   = 'y';
    motionlabel_rot{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz(ii,1)     = 20*(SP_wildt_blue(ii-ndata, 2) - SP_wildt_yell(ii-ndata, 2));
    motiondata_xyz_std(ii,1) = (StdP_wildt_blue(ii-ndata, 2) - StdP_wildt_yell(ii-ndata, 2));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_wildt_blue(ii-ndata, 5) - SP_wildt_yell(ii-ndata, 5);
    motiondata_rot_std(ii,1) = StdP_wildt_blue(ii-ndata, 5) - StdP_wildt_yell(ii-ndata, 5);
    % group label
    stimtype{ii, :}          = 'wild-type (n=6)';
end

ndata = ndata + nSubject2;
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz{ii, :}   = 'z';
    motionlabel_rot{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz(ii,1)     = 30*(SP_trans_blue(ii-ndata, 3) - SP_trans_yell(ii-ndata, 3));
    motiondata_xyz_std(ii,1) = (StdP_trans_blue(ii-ndata, 3) - StdP_trans_yell(ii-ndata, 3));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_trans_blue(ii-ndata, 6) - SP_trans_yell(ii-ndata, 6);
    motiondata_rot_std(ii,1) = StdP_trans_blue(ii-ndata, 6) - StdP_trans_yell(ii-ndata, 6);
    % group label
    stimtype{ii, :}          = 'trasgenic (n=8)';
end

ndata = ndata + nSubject1;
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz{ii, :}   = 'z';
    motionlabel_rot{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz(ii,1)     = 30*(SP_wildt_blue(ii-ndata, 3) - SP_wildt_yell(ii-ndata, 3));
    motiondata_xyz_std(ii,1) = (StdP_wildt_blue(ii-ndata, 3) - StdP_wildt_yell(ii-ndata, 3));
    % motion data rotation
    motiondata_rot(ii,1)     = SP_wildt_blue(ii-ndata, 6) - SP_wildt_yell(ii-ndata, 6);
    motiondata_rot_std(ii,1) = StdP_wildt_blue(ii-ndata, 6) - StdP_wildt_yell(ii-ndata, 6);
    % group label
    stimtype{ii, :}          = 'wild-type (n=6)';
end   


%% 6. Visualize the results, think after the results are done.
% motion, ��m
clear g
g(1,1)=gramm('x', motionlabel_xyz, 'y', motiondata_xyz ,'color', stimtype);
g(1,1).set_names('x','motion type','y','difference in mean motion (��m)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_xyz', 'export_path', savepath, 'file_type', 'png')

% motion, degree
clear g
g(1,1)=gramm('x', motionlabel_rot, 'y', motiondata_rot,'color', stimtype);
g(1,1).set_names('x','motion type','y',' diference in mean motion (degree)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_rot', 'export_path', savepath, 'file_type', 'png')


% std
% motion, ��m
clear g
g(1,1)=gramm('x', motionlabel_xyz, 'y', motiondata_xyz_std ,'color', stimtype);
g(1,1).set_names('x','motion type','y','difference in std motion (��m^2)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_xyz_std', 'export_path', savepath, 'file_type', 'png')

% motion, degree
clear g
g(1,1)=gramm('x', motionlabel_rot, 'y', motiondata_rot_std,'color', stimtype);
g(1,1).set_names('x','motion type','y',' diference in std motion (degree^2)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'',true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_rot_std', 'export_path', savepath, 'file_type', 'png')