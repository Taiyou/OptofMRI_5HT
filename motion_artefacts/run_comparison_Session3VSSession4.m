%  **** This is for Supplementary figure***
% 
% 
% 1. no difference between comparisons two conditions on motion artefacts
% 2. visualization on results.
%   transgenic
%   - motion xyz TPH
%   - motion rot TPH
%   - motion std xyz TPH
%   - motion std rot TPH
%   WT
%   - motion xyz TPH
%   - motion rot TPH
%   - motion std xyz TPH
%   - motion std rot TPH
%
%
% by Hiro Taiyo Hamada, 2020/12/
clear all; close all;

%%% 0. Preparation for the talk,

run_session3MCheck

run_session4MCheck

savepath = fullfile(pwd, '/figures/motion_artefacts/Session3VSSession4/');
mkdir(savepath)

close all; 
%%% 1. no difference between comparisons two conditions on motion artefacts.
%% Transgenic
% statistical tests on transgenic awake and anesthesia, blue and yellow comparison,
% no significance
[sig_trans_SP, pval_trans_SP]     = ttest(SP_trans_blue_session4-SP_trans_blue_session3, SP_trans_yell_session4-SP_trans_yell_session3)
% statistical tests on standard deviation transgenic awake and anesthesia, blue and yellow 
% no significance
[sig_trans_StdP, pval_trans_StdP] = ttest(StdP_trans_blue_session4-StdP_trans_blue_session3, StdP_trans_yell_session4-StdP_trans_yell_session3)

%% WT
% statistical tests on WT awake and anesthesia, blue and yellow comparison,
% no significance
[sig_wildt_SP, pval_wildt_SP]     = ttest(SP_wildt_blue_session4-SP_wildt_blue_session3, SP_wildt_yell_session4-SP_wildt_yell_session3)
% statistical tests on standard deviation WT awake and anesthesia, blue and yellow comparison
% no significance
[sig_wildt_StdP, pval_wildt_StdP] = ttest(StdP_wildt_blue_session4-StdP_wildt_blue_session3, StdP_wildt_yell_session4-StdP_wildt_yell_session3)


%%% 2. visualization on results.
[nSubject1, npara] = size(SP_trans_blue_session4)
[nSubject2, npara] = size(SP_wildt_blue_session4)

ndata = 0;

%%% Transgenic, blue
%% X and Rx, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'x';
    motionlabel_rot_TPH{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_blue_session4(ii-ndata, 1) - SP_trans_blue_session3(ii-ndata, 1));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_blue_session4(ii-ndata, 1) - StdP_trans_blue_session3(ii-ndata, 1));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_blue_session4(ii-ndata, 4) - SP_trans_blue_session3(ii-ndata, 4);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_blue_session4(ii-ndata, 4) - StdP_trans_blue_session3(ii-ndata, 4);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: blue (n=7)';
end

ndata = ndata + nSubject1;
%% Y and Ry, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'y';
    motionlabel_rot_TPH{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_blue_session4(ii-ndata, 2) - SP_trans_blue_session3(ii-ndata, 2));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_blue_session4(ii-ndata, 2) - StdP_trans_blue_session3(ii-ndata, 2));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_blue_session4(ii-ndata, 5) - SP_trans_blue_session3(ii-ndata, 5);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_blue_session4(ii-ndata, 5) - StdP_trans_blue_session3(ii-ndata, 5);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: blue (n=7)';
end

ndata = ndata + nSubject1;
%% Z and Rz, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'z';
    motionlabel_rot_TPH{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_blue_session4(ii-ndata, 3) - SP_trans_blue_session3(ii-ndata, 3));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_blue_session4(ii-ndata, 3) - StdP_trans_blue_session3(ii-ndata, 3));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_blue_session4(ii-ndata, 6) - SP_trans_blue_session3(ii-ndata, 6);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_blue_session4(ii-ndata, 6) - StdP_trans_blue_session3(ii-ndata, 6);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: blue (n=7)';
end

ndata = ndata + nSubject1;
%%% Transgenic, yellow
%% X and Rx, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'x';
    motionlabel_rot_TPH{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_yell_session4(ii-ndata, 1) - SP_trans_yell_session3(ii-ndata, 1));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_yell_session4(ii-ndata, 1) - StdP_trans_yell_session3(ii-ndata, 1));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_yell_session4(ii-ndata, 4) - SP_trans_yell_session3(ii-ndata, 4);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_yell_session4(ii-ndata, 4) - StdP_trans_yell_session3(ii-ndata, 4);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: yellow (n=7)';
end

ndata = ndata + nSubject1;
%% Y and Ry, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'y';
    motionlabel_rot_TPH{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_yell_session4(ii-ndata, 2) - SP_trans_yell_session3(ii-ndata, 2));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_yell_session4(ii-ndata, 2) - StdP_trans_yell_session3(ii-ndata, 2));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_yell_session4(ii-ndata, 5) - SP_trans_yell_session3(ii-ndata, 5);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_yell_session4(ii-ndata, 5) - StdP_trans_yell_session3(ii-ndata, 5);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: yellow (n=7)';
end

ndata = ndata + nSubject1;
%% Z and Rz, 
for ii = ndata+1:ndata+nSubject1,
    % data type
    motionlabel_xyz_TPH{ii, :}   = 'z';
    motionlabel_rot_TPH{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz_TPH(ii,1)     = 20*(SP_trans_yell_session4(ii-ndata, 3) - SP_trans_yell_session3(ii-ndata, 3));
    motiondata_xyz_std_TPH(ii,1) = (StdP_trans_yell_session4(ii-ndata, 3) - StdP_trans_yell_session3(ii-ndata, 3));
    % motion data rotation
    motiondata_rot_TPH(ii,1)     = SP_trans_yell_session4(ii-ndata, 6) - SP_trans_yell_session3(ii-ndata, 6);
    motiondata_rot_std_TPH(ii,1) = StdP_trans_yell_session4(ii-ndata, 6) - StdP_trans_yell_session3(ii-ndata, 6);
    % group label
    stimtype_TPH{ii, :}          = 'trasgenic: yellow (n=7)';
end

ndata = 0;

%%% WT, blue
%% X and Rx, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'x';
    motionlabel_rot_WT{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_blue_session4(ii-ndata, 1) - SP_wildt_blue_session3(ii-ndata, 1));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_blue_session4(ii-ndata, 1) - StdP_wildt_blue_session3(ii-ndata, 1));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_blue_session4(ii-ndata, 4) - SP_wildt_blue_session3(ii-ndata, 4);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_blue_session4(ii-ndata, 4) - StdP_wildt_blue_session3(ii-ndata, 4);
    % group label
    stimtype_WT{ii, :}          = 'WT: blue (n=5)';
end

ndata = ndata + nSubject2;
%% Y and Ry, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'y';
    motionlabel_rot_WT{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_blue_session4(ii-ndata, 2) - SP_wildt_blue_session3(ii-ndata, 2));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_blue_session4(ii-ndata, 2) - StdP_wildt_blue_session3(ii-ndata, 2));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_blue_session4(ii-ndata, 5) - SP_wildt_blue_session3(ii-ndata, 5);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_blue_session4(ii-ndata, 5) - StdP_wildt_blue_session3(ii-ndata, 5);
    % group label
    stimtype_WT{ii, :}          = 'WT: blue (n=5)';
end

ndata = ndata + nSubject2;
%% Z and Rz, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'z';
    motionlabel_rot_WT{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_blue_session4(ii-ndata, 3) - SP_wildt_blue_session3(ii-ndata, 3));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_blue_session4(ii-ndata, 3) - StdP_wildt_blue_session3(ii-ndata, 3));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_blue_session4(ii-ndata, 6) - SP_wildt_blue_session3(ii-ndata, 6);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_blue_session4(ii-ndata, 6) - StdP_wildt_blue_session3(ii-ndata, 6);
    % group label
    stimtype_WT{ii, :}          = 'WT: blue (n=5)';
end

ndata = ndata + nSubject2;
%%% WT, yellow
%% X and Rx, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'x';
    motionlabel_rot_WT{ii, :}   = 'Rx';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_yell_session4(ii-ndata, 1) - SP_wildt_yell_session3(ii-ndata, 1));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_yell_session4(ii-ndata, 1) - StdP_wildt_yell_session3(ii-ndata, 1));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_yell_session4(ii-ndata, 4) - SP_wildt_yell_session3(ii-ndata, 4);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_yell_session4(ii-ndata, 4) - StdP_wildt_yell_session3(ii-ndata, 4);
    % group label
    stimtype_WT{ii, :}          = 'WT: yellow (n=5)';
end

ndata = ndata + nSubject2;
%% Y and Ry, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'y';
    motionlabel_rot_WT{ii, :}   = 'Ry';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_yell_session4(ii-ndata, 2) - SP_wildt_yell_session3(ii-ndata, 2));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_yell_session4(ii-ndata, 2) - StdP_wildt_yell_session3(ii-ndata, 2));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_yell_session4(ii-ndata, 5) - SP_wildt_yell_session3(ii-ndata, 5);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_yell_session4(ii-ndata, 5) - StdP_wildt_yell_session3(ii-ndata, 5);
    % group label
    stimtype_WT{ii, :}          = 'WT: yellow (n=5)';
end

ndata = ndata + nSubject2;
%% Z and Rz, 
for ii = ndata+1:ndata+nSubject2,
    % data type
    motionlabel_xyz_WT{ii, :}   = 'z';
    motionlabel_rot_WT{ii, :}   = 'Rz';
    % motion data
    motiondata_xyz_WT(ii,1)     = 20*(SP_wildt_yell_session4(ii-ndata, 3) - SP_wildt_yell_session3(ii-ndata, 3));
    motiondata_xyz_std_WT(ii,1) = (StdP_wildt_yell_session4(ii-ndata, 3) - StdP_wildt_yell_session3(ii-ndata, 3));
    % motion data rotation
    motiondata_rot_WT(ii,1)     = SP_wildt_yell_session4(ii-ndata, 6) - SP_wildt_yell_session3(ii-ndata, 6);
    motiondata_rot_std_WT(ii,1) = StdP_wildt_yell_session4(ii-ndata, 6) - StdP_wildt_yell_session3(ii-ndata, 6);
    % group label
    stimtype_WT{ii, :}          = 'WT: yellow (n=5)';
end





%%% Visualization
%% Transgenic, mean, motion
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_xyz_TPH, 'y', motiondata_xyz_TPH,'color', stimtype_TPH);
g(1,1).set_names('x','motion type','y','difference in motion (um)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_xyz_mix1st2nd_TPH', 'export_path', savepath, 'file_type', 'png')


%% Transgenic, mean, rotation
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_rot_TPH, 'y', motiondata_rot_TPH,'color', stimtype_TPH);
g(1,1).set_names('x','motion type','y','difference in motion rotation (degree)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_rot_mix1st2nd_TPH', 'export_path', savepath, 'file_type', 'png')


%% Transgenic, std, rotation
% std, um
clear g
g(1,1)=gramm('x', motionlabel_rot_TPH, 'y', motiondata_xyz_std_TPH,'color', stimtype_TPH);
g(1,1).set_names('x','motion type','y','difference in motion (um^2)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_std_xyz_mix1st2nd_TPH', 'export_path', savepath, 'file_type', 'png')


%% Transgenic, std, rotation
% std, um
clear g
g(1,1)=gramm('x', motionlabel_rot_TPH, 'y', motiondata_rot_std_TPH,'color', stimtype_TPH);
g(1,1).set_names('x','motion type','y','difference in motion rotation (degree^2)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_std_rot_mix1st2nd_TPH', 'export_path', savepath, 'file_type', 'png')



%% WT
%% WT, mean, motion
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_xyz_WT, 'y', motiondata_xyz_WT,'color', stimtype_WT);
g(1,1).set_names('x','motion type','y','difference in motion (um)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_xyz_mix1st2nd_WT', 'export_path', savepath, 'file_type', 'png')


%% WT, mean, rotation
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_rot_WT, 'y', motiondata_rot_WT,'color', stimtype_WT);
g(1,1).set_names('x','motion type','y','difference in motion rotation (degree)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_rot_mix1st2nd_WT', 'export_path', savepath, 'file_type', 'png')


%% WT, std, rotation
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_xyz_WT, 'y', motiondata_xyz_std_WT,'color', stimtype_WT);
g(1,1).set_names('x','motion type','y','difference in motion (um)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_std_xyz_mix1st2nd_WT', 'export_path', savepath, 'file_type', 'png')


%% WT, std, rotation
% motion, um
clear g
g(1,1)=gramm('x', motionlabel_rot_WT, 'y', motiondata_rot_std_WT,'color', stimtype_WT);
g(1,1).set_names('x','motion type','y','difference in motion rotation (degree)','color','# Group');

%Jittered scatter plot
g(1,1).stat_boxplot('width',0.5);
g(1,1).set_title('''half'', true , ''fill'',''transparent''');
g(1,1).set_color_options('map','matlab');

g.set_title(' ', 'FontSize', 28);
figure('Position',[100 100 1400 600]);
g.set_text_options('base_size',28)
g.results.ind_color(1) = 2
g.results.ind_color(2) = 1
g.draw();
g.export('file_name', 'motion_artefact_std_rot_mix1st2nd_WT', 'export_path', savepath, 'file_type', 'png')

