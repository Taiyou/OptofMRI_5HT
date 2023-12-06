function [singleresponse] = extSingleBOLDresponse(timeseries)
% This program is intended to calculate the single bold response
%
%
%
%
%
% by Hiroaki Hamada, Araya inc. 2019/Sep/22th

[nTime, nROI] = size(timeseries);

singleresponse = zeros(35,6,nROI);
BOLDStim = [20,50,80,110,140,170]

for nstim = 1:6,
	temporalsignal = timeseries(BOLDStim(nstim)-5:BOLDStim(nstim)+29,:);
    singleresponse(:, nstim, :) = temporalsignal - mean(temporalsignal(1:5,:));
end