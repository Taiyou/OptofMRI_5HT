function [listing] = makeList(path, header)
% makeList - Create a list of files matching a pattern in a directory
%
% This utility function generates a structure array of file paths
% matching a specified pattern. Used throughout the analysis pipeline
% to locate data files, ROI masks, and contrast maps.
%
% Syntax:
%   [listing] = makeList(path, header)
%
% Input:
%   path   - String path to directory containing target files
%            e.g., '/data/session1' or fullfile(pwd, '/ROIs')
%
%   header - Wildcard pattern for filename matching
%            e.g., '*TPH*' for transgenic subjects
%            e.g., 'ID*.nii' for ROI masks
%            e.g., '*.mat' for all .mat files
%
% Output:
%   listing - Structure array with fields:
%             .name - Full path to each matching file
%             .date, .bytes, .isdir, etc. (from dir())
%
% Examples:
%   % List all TPH subject files
%   listing_tph = makeList('/data/session1', '*TPH*');
%
%   % List all ROI mask files
%   ROIlist = makeList('/ROIs', 'ID*.nii');
%
%   % List all .mat files in current directory
%   matfiles = makeList(pwd, '*.mat');
%
% Notes:
%   - Returns full paths (path + filename) in .name field
%   - Uses MATLAB's dir() function internally
%
% See also: dir, fullfile, ExtROIname
%
% Author: Hiroaki Hamada
% Date: 2015/Nov/06

% make a list of files in a folder
listing = dir(fullfile(path, header));

% count the number of folders
dim = size(listing);

for i = 1:dim(1)
	listing(i).name = strcat(path, '/', listing(i).name);
end

end