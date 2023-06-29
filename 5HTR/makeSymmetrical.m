function [] = makeSymmetrical(filepath, filename)
% This program is intended to transform asymmetrical image to symmetrical image.
%
% input:
% 	filename: .nii
% output:
% 	filename: (.nii)
%
% by Hiroaki Hamada, oist, 2019/April/22th

marix = load_untouch_nii();
%size(A.img)

division = 29;

for ii = 30:58
	% if ii = 28, then 1, 28-1=27
	% if ii = 29, then 2, 29-2=27
	% if ii = 58, then 29, 
	position = ii-division; 
	matrix.img(:,:,ii) = matrix.img(:,:,division-position+1);
end

save_untouch_nii(matrix,filename)