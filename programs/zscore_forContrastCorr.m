function [Z, pval] = zscore_forContrastCorr(r1, r2, n1, n2)
%
%
%
%
%
%
% by Hiro Taiyo Hamada, 2020/12/17

z1 = atanh(r1);
z2 = atanh(r2);

Z = z1-z2;
Z = Z/sqrt(1/(n1-3)+1/(n2-3));

P = @(z) erfc(-z/sqrt(2))/2; 

p_two = 2*normcdf(Z);

pval = 2 - p_two;