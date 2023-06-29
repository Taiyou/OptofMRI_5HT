function [singleresponse] = extSingleBOLDresponse(timeseries)
% This program is intended to calculate the single bold response
%
%
%
%
%
% by Hiroaki Hamada, Araya inc. 2019/Sep/22th

[nTime, nROI] = size(timeseries);

singleresponse = zeros(120,5,nROI);
BOLDStim = [81,201,321,441,561]

for nstim = 1:5,
	temporalsignal = timeseries(BOLDStim(nstim)-20:BOLDStim(nstim)+99,:);
    singleresponse(:, nstim, :) = temporalsignal - mean(temporalsignal(1:20,:));
end