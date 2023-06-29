%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Statistical Summary:
%
% 1. contrast between session1 and second replication, ok
%       works good.
% 2. contrast between anesthesia and third replication, ok
%       works ok
%       sig between tph blue anesthesia and awake 2
% 3. contrast between second and third replication, a bit problem
%       one problem
%       WT blue provokes opposite results.
%       artefacts.
% 4. constrast between session1 and third replication,
%       works great :)
%  
%
% 5. comparison between correlation coefficients
%       - (session1 vs. repli)        VS (repli      vs. second repli)
%       - (repli  vs. second repli) VS (anesthesia vs. second repli)
%       - (session1 vs. repli)        VS (session1     vs. second repli)
%
% Figure S7a&b
%
% by Hiro Taiyo Hamada, 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;

% extraction of COPE signals
extCOPEinSession1;
extCOPEinSession2;
extCOPEinSession3;
extCOPEinSession4;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1. contrast between session1 and second replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% transgenic
% blue, transgenic
meanCOPE_session1_tph_blue = transpose(mean(COPE_session1_tph_blue));
meanCOPE_session2st_tph_blue  = transpose(mean(COPE_session2_tph_blue));
index = find(~isnan(meanCOPE_session2st_tph_blue))
[r(1), pval_session1_session2stb] = corr(meanCOPE_session2st_tph_blue(index), meanCOPE_session1_tph_blue(index))
pval(1) = pval_session1_session2stb;

% contrast between session1 and second replication
% yellow, transgenic
meanCOPE_session1_tph_yellow = transpose(mean(COPE_session1_tph_yellow));
meanCOPE_session2st_tph_yellow  = transpose(mean(COPE_session2_tph_yellow));
index = find(~isnan(meanCOPE_session2st_tph_blue))
[r(2), pval_session1_session2sty] = corr(meanCOPE_session2st_tph_yellow(index), meanCOPE_session1_tph_yellow(index))
pval(2) = pval_session1_session2sty;


% contrast between session1 and second replication
%% WT
% blue, WT
meanCOPE_session1_cont_blue = transpose(mean(COPE_session1_cont_blue));
meanCOPE_session2st_cont_blue  = transpose(mean(COPE_session2_cont_blue));
index = find(~isnan(meanCOPE_session2st_cont_blue))
[r(3), pval_session1_session2stb] = corr(meanCOPE_session2st_cont_blue(index), meanCOPE_session1_cont_blue(index))
pval(3) =  pval_session1_session2stb;

% contrast between session1 and second replication
% yellow, WT
meanCOPE_session1_cont_yellow = transpose(mean(COPE_session1_cont_yellow));
meanCOPE_session2st_cont_yellow  = transpose(mean(COPE_session2_cont_yellow));
index = find(~isnan(meanCOPE_session2st_cont_blue))
[r(4), pval_session1_session2sty] = corr(meanCOPE_session2st_cont_yellow(index), meanCOPE_session1_cont_yellow(index))
pval(4) =  pval_session1_session2sty;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2. contrast between anesthesia and third replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% transgenic
% blue, transgenic
meanCOPE_session3_tph_blue = transpose(mean(COPE_session3_tph_blue));
meanCOPE_session4_tph_blue  = transpose(mean(COPE_session4_tph_blue));
index = find(~isnan(meanCOPE_session4_tph_blue))
[r(5), pval_session2st_session4b] = corr(meanCOPE_session3_tph_blue(index), meanCOPE_session4_tph_blue(index));
pval(5) = pval_session2st_session4b;

% contrast between anesthesia and third replication
% yellow, transgenic
meanCOPE_session3_tph_yellow = transpose(mean(COPE_session3_tph_yellow));
meanCOPE_session4_tph_yellow  = transpose(mean(COPE_session4_tph_yellow));
index = find(~isnan(meanCOPE_session3_tph_yellow ))
[r(6), pval_session2st_session4b] = corr(meanCOPE_session3_tph_yellow(index), meanCOPE_session4_tph_yellow(index));
pval(6) = pval_session2st_session4b;

%% WT, 
% blue
meanCOPE_session3_cont_blue = transpose(mean(COPE_session3_cont_blue));
meanCOPE_session4_cont_blue  = transpose(mean(COPE_session4_cont_blue));
index = find(~isnan(meanCOPE_session3_cont_blue))
[r(7), pval_session2st_session4b] = corr(meanCOPE_session3_cont_blue(index), meanCOPE_session4_cont_blue(index));
pval(7) = pval_session2st_session4b;

% contrast between anesthesia and third replication
% yellow, transgenic
meanCOPE_session3_cont_yellow = transpose(mean(COPE_session3_cont_yellow));
meanCOPE_session4_cont_yellow  = transpose(mean(COPE_session4_cont_yellow));
index = find(~isnan(meanCOPE_session3_cont_yellow))
[r(8), pval_session2st_session4b] = corr(meanCOPE_session3_cont_yellow(index), meanCOPE_session4_cont_yellow(index))
pval(8) = pval_session2st_session4b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3. contrast between second and third replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% transgenic
% blue, transgenic
meanCOPE_session4_tph_blue = transpose(mean(COPE_session4_tph_blue));
meanCOPE_session2st_tph_blue  = transpose(mean(COPE_session2_tph_blue));
index = find(~isnan(meanCOPE_session2st_tph_blue))
[r(9), pval_session2st_session4b] = corr(meanCOPE_session4_tph_blue(index), meanCOPE_session2st_tph_blue(index))
pval(9) = pval_session2st_session4b;

%% transgenic
% yellow, transgenic
meanCOPE_session4_tph_yellow = transpose(mean(COPE_session4_tph_yellow));
meanCOPE_session2st_tph_yellow  = transpose(mean(COPE_session2_tph_yellow));
index = find(~isnan(meanCOPE_session2st_tph_yellow))
[r(10), pval_session2st_session4y] = corr(meanCOPE_session4_tph_yellow(index), meanCOPE_session2st_tph_yellow(index))
pval(10) = pval_session2st_session4y;

%% WT, 
% blue
meanCOPE_session4_cont_blue  = transpose(mean(COPE_session4_cont_blue));
meanCOPE_session2st_cont_blue  = transpose(mean(COPE_session2_cont_blue));
index = find(~isnan(meanCOPE_session3_cont_blue))
[r(11), pval_session2st_session4b] = corr(meanCOPE_session4_cont_blue(index), meanCOPE_session2st_cont_blue(index))
pval(11) = pval_session2st_session4b;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% contrast between anesthesia and third replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% yellow, transgenic
meanCOPE_session2st_cont_yellow  = transpose(mean(COPE_session2_cont_yellow));
meanCOPE_session4_cont_yellow  = transpose(mean(COPE_session4_cont_yellow));
index = find(~isnan(meanCOPE_session4_cont_yellow))
[r(12), pval_session2st_session4y] = corr(meanCOPE_session2st_cont_yellow(index), meanCOPE_session4_cont_yellow(index))
pval(12) = pval_session2st_session4y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 4. contrast between session1 and third replication
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% transgenic
% blue, transgenic
index = find(~isnan(meanCOPE_session4_tph_blue))
[r(13), pval_session1_session4b] = corr(meanCOPE_session4_tph_blue(index), meanCOPE_session1_tph_blue(index))
pval(13) = pval_session1_session4b;

%% transgenic
% yellow,
index = find(~isnan(meanCOPE_session4_tph_yellow))
[r(14), pval_session1_session4b] = corr(meanCOPE_session4_tph_yellow(index), meanCOPE_session1_tph_yellow(index))
pval(14) = pval_session1_session4b;


%% WT
% blue, 
index = find(~isnan(meanCOPE_session3_cont_blue))
[r(15), pval_session1_session4y] = corr(meanCOPE_session4_cont_blue(index), meanCOPE_session1_cont_blue(index))
pval(15) = pval_session1_session4y;

%% WT
% yellow, 
index = find(~isnan(meanCOPE_session3_cont_blue))
[r(16), pval_session1_session4y] = corr(meanCOPE_session2st_cont_yellow(index), meanCOPE_session1_cont_yellow(index))
pval(16) = pval_session1_session4y;

fdr_bh(pval)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 5. comparison between correlation coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Transgenic
%% (session1 vs. repli) VS (repli vs. second repli)
n1 = length(meanCOPE_session2st_tph_blue(index));
n2 = length(meanCOPE_session4_tph_blue(index));
[Z, pval1] = zscore_forContrastCorr(r(1), r(9), n1, n2);

%% (repli vs. second repli) VS (anesthesia vs. second repli)
n1 = length(meanCOPE_session2st_tph_blue(index));
n2 = length(meanCOPE_session3_tph_blue(index));
[Z, pval1] = zscore_forContrastCorr(r(9), r(5), n1, n2);

%% (session1 vs. repli) VS (session1 vs. second repli)
n1 = length(meanCOPE_session2st_tph_blue(index));
n2 = length(meanCOPE_session4_tph_blue(index));
[Z, pval1] = zscore_forContrastCorr(r(1), r(13), n1, n2);

%% (session1 vs. repli) VS (anesthesia vs. second repli)
n1 = length(meanCOPE_session2st_tph_blue(index));
n2 = length(meanCOPE_session3_tph_blue(index));
[Z, pval1] =  zscore_forContrastCorr(r(1), r(5), n1, n2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FigureS7a: Comparison of beta values between session 1 vs session2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

savepath = fullfile(pwd, '/figures/FigureS7');

% comparison between first and second replication
COPE_texts(1) = {'beta (a.u.; Awake (First))'};
COPE_texts(2) = {'beta (a.u.; Awake(Second))'};
COPE_texts(3) = {'beta_corr_first_second'};
COPE_texts(4) = {savepath};

% preparation for the 
count = 1;
clear COPE

index = find(~isnan(meanCOPE_session1_tph_blue));
val1  = meanCOPE_session1_tph_blue(index);
val2  = meanCOPE_session1_tph_yellow(index);
val3  = meanCOPE_session2st_tph_blue(index);
val4  = meanCOPE_session2st_tph_yellow(index);

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val3;
COPE.labels(count:nROI, 1) = {'Blue'};
COPE.stim(count:nROI, 1)   = {'Awake (first) vs. Awake (second)'};
COPE.color(count:nROI, 1)  = {'blue'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val2;
COPE.second(count+1:nROI+count, 1) = val4;
COPE.labels(count+1:nROI+count, 1) = {'Yellow'};
COPE.stim(count+1:nROI+count, 1)   = {'Awake (first) vs. Awake (second)'}
COPE.color(count+1:nROI+count, 1)  = {'yellow'};

g = gramm('x', COPE.first, 'y', COPE.second,'color', COPE.color);
%g.facet_grid([], COPE.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'Stim', 'x', COPE_texts(1) ,'y', COPE_texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map','matlab');
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FigureS7b: Comparison of beta values between session 3 vs session4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% comparison between awake and anesthesia
% second repli and anesthesia
% second repli and awake
COPE_texts(1) = {'beta (a.u.; Awake Repli (Second))'};
COPE_texts(2) = {'beta (a.u.)'};
COPE_texts(3) = {'beta_corr_third_anesthesia'};
COPE_texts(4) = {savepath};

% preparation for the 
count = 1;
clear COPE

index = find(~isnan(meanCOPE_session2st_tph_blue));
val1  = meanCOPE_session2st_tph_blue(index);
val2  = meanCOPE_session3_tph_blue(index);
val3  = meanCOPE_session4_tph_blue(index);

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val2;
COPE.labels(count:nROI, 1) = {'1'};
COPE.stim(count:nROI, 1)   = {'Awake Repli (second) vs. Anesthesia (Day1)'};
COPE.color(count:nROI, 1)  = {'vs. Anesthesia (Day1)'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val1;
COPE.second(count+1:nROI+count, 1) = val3;
COPE.labels(count+1:nROI+count, 1) = {'2'};
COPE.stim(count+1:nROI+count, 1)   = {'Awake Repli (second) vs. Awake Repli (Day2)'}
COPE.color(count+1:nROI+count, 1)  = {'vs. Awake Repli (Day2)'};

g = gramm('x', COPE.first, 'y', COPE.second,'color', COPE.color);
%g.facet_grid([], COPE.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_names('column', 'Day', 'x', COPE_texts(1) ,'y', COPE_texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_point_options('base_size', 15);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
%g.set_color_options('map','matlab');
g.set_color_options('hue_range',[150 385], 'lightness_range',[0 95],'chroma_range',[0 0]);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');



