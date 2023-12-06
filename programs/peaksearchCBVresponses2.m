function [maxTIMES1,  maxTIMES1id,maxAUC1, maxAUC1st] = peaksearchCBVresponses2(CBVresponse1, ROIname, timedur, stim)
% This program is intended to search location peak of the CBV signal.
% 
% input:
%   CBVresponse1
%   CBVresponse2
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

[nSub1, nTIME, a, b] = size(CBVresponse1);

% mean CBV of time series
meanTIMESERIES1 = zeros(nSub1, nROI);

% area under curve
maxAUC1 = zeros(nSub1, nROI);

% AUC loc
maxAUC1st = zeros(nSub1, nROI);


% peaks of time signals
maxTIMES1 = zeros(nSub1, nROI);

% AUC loc
maxTIMES1id = zeros(nSub1, nROI);


% calculate the pvalues
for iroi = 1:nROI,
    tempsignal1 = squeeze(mean(CBVresponse1(:, :, stim, iroi),3));

    temptimemean1              = mean(tempsignal1(:, 6:timedur),2);
    
    % mean %CBV signals, extraction
    meanTIMESERIES1(:, iroi)   = mean(tempsignal1(:, 6:timedur),2);
    [max1, idmaxtimes1]      = max(abs(tempsignal1(:, 21:timedur)), [], 2);
    
    % AUC, extraction
    for isub1 = 1:nSub1,
        temp1                   = cumtrapz(tempsignal1(isub1, 6:timedur));
        [maxAUC1(isub1, iroi), maxAUC1st(isub1, iroi)]   = max(abs(temp1));
        maxAUC1st(isub1, iroi) = maxAUC1st(isub1, iroi) + 20;
        
        maxTIMES1(isub1, iroi)  = tempsignal1(isub1, 20 + idmaxtimes1(isub1));
        maxTIMES1id(isub1, iroi) = 20 + idmaxtimes1(isub1);
    end
    

end
