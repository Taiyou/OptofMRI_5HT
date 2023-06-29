function [normalized] = normBOlDtimeseries(subttimeseries)
% This program is intended to 
%
% input:
%   subtimeseries:
%
% output:
%   normalized: 
%
% by Hiroaki Hamada, Araya Inc., 2019/08/29th

subttimeseries = (subttimeseries-mean(subttimeseries))./mean(subttimeseries);
normalized = detrend(subttimeseries);