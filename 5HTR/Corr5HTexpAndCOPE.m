% 
%
% 1. Extraction of 5HT receptors
% 2. Visualization of the expression
%
% by Hiro Taiyo Hamada, 2020/12/17

% 1. extraction of 5HT receptors
niftidirect = '/Volumes/HD-ADU3/tphskk/analysis_programs/optofMRIAnalysis/5HTR';
niftiList = makeList(niftidirect, '*.nii');

template = '/Volumes/HD-ADU3/tphskk/analysis_programs/optofMRIAnalysis/atlas.nii';

ROIIds = {1,3,4,5,8,13,23,24,26,33,34,35,38,45,46,47,49,51,52,56,57,59,62,65,69,70,78};

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

% 2. visualization of the expression


%%% 3. Awake 5HT receptor expression
clear r; clear pval
savepath = '/Users/hiroaki-hamada/Desktop/TPHSKK_analysis/programs/ReceptorExpressions';

% htr1a
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT1A exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_tph_5ht1a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 1);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(1), pval(1)] = corr(val1, val2)

% htr1b
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT1B exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_tph_5ht1a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 2);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(2), pval(2)] = corr(val1, val2);


% htr1f
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT1F exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht1f'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 3);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(3), pval(3)] = corr(val1, val2);

% htr2aa
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT2A exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht2a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 4);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(4), pval(4)] = corr(val1, val2);

% htr2c
% TEXTS
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT2C exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht2c'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 5);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(5), pval(5)] = corr(val1, val2);

% 5HT projection

% TEXTS
COPE_texts(1) = {'COPE (first)'};
COPE_texts(2) = {'5HT projection (a.u.)'};
COPE_texts(3) = {'COPE_corr_first_5htproj'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_phasic_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 6);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(6), pval(6)] = corr(val1, val2);

% Anesthesia
% htr1a
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT1A exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_tph_5ht1a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = normalized_HTExpSignals(index, 1);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(7), pval(7)] = corr(val1, val2);

% htr1b
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT1B exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_tph_5ht1a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = normalized_HTExpSignals(index, 2);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(8), pval(8)] = corr(val1, val2);

% htr1f
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT1F exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht1f'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_phasic_tph_blue(index);
val2  = normalized_HTExpSignals(index, 3);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(9), pval(9)] = corr(val1, val2);

% htr2aa
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT2A exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht2a'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = normalized_HTExpSignals(index, 4);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(10), pval(10)] = corr(val1, val2);

% htr2c
% TEXTS
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT2C exp (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_5ht2c'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = normalized_HTExpSignals(index, 5);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(11), pval(11)] = corr(val1, val2);

% 5HT projection

% TEXTS
COPE_texts(1) = {'COPE (Anesthesia)'};
COPE_texts(2) = {'5HT projection (a.u.)'};
COPE_texts(3) = {'COPE_corr_third_anesthesia'};
COPE_texts(4) = {savepath};

index = find(~isnan(meanCOPE_ane1_tph_blue));
val1  = meanCOPE_ane1_tph_blue(index);
val2  = normalized_HTExpSignals(index, 6);
plotCORR(val1, val2, label, stim, COPE_texts);
[r(12), pval(12)] = corr(val1, val2);


