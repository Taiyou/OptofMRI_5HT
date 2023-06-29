function [BOLDresponse] = extBOLDresponse(timeseries)
% This program is intended to extract bold response from timeseries
% 
% input:
%   timeseries:
%
% output:
%   BOLDresponse:
%
% by Hiroaki taiyo Hamada, Araya Inc., 2019/Sep/22th

% nSub, nTIm, nROI
[nSub, nTime, nROI] = size(timeseries);
nTime2 = 120;

BOLDresponse = zeros(nSub,nTime2,5,nROI);

for nsub = 1:nSub,
    tempsignal = squeeze(timeseries(nsub,:,:));
    BOLDresponse(nsub,:,:,:) = extSingleBOLDresponse(tempsignal);
end