function [AUC1, meanTIMESERIES1, maxTIMES1] = visualizeCBVresponses_madino(CBVresponse, ROIname, resultpath, colors, stim)
% This program is intended to visualize and calculate the CBV signal.
% 
% input:
%   CBVresponse1
%   CBVresponse2
%   ROIname
%   resultpath: where you can save .png files/
%   colors: colors of plots.
%   type: analysis type 'same' or 'different' 
%
% output:
%   AUC1: area under curve for datalist 1,
%   AUC2: area under curve for datalist 2, 
%   meanTIMESERIES1: 
%   meanTIMESERIES2: 
%
%   pvalues:
%   visualize the .png
%
% by Hiroaki Hamada, Araya Inc., 

close all;
nROI = length(ROIname);
Pvalues = zeros(nROI, 1);

[nSub1, nTIME, a, b] = size(CBVresponse);

% mean CBV of time series
meanTIMESERIES1 = zeros(nSub1, nROI);

% area under curve
AUC1 = zeros(nSub1, nROI);

% peaks of time signals
maxTIMES1 = zeros(nSub1, nROI);

stimDur = 11:20;

% calculate the pvalues
for iroi = 1:nROI,
    
    % extract all stimulation trials
    tempsignal1 = squeeze(mean(CBVresponse(:, :, stim, iroi),3));
    
    % mean across all subjects
    temptimemean1              = mean(tempsignal1(:, stimDur),2);
    
    % mean %CBV signals, extraction
    meanTIMESERIES1(:, iroi)   = mean(tempsignal1(:, stimDur),2);
    
    maxTIMES1(:, iroi) = max(tempsignal1(:, stimDur), [], 2);

    % AUC, extraction
    for isub1 = 1:nSub1,
        temp1                 = cumtrapz(tempsignal1(isub1, stimDur));
        [AUC1(isub1, iroi)]   = temp1(end);
    end
        
    
    %figure;
    stdshade(tempsignal1, 0.2, colors);
    set(gcf,'Position',[100 100 800 800]);
    set(gca, 'FontSize', 28, 'LineWidth', 5);
    xlabel('Time(seconds)'); ylabel('ΔCBV');
    ylim([-2 2]);
    box off;
    
    xticks([0 5 10 15 20 25 30 35 40])
    xticklabels({'-10','0','10','20','30','40','50', '60'})
    figurename = fullfile(resultpath, strcat(ROIname{iroi}, '.png'));
    saveas(gca, figurename);
end