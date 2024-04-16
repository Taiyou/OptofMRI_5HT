function [listing] = makeList(path, header)
% makeLists for a folder
% This program is intended to do make a list of path
%
% usage: listing = makeList(path);
% path: path to the directory which has data sets
% header: header of file names
% eg. listing = makeList(pwd, '*');
%
% by Hiroaki Hamada, 2015/Nov/06

% make a list of files in a folder
listing = dir(fullfile(path, header));

% count the number of folders
dim = size(listing);

for i = 1:dim(1)
	listing(i).name = strcat(path, '/', listing(i).name);
end

end