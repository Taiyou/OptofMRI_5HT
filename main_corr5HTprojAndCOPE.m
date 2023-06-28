% by Hiro Taiyo Hamada, 2020/12/17
close all; clear all;

% 1. extraction of 5HT receptors
niftidirect = fullfile(pwd, '/5HTR');
niftiList = makeList(niftidirect, '*.nii');

template = fullfile(pwd,'/atlas.nii');
savepath = fullfile(pwd,'/ReceptorExpressions');

% 28 ROIs
ROIIds = {1,26,24,4,23,3,8,34,33,38,13,5,35,16,52,51,70,56,57,78,65,62,59,49,69,47,46,45};

% this is for the 5HTR expression
[HTExpSignals] = EXPext(niftiList, template, ROIIds);
% normalization
normalized_HTExpSignals = (HTExpSignals-min(HTExpSignals))./max(HTExpSignals-min(HTExpSignals));

% 1: htr1a
% 2: htr1b
% 3: htr1f
% 4: htr2a
% 5: htr2c
% 6: projection

% load COPE 
COPEpath = fullfile(pwd, '/data');
load(fullfile(COPEpath, 'COPE_Phasic_tph_blue.mat'));
load(fullfile(COPEpath, 'tphB_ane1.mat'));
load(fullfile(COPEpath, 'tphB_ane2.mat'));
load(fullfile(COPEpath, 'tphB_mix1.mat'));
%
load(fullfile(COPEpath, 'COPE_Phasic_tph_yellow.mat'));
load(fullfile(COPEpath, 'tphY_ane1.mat'));
load(fullfile(COPEpath, 'tphY_ane2.mat'));
load(fullfile(COPEpath, 'tphY_mix1.mat'));

meanCOPE_phasic_tph_blue   = transpose(mean(COPE_Phasic_tph_blue));
meanCOPE_phasic_tph_yellow = transpose(mean(COPE_Phasic_tph_yellow));
meanCOPE_mix1st_tph_blue   = transpose(mean(COPE_MIX1_tph_blue));
meanCOPE_mix1st_tph_yellow = transpose(mean(COPE_MIX1_tph_yellow));
meanCOPE_ane1_tph_blue     = transpose(mean(COPE_Ane1_tph_blue));
meanCOPE_ane2_tph_blue     = transpose(mean(COPE_Ane2_tph_blue));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.1. 5HT projection density and Awake, first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_phasic_tph_blue) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_phasic_tph_blue(index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(1), pval(1)] = corr(val1, val2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.2. 5HT projection density and Awake, second
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_mix1st_tph_blue) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_mix1st_tph_blue(index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(2), pval(2)] = corr(val1, val2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.3. 5HT projection density and Anesthesia, third
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_ane1_tph_blue) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_ane1_tph_blue(index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(3), pval(3)] = corr(val1, val2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.4. 5HT projection density and Awake, fourth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_ane2_tph_blue) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_ane2_tph_blue(index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(4), pval(4)] = corr(val1, val2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.5. 5HT projection density and Awake, yellow, first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_phasic_tph_yellow) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_phasic_tph_yellow(index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(5), pval(5)] = corr(val1, val2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.6. 5HT projection density and Awake, yellow, first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
index = find(~isnan(meanCOPE_mix1st_tph_yellow) .* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = normalized_HTExpSignals(index, 6);
val2  = meanCOPE_mix1st_tph_yellow (index);
%plotCORR(val1, val2, label, stim, COPE_texts);
[r(6), pval(6)] = corr(val1, val2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.1. 5HT projection density and first
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% visualization
% comparison between awake (second) and 5HT projection density
COPE_texts(1) = {'5HT projection density (a.u.)'};
COPE_texts(2) = {'beta (a.u.)'};
COPE_texts(3) = {'Structural_corr_first'};
COPE_texts(4) = {savepath};

% preparation for the 
count = 1;
clear COPE

index = find(~isnan(meanCOPE_phasic_tph_blue).* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = meanCOPE_phasic_tph_yellow(index);
val3  = normalized_HTExpSignals(index, 6);

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val3;
COPE.labels(count:nROI, 1) = {'blue'};
COPE.color(count:nROI, 1)  = {'blue'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val2;
COPE.second(count+1:nROI+count, 1) = val3;
COPE.labels(count+1:nROI+count, 1) = {'yellow'};
COPE.color(count+1:nROI+count, 1)  = {'yellow'};

g = gramm('x', COPE.second, 'y', COPE.first,'color', COPE.color);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

color = zeros(2, 3);
yellow = [235, 186, 26]/255;
blue   = [0, 1, 1];
color(2, :) = yellow;
color(1, :) = blue;

% get labelling
g.set_point_options('base_size', 15);
g.set_names('column', 'Stim', 'x', COPE_texts(1) ,'y', COPE_texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map', color);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.2. 5HT projection density and second
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% visualization
% comparison between awake (second) and 5HT projection density
COPE_texts(1) = {'5HT projection density (a.u.)'};
COPE_texts(2) = {'beta (a.u.)'};
COPE_texts(3) = {'Structural_corr_second'};
COPE_texts(4) = {savepath};

% preparation for the 
count = 1;
clear COPE

index = find(~isnan(meanCOPE_mix1st_tph_blue).* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = meanCOPE_mix1st_tph_blue(index);
val2  = meanCOPE_mix1st_tph_yellow(index);
val3  = normalized_HTExpSignals(index, 6);

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val3;
COPE.labels(count:nROI, 1) = {'blue'};
COPE.color(count:nROI, 1)  = {'blue'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val2;
COPE.second(count+1:nROI+count, 1) = val3;
COPE.labels(count+1:nROI+count, 1) = {'yellow'};
COPE.color(count+1:nROI+count, 1)  = {'yellow'};

%g = gramm('x', COPE.first, 'y', COPE.second,'color', COPE.color);
g = gramm('x', COPE.second, 'y', COPE.first,'color', COPE.color);
%g.facet_grid([], COPE.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

% get labelling
g.set_point_options('base_size', 15);
g.set_names('column', 'Stim', 'x', COPE_texts(1) ,'y', COPE_texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map', color);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2.3. 5HT projection density and Anesthesia and Awake
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% visualization
% comparison between awake (second) and 5HT projection density
COPE_texts(1) = {'5HT projection density (a.u.)'};
COPE_texts(2) = {'beta (a.u.)'};
COPE_texts(3) = {'Structural_corr_AneAndAwake'};
COPE_texts(4) = {savepath};

% preparation for the 
count = 1;
clear COPE

index = find(~isnan(meanCOPE_ane1_tph_blue).* ~isnan(normalized_HTExpSignals(:, 6)));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = meanCOPE_ane2_tph_blue(index);
val3  = normalized_HTExpSignals(index, 6);

nROI = length(val1);

% blue stim control
COPE.first(count:nROI, 1)  = val1;
COPE.second(count:nROI, 1) = val3;
COPE.labels(count:nROI, 1) = {'Session3: Anesthesia'};
COPE.color(count:nROI, 1)  = {'Session3: Anesthesia'};
count = nROI;
% yellow stim control
COPE.first(count+1:nROI+count, 1)  = val2;
COPE.second(count+1:nROI+count, 1) = val3;
COPE.labels(count+1:nROI+count, 1) = {'Session4: Awake'};
COPE.color(count+1:nROI+count, 1)  = {'Session4: Awake'};

%g = gramm('x', COPE.first, 'y', COPE.second,'color', COPE.color);
g = gramm('x', COPE.second, 'y', COPE.first,'color', COPE.color);
%g.facet_grid([], COPE.labels);

% plot row data as points
g.geom_point();
% general linear 
g.stat_glm();

blue = [0, 1, 1];
mazenta = [1, 0, 1];
color(2,:) = blue;
color(1,:) = mazenta;

% get labelling
g.set_point_options('base_size', 15);
g.set_names('column', 'Stim', 'x', COPE_texts(1) ,'y', COPE_texts(2) ,'color','# stim');
g.axe_property('FontSize', 42);
g.set_text_options('base_size', 42, 'label_scaling', 1, 'legend_scaling', 1);
g.set_color_options('map', color);
figure('Position', [100 100 1400 1000]);
g.draw();
g.export('file_name', COPE_texts{3},'export_path', COPE_texts{4}, 'file_type', 'png');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.1. 5HT projection density, 5HT projection and 5HT receptors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear color

% multiple regression based on projection density and gene exp.
index = find(~isnan(meanCOPE_ane2_tph_blue).* ~isnan(normalized_HTExpSignals(:, 4)));
val1 = normalized_HTExpSignals(index, 1);
val2 = normalized_HTExpSignals(index, 2);
val3 = normalized_HTExpSignals(index, 3);
val4 = normalized_HTExpSignals(index, 4);
val5 = normalized_HTExpSignals(index, 5);
val6 = normalized_HTExpSignals(index, 6);
COPE1 = meanCOPE_phasic_tph_blue(index);
COPE2 = meanCOPE_mix1st_tph_blue(index);
COPE3 = meanCOPE_ane1_tph_blue(index);
COPE4 = meanCOPE_ane2_tph_blue(index);

% correlation map between 

X1 = [ones(size(COPE2)) val1 val2 val3 val4 val5 val6];
[b1,bint1,r1,rint1,stats1] = regress(COPE1, X1); % Removes NaN data

YFIT = b1(1) + val1*b1(2) + val2*b1(3) + val3*b1(4) + val4*b1(5) + val5*b1(6) + val6*b1(7);
[r3(1), pval3(1)] = corr(YFIT, COPE1)
[r3(2), pval3(2)] = corr(YFIT, COPE2)
[r3(3), pval3(3)] = corr(YFIT, COPE3)
[r3(4), pval3(4)] = corr(YFIT, COPE4)

% COPE predictor based on phasic
COPE_texts(1) = {'fit model'};
COPE_texts(2) = {'beta (Session1)'};
COPE_texts(3) = {'beta_corr_predictor_phasic'};
COPE_texts(4) = {savepath};
label = {'blue stim'};
stim  = {'green'};

blue = [0, 1, 1];
mazenta = [1, 0, 1];
color1(1,:) = blue;
color2(1,:) = mazenta;

index = find(~isnan(meanCOPE_phasic_tph_blue));
plotCORR(YFIT, COPE1, label, stim, COPE_texts, color1);

% COPE predictor based on mix1st
COPE_texts(1) = {'fit model'};
COPE_texts(2) = {'beta (Session2)'};
COPE_texts(3) = {'beta_corr_predictor_session2'};
COPE_texts(4) = {savepath};

plotCORR(YFIT, COPE2, label, stim, COPE_texts, color1)

% COPE predictor based on anesthesia
COPE_texts(1) = {'fit model'};
COPE_texts(2) = {'beta (Session3:Anesthesia)'};
COPE_texts(3) = {'beta_corr_predictor_session3'};
COPE_texts(4) = {savepath};

plotCORR( YFIT,COPE3, label, stim, COPE_texts, color2);

% COPE predictor based on second replication
COPE_texts(1) = {'fit model'};
COPE_texts(2) = {'beta (Session4:Awake)'};
COPE_texts(3) = {'beta_corr_predictor_session4'};
COPE_texts(4) = {savepath};

plotCORR(YFIT,COPE4, label, stim, COPE_texts, color1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.1. Prepare One-way ANOVA on 5HT projection density and 5HT receptors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% receptor, structural density, intercept
X1 = [val1 val2 val3 val4 val5 val6 ones(size(COPE2))];

regreLen = 7;
statsLen = 4;
index = find(~isnan(meanCOPE_ane2_tph_blue).* ~isnan(normalized_HTExpSignals(:, 4)));

% session 1-4
[nSubSession1, ~] = size(COPE_Phasic_tph_blue);
b1 = zeros(regreLen, nSubSession1);
stats1 = zeros(statsLen, nSubSession1);

[nSubSession2, ~] = size(COPE_MIX1_tph_blue);
b2 = zeros(regreLen, nSubSession2);
stats2 = zeros(statsLen, nSubSession2);

[nSubSession3, ~] = size(COPE_Ane1_tph_blue);
b3 = zeros(regreLen, nSubSession3);
stats3 = zeros(statsLen, nSubSession3);
% receptor, structural density, intercept
X1 = [val1 val2 val3 val4 val5 val6 ones(size(COPE2))];

regreLen = 7;
statsLen = 4;
index = find(~isnan(meanCOPE_ane2_tph_blue).* ~isnan(normalized_HTExpSignals(:, 4)));

% session 1-4
[nSubSession1, ~] = size(COPE_Phasic_tph_blue);
b1 = zeros(regreLen, nSubSession1);
stats1 = zeros(statsLen, nSubSession1);

[nSubSession2, ~] = size(COPE_MIX1_tph_blue);
b2 = zeros(regreLen, nSubSession2);
stats2 = zeros(statsLen, nSubSession2);

[nSubSession3, ~] = size(COPE_Ane1_tph_blue);
b3 = zeros(regreLen, nSubSession3);
stats3 = zeros(statsLen, nSubSession3);

[nSubSession4, ~] = size(COPE_Ane2_tph_blue);
b4 = zeros(regreLen, nSubSession4);
stats4 = zeros(statsLen, nSubSession4);

% session 1
for ii = 1:nSubSession1,
    cope1_temp = transpose(COPE_Phasic_tph_blue(ii,index));
    [b1(:,ii),~,~,~,stats1(:,ii)] = regress(cope1_temp, X1);
end
% session 2
for ii = 1:nSubSession2,
    cope2_temp = transpose(COPE_MIX1_tph_blue(ii,index));
    [b2(:,ii),~,~,~,stats2(:,ii)] = regress(cope2_temp, X1);
end
% session 3
for ii = 1:nSubSession3,
    cope3_temp = transpose(COPE_Ane1_tph_blue(ii,index));
    [b3(:,ii),~,~,~,stats3(:,ii)] = regress(cope3_temp, X1);
end
% session 4
for ii = 1:nSubSession4,
    cope4_temp = transpose(COPE_Ane2_tph_blue(ii,index));
    [b4(:,ii),~,~,~,stats4(:,ii)] = regress(cope4_temp, X1);
end

% session 1
for ii = 1:nSubSession1,
    cope1_temp = transpose(COPE_Phasic_tph_blue(ii,index));
    [b1(:,ii),~,~,~,stats1(:,ii)] = regress(cope1_temp, X1);
end
% session 2
for ii = 1:nSubSession2,
    cope2_temp = transpose(COPE_MIX1_tph_blue(ii,index));
    [b2(:,ii),~,~,~,stats2(:,ii)] = regress(cope2_temp, X1);
end
% session 3
for ii = 1:nSubSession3,
    cope3_temp = transpose(COPE_Ane1_tph_blue(ii,index));
    [b3(:,ii),~,~,~,stats3(:,ii)] = regress(cope3_temp, X1);
end
% session 4
for ii = 1:nSubSession4,
    cope4_temp = transpose(COPE_Ane2_tph_blue(ii,index));
    [b4(:,ii),~,~,~,stats4(:,ii)] = regress(cope4_temp, X1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.2. visualize regression weights, Figure 5d
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

htR = zeros(7,4);
htR(:, 1) = mean(b1,2);
htR(:, 2) = mean(b2,2);
htR(:, 3) = mean(b3,2);
htR(:, 4) = mean(b4,2);

error = zeros(7,4);
error(:, 1) = std(transpose(b1));
error(:, 2) = std(transpose(b2));
error(:, 3) = std(transpose(b3));
error(:, 4) = std(transpose(b4));

% visualize the weights 
supple_weight5HT(htR, error)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.3. Summary of Statistics of regression 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% R2 statistics, F statistics, p-value, estimate of the error variance
fprintf('Session1 \n');
fprintf('R2 stat: mean: %.4f　& std: %.4f \n', mean(stats1(1,:)), std(stats1(1,:)));
fprintf('F stat: mean: %.4f　& std: %.4f \n', mean(stats1(2,:)), std(stats1(2,:)));
fprintf('Pval stat: mean: %.4f　& std: %.4f \n', mean(stats1(3,:)), std(stats1(3,:)));
fprintf('estimate of the error variance: %.4f　& std: %.4f \n', mean(stats1(4,:)), std(stats1(4,:)));
fprintf('\n');
% session 2
fprintf('Session2 \n');
fprintf('R2 stat: mean: %.4f　& std: %.4f \n', mean(stats2(1,:)), std(stats2(1,:)));
fprintf('F stat: mean: %.4f　& std: %.4f \n', mean(stats2(2,:)), std(stats2(2,:)));
fprintf('Pval stat: mean: %.4f　& std: %.4f \n', mean(stats2(3,:)), std(stats2(3,:)));
fprintf('estimate of the error variance: %.4f　& std: %.4f \n', mean(stats2(4,:)), std(stats2(4,:)));
fprintf('\n');
% session 3
fprintf('Session3 \n');
fprintf('R2 stat: mean: %.4f　& std: %.4f \n', mean(stats3(1,:)), std(stats3(1,:)));
fprintf('F stat: mean: %.4f　& std: %.4f \n', mean(stats3(2,:)), std(stats3(2,:)));
fprintf('Pval stat: mean: %.4f　& std: %.4f \n', mean(stats3(3,:)), std(stats3(3,:)));
fprintf('estimate of the error variance: %.4f　& std: %.4f \n', mean(stats3(4,:)), std(stats3(4,:)));
fprintf('\n');
% session 4
fprintf('Session4 \n');
fprintf('R2 stat: mean: %.4f　& std: %.4f \n', mean(stats4(1,:)), std(stats4(1,:)));
fprintf('F stat: mean: %.4f　& std: %.4f \n', mean(stats4(2,:)), std(stats4(2,:)));
fprintf('Pval stat: mean: %.4f　& std: %.4f \n', mean(stats4(3,:)), std(stats4(3,:)));
fprintf('estimate of the error variance: mean: %.4f　& std: %.4f \n', mean(stats4(4,:)), std(stats4(4,:)));
fprintf('\n');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4.4. One-way ANOVA with intercept, Table 3 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

group = [];
intercept_ANOVA = [];
ht1a_ANOVA = [];
ht1b_ANOVA = [];
ht1f_ANOVA = [];
ht2a_ANOVA = [];
ht2c_ANOVA = [];
proj_ANOVA = [];

for ii = 1:nSubSession1,
    group{end+1} = 'awake';
    ht1a_ANOVA(end+1) = b1(1,ii);
    ht1b_ANOVA(end+1) = b1(2,ii);
    ht1f_ANOVA(end+1) = b1(3,ii);
    ht2a_ANOVA(end+1) = b1(4,ii);
    ht2c_ANOVA(end+1) = b1(5,ii);
    proj_ANOVA(end+1) = b1(6,ii);
    intercept_ANOVA(end+1) = b1(7,ii);
end
for ii = 1:nSubSession2,
    group{end+1} = 'awake';
    ht1a_ANOVA(end+1) = b2(1,ii);
    ht1b_ANOVA(end+1) = b2(2,ii);
    ht1f_ANOVA(end+1) = b2(3,ii);
    ht2a_ANOVA(end+1) = b2(4,ii);
    ht2c_ANOVA(end+1) = b2(5,ii);
    proj_ANOVA(end+1) = b2(6,ii);
    intercept_ANOVA(end+1) = b2(7,ii);
end

for ii = 1:nSubSession3,
    group{end+1} = 'anesthetized';
    ht1a_ANOVA(end+1) = b3(1,ii);
    ht1b_ANOVA(end+1) = b3(2,ii);
    ht1f_ANOVA(end+1) = b3(3,ii);
    ht2a_ANOVA(end+1) = b3(4,ii);
    ht2c_ANOVA(end+1) = b3(5,ii);
    proj_ANOVA(end+1) = b3(6,ii);
    intercept_ANOVA(end+1) = b3(7,ii);
end
for ii = 1:nSubSession4,
    group{end+1} = 'awake';
    ht1a_ANOVA(end+1) = b4(1,ii);
    ht1b_ANOVA(end+1) = b4(2,ii);
    ht1f_ANOVA(end+1) = b4(3,ii);
    ht2a_ANOVA(end+1) = b4(4,ii);
    ht2c_ANOVA(end+1) = b4(5,ii);
    proj_ANOVA(end+1) = b4(6,ii);
    intercept_ANOVA(end+1) = b4(7,ii);
end

[p_5ht1a,tbl_intercept,stats_5ht1a] = anova1(ht1a_ANOVA,  group);
[p_5ht1b,tbl_intercept,stats_5ht1b] = anova1(ht1b_ANOVA,  group);
[p_5ht1f,tbl_intercept,stats_5ht1f] = anova1(ht1f_ANOVA,  group);
[p_5ht2a,tbl_intercept,stats_5ht2a] = anova1(ht2a_ANOVA,  group);
[p_5ht2c,tbl_intercept,stats_5ht2c] = anova1(ht2c_ANOVA,  group);
[p_proj,tbl_intercept,stats_proj] = anova1(proj_ANOVA,  group);
[p_intercept,tbl_intercept,stats_intercept] = anova1(intercept_ANOVA,  group);

p_weights = [p_5ht1a, p_5ht1b, p_5ht1f, p_5ht2a, p_5ht2c, p_intercept, p_proj];
test_weights = p_weights*7 < 0.05;
remaind_weights = {'5ht1a', '5ht1b', '5ht1f', '5ht2a', '5ht2c', 'proj', 'intercept'};

fprintf("Statistically significant receptors");
remaind_weights{test_weights}


