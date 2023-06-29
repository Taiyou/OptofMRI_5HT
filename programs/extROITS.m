function [subtimeseries] = extROITS(targetpath, StimType, GroupType)
% This program is intended to extract ROI time series from .mat
%
% input:
%   targetpath:
%   StimType:
%   GroupType:
%
% output:
%   subtimeseries: 
%
% By Hiroaki Hamada, Araya, 2019/08/29th,

temporalSub = load(targetpath);

if strcmp(GroupType, 'tph'),
    if strcmp(StimType, 'blue'),
        subtimeseries = temporalSub.timeseries{2};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    else,
        subtimeseries = temporalSub.timeseries{1};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    end
else
    if strcmp(StimType, 'blue'),
        subtimeseries = temporalSub.timeseries2{2};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    else,
        subtimeseries = temporalSub.timeseries2{1};
        subtimeseries = normOPTOtimeseries(subtimeseries);
    end
end