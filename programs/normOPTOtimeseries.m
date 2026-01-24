function [normalized] = normOPTOtimeseries(subttimeseries)
% normOPTOtimeseries - Normalize and detrend optogenetic fMRI time series
%
% This function performs percent signal change normalization and linear
% detrending on fMRI time series data. This preprocessing step is essential
% for comparing BOLD responses across different subjects and sessions.
%
% Syntax:
%   [normalized] = normOPTOtimeseries(subttimeseries)
%
% Input:
%   subttimeseries - [nTime x nROI] matrix of raw fMRI time series
%                    nTime: number of time points
%                    nROI: number of regions of interest
%
% Output:
%   normalized - [nTime x nROI] matrix of normalized and detrended time series
%                Values represent percent signal change from mean
%
% Processing steps:
%   1. Percent signal change: (signal - mean) / mean
%      This converts raw signal to fractional change from baseline
%   2. Linear detrending: removes linear drift using MATLAB's detrend()
%      This corrects for scanner drift and physiological trends
%
% Notes:
%   - Output values are typically in range [-0.05, 0.05] (i.e., ±5%)
%   - Multiply by 100 to get %BOLD signal change
%
% See also: extROITS, extGroupTSROI, detrend
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/08/29

% Step 1: Percent signal change normalization
% Convert to fractional change from temporal mean
subttimeseries = (subttimeseries - mean(subttimeseries)) ./ mean(subttimeseries);

% Step 2: Remove linear trend (scanner drift correction)
normalized = detrend(subttimeseries);