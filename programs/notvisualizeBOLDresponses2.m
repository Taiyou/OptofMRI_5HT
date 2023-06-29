function [AUC1, AUC2, meanTIMESERIES1, meanTIMESERIES2, maxTIMES1, maxTIMES2, Pvalues] = notvisualizeBOLDresponses2(BOLDresponse1, BOLDresponse2, ROIname, resultpath, colors, type, stim)
% This program is intended to visualize and calculate the BOLD signal.
% 
% input:
%   BOLDresponse1
%   BOLDresponse2
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
%   not visualize the .png
%
% by Hiroaki Hamada, Araya Inc., 

close all;

stimDur = 21:40;

nROI = length(ROIname);
Pvalues = zeros(nROI, 1);

[nSub1, nTIME, a, b] = size(BOLDresponse1);
[nSub2, nTIME, a, b] = size(BOLDresponse2);

% mean BOLD of time series
meanTIMESERIES1 = zeros(nSub1, nROI);
meanTIMESERIES2 = zeros(nSub2, nROI);

% area under curve
AUC1 = zeros(nSub1, nROI);
AUC2 = zeros(nSub2, nROI);

% peaks of time signals
maxTIMES1 = zeros(nSub1, nROI);
maxTIMES2 = zeros(nSub2, nROI);

% calculate the pvalues
for iroi = 1:nROI,
    tempsignal1 = squeeze(mean(BOLDresponse1(:, :, stim, iroi),3));
    tempsignal2 = squeeze(mean(BOLDresponse2(:, :, stim, iroi),3));
    
    temptimemean1              = mean(tempsignal1(:, stimDur),2);
    temptimemean2              = mean(tempsignal2(:, stimDur),2);
    
    % mean %BOLD signals, extraction
    meanTIMESERIES1(:, iroi)   = mean(tempsignal1(:, stimDur),2);
    meanTIMESERIES2(:, iroi)   = mean(tempsignal2(:, stimDur),2);
    
    [max1, idmaxtimes1]      = max(abs(tempsignal1(:, stimDur)), [], 2);
    [max2, idmaxtimes2]      = max(abs(tempsignal2(:, stimDur)), [], 2);

    % AUC, extraction
    for isub1 = 1:nSub1,
        temp1                 = cumtrapz(tempsignal1(isub1, stimDur));
        [AUC1(isub1, iroi)]   = temp1(end);
        
        maxTIMES1(isub1, iroi) = tempsignal1(isub1, 20 + idmaxtimes1(isub1));    
    end
    
    for isub2 = 1:nSub2,
        temp2                 = cumtrapz(tempsignal2(isub2, stimDur));
        [AUC2(isub2, iroi)]   = temp2(end);
        
        maxTIMES2(isub2, iroi) = tempsignal2(isub2, 20 + idmaxtimes2(isub2));
    end
    
    
    if strcmp(type, 'same'),
        [Pvalues(iroi), sig] = ranksum(temptimemean1, temptimemean2);
    else
        [Pvalues(iroi), sig] = ranksum(temptimemean1, temptimemean2);
    end
end