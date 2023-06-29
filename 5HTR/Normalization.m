B = load_untouch_nii('NormalizedHTR2a.nii');
matrix = B.img;
IND = find(matrix~=0);

matrix(IND) = matrix(IND)-min(matrix(IND));
matrix(IND) = (matrix(IND) - min(matrix(IND)))/(max(matrix(IND))-min(matrix(IND)));
mean(matrix(IND))
matrix(IND) = (matrix(IND) - mean(matrix(IND)))/(max(matrix(IND))-mean(matrix(IND)));
matrix(IND) = (matrix(IND))*100;

B.img = matrix;
save_untouch_nii(B, 'revisedHTR2a.nii')