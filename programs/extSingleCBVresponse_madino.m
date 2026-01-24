function [singleresponse] = extSingleCBVresponse_madino(timeseries)
% extSingleCBVresponse_madino - Extract stimulus-locked CBV responses from Mandino dataset
%
% This function extracts individual CBV (Cerebral Blood Volume) responses 
% aligned to each stimulation onset from the Mandino/Grandjean CBV-fMRI dataset.
% The response is baseline-corrected using 5 time points preceding stimulation.
%
% Syntax:
%   [singleresponse] = extSingleCBVresponse_madino(timeseries)
%
% Input:
%   timeseries - [nTime x nROI] matrix of CBV time series data
%                nTime: total number of time points
%                nROI: number of regions of interest
%
% Output:
%   singleresponse - [35 x 6 x nROI] array of extracted CBV responses
%                    35: time window (-5 to +29 seconds from stim onset)
%                    6: number of stimulation trials in Mandino protocol
%                    nROI: number of ROIs
%
% Notes:
%   - Mandino dataset stimulation paradigm: 6 trials at [20,50,80,110,140,170]
%   - Baseline: 5 time points before stimulation onset
%   - Different from BOLD protocol (5 trials, 20-point baseline)
%
% See also: extCBVresponse_madino, extSingleBOLDresponse
%
% Author: Hiroaki Hamada, Araya Inc.
% Date: 2019/Sep/22

[nTime, nROI] = size(timeseries);

% Initialize output: [timepoints x stimulations x ROIs]
singleresponse = zeros(35, 6, nROI);

% Stimulation onset times for Mandino/Grandjean CBV dataset
% Different protocol from main BOLD study
CBVStim = [20, 50, 80, 110, 140, 170];

for nstim = 1:6
    % Extract window: 5 points before to 29 points after stimulation onset
    temporalsignal = timeseries(CBVStim(nstim)-5:CBVStim(nstim)+29, :);
    
    % Baseline correction: subtract mean of first 5 time points (pre-stimulus)
    singleresponse(:, nstim, :) = temporalsignal - mean(temporalsignal(1:5, :));
end