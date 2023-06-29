function [AllTimeSeries] = extGroupTSROI(listing, StimType, GroupType)
% This program is intended to visualize mean ROI-based time series.
%
% input:
%   listing:
%   StimType:
%   GroupType:
%
% output:
%   AllTimeSeries: nSub
%
% By Hiroaki Hamada, Araya Inc., 2019/08/29th

nSub = length(listing);
sample = load(listing(1).name);

if strcmp(GroupType, 'tph'),
    sampleTS = sample.timeseries{1};
    [nTS, nROIs] = size(sampleTS);
else,
    sampleTS = sample.timeseries2{1};
    [nTS, nROIs] = size(sampleTS);
end

% all data info
AllTimeSeries = zeros(nSub,nTS,nROIs);

% extract the ROI data from each person
for nsub = 1:nSub,
    AllTimeSeries(nsub, :, :) = extROITS(listing(nsub).name, StimType, GroupType);
end