function [ts_motion, ts_meanstatistics, ts_stim_meanstatistics, ts_stdstatistics, ts_stim_stdstatistics] = extractTS(ts_list, ntime, stim_list, stimDur)
% This program is intended to extract time series and statistics.
%
% input:
%   ts_list: data of timeseries
%   ntime: length of time series
%   stim_list: stimulation period
%   stimDur: stimulation Duration
%
% output:
%  ts_motion, movement time series
%  ts_meanstatistics: absolute motion difference during imaging
%  ts_stim_meanstatistics: absolute motion difference during stimulation
%  ts_stdstatistics: std of motion during imaging
%  ts_stim_stdstatistics: std of motion during stimulation
%
%
% by Hiro Taiyo Hamada, Araya Inc., 

% the number of data
Ndata          = length(ts_list);
Nstim          = length(stim_list);
ts_motion      = zeros(Ndata, ntime, 6);
ts_stim_motion = zeros(Ndata, Nstim*stimDur, 6);
% standard deviation of the data

ts_meanstatistics = zeros(Ndata, 6);
ts_stim_meanstatistics = zeros(Ndata, 6);
ts_stdstatistics = zeros(Ndata, 6);
ts_stim_stdstatistics = zeros(Ndata, 6);

for ii = 1:Ndata,
    % data loading
   tempdata = load(ts_list(ii).name);
   
   % demeaning and linear trending
   scale_td = detrend(tempdata);
   
   ts_motion(ii, :, :) = scale_td;
   
   for jj = 1:Nstim,
       ts_stim_motion(ii, (jj-1)*stimDur+1:jj*stimDur, :) = ts_motion(ii, stim_list(jj):stim_list(jj)+stimDur-1, :);
   end
   
   % time series meand 
   ts_meanstatistics(ii, :)= mean(abs(diff(scale_td)));
   ts_stim_meanstatistics(ii, :) = mean(abs(diff(ts_stim_motion(ii, :, :))));
   % time series standard deviation
   ts_stdstatistics(ii, :)= std(abs(diff(scale_td)));
   ts_stim_stdstatistics(ii, :) = std(abs(diff(ts_stim_motion(ii, :, :))));
end