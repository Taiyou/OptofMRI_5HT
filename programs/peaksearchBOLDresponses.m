function [maxTIMES1, maxTIMES2, maxTIMES1id, maxTIMES2id, maxAUC1, maxAUC2, maxAUC1st, maxAUC2nd] = peaksearchBOLDresponses(BOLDresponse1, BOLDresponse2, ROIname, timedur, stim)
% This program is intended to search location peak of the BOLD signal.
% 
% input:
%   BOLDresponse1
%   BOLDresponse2
%   ROIname
%   resultpath: where you can save .png files/
%   colors: colors of plots.
%   timedur: time duration for optical stimulation
%
% output:
%   maxTIMES1: area under curve for datalist 1,
%   maxTIMES2: area under curve for datalist 2, 
%
%   pvalues:
%   not visualize the .png
%
% by Hiroaki Hamada, Araya Inc.,

close all;
nROI = length(ROIname);
Pvalues = zeros(nROI, 1);

[nSub1, nTIME, a, b] = size(BOLDresponse1);
[nSub2, nTIME, a, b] = size(BOLDresponse2);

% mean BOLD of time series
meanTIMESERIES1 = zeros(nSub1, nROI);
meanTIMESERIES2 = zeros(nSub2, nROI);

% area under curve
maxAUC1 = zeros(nSub1, nROI);
maxAUC2 = zeros(nSub2, nROI);
% AUC loc
maxAUC1st = zeros(nSub1, nROI);
maxAUC2nd = zeros(nSub2, nROI);

% peaks of time signals
maxTIMES1 = zeros(nSub1, nROI);
maxTIMES2 = zeros(nSub2, nROI);
% AUC loc
maxTIMES1id = zeros(nSub1, nROI);
maxTIMES2id = zeros(nSub2, nROI);


% calculate the pvalues
for iroi = 1:nROI,
    tempsignal1 = squeeze(mean(BOLDresponse1(:, :, stim, iroi),3));
    tempsignal2 = squeeze(mean(BOLDresponse2(:, :, stim, iroi),3));

    temptimemean1              = mean(tempsignal1(:, 21:timedur),2);
    temptimemean2              = mean(tempsignal2(:, 21:timedur),2);
    
    % mean %BOLD signals, extraction
    meanTIMESERIES1(:, iroi)   = mean(tempsignal1(:, 21:timedur),2);
    meanTIMESERIES2(:, iroi)   = mean(tempsignal2(:, 21:timedur),2);
    
    [max1, idmaxtimes1]      = max(abs(tempsignal1(:, 21:timedur)), [], 2);
    [max2, idmaxtimes2]      = max(abs(tempsignal2(:, 21:timedur)), [], 2);
    
    % AUC, extraction
    for isub1 = 1:nSub1,
        temp1                   = cumtrapz(tempsignal1(isub1, 21:timedur));
        [maxAUC1(isub1, iroi), maxAUC1st(isub1, iroi)]   = max(abs(temp1));
        maxAUC1st(isub1, iroi) = maxAUC1st(isub1, iroi) + 20;
        
        maxTIMES1(isub1, iroi)  = tempsignal1(isub1, 20 + idmaxtimes1(isub1));
        maxTIMES1id(isub1, iroi) = 20 + idmaxtimes1(isub1);
    end
    
    for isub2 = 1:nSub2,
        temp2                 = cumtrapz(tempsignal2(isub2, 21:timedur));
        [maxAUC2(isub2, iroi), maxAUC2nd(isub2, iroi)]   = max(abs(temp2));
        maxAUC2nd(isub2, iroi) = maxAUC2nd(isub2, iroi) + 20;
        
        maxTIMES2(isub2, iroi) = tempsignal2(isub2, 20 + idmaxtimes2(isub2));
        maxTIMES2id(isub2, iroi) = 20 + idmaxtimes2(isub2);
    end
    

end
