function [Z, pval] = zscore_forContrastCorr(r1, r2, n1, n2)
% zscore_forContrastCorr - Fisher's z-test for comparing two correlation coefficients
%
% This function performs Fisher's r-to-z transformation to statistically
% compare two independent correlation coefficients. Used to test whether
% correlations between sessions are significantly different.
%
% Syntax:
%   [Z, pval] = zscore_forContrastCorr(r1, r2, n1, n2)
%
% Input:
%   r1 - First correlation coefficient (Pearson's r)
%   r2 - Second correlation coefficient (Pearson's r)
%   n1 - Sample size for first correlation
%   n2 - Sample size for second correlation
%
% Output:
%   Z    - Z-score for the difference between correlations
%   pval - Two-tailed p-value
%
% Method:
%   1. Apply Fisher's r-to-z transformation: z = atanh(r)
%   2. Calculate Z-score: Z = (z1 - z2) / sqrt(1/(n1-3) + 1/(n2-3))
%   3. Compute two-tailed p-value from normal distribution
%
% Example:
%   % Compare correlations between Session 1-2 vs Session 2-4
%   [Z, pval] = zscore_forContrastCorr(0.85, 0.72, 28, 28);
%   if pval < 0.05
%       disp('Correlations are significantly different');
%   end
%
% Reference:
%   Fisher, R.A. (1921). On the "probable error" of a coefficient of 
%   correlation deduced from a small sample. Metron, 1, 3-32.
%
% See also: corr, atanh, normcdf
%
% Author: Hiro Taiyo Hamada
% Date: 2020/12/17

z1 = atanh(r1);
z2 = atanh(r2);

Z = z1-z2;
Z = Z/sqrt(1/(n1-3)+1/(n2-3));

P = @(z) erfc(-z/sqrt(2))/2; 

p_two = 2*normcdf(Z);

pval = 2 - p_two;