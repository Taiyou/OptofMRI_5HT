function [] = supple_weight5HT_boxplot(htR, err)
% This program is intended to visualize regression weights using boxplot.
% Figure 5d
%
% weights session1,session2,session3,session4
% 5-ht1a: [-1.0804, -0.4457, -0.6127, -0.1996]
% 5-ht1b: [-0.9963, -0.6573, -0.1008, -0.2822]
% 5-ht1f: [-0.2012, -0.3286, -1.1479, -0.1028]
% 5-ht2a: [ 0.2110, 0.5017, 0.5640, 0.1586]
% 5-ht2c: [ 0.3336, 0.1467, -0.2431, 0.1995]
% project:[ 0.8296, 0.5699, 0.5137, 0.6845]
% interce:[ 1.3113, 0.7663, 0.5814, 0.0218]
%
% Error session1,session2,session3,session4
% 5-ht1a: [0.3401, 0.4588, 0.2813, 0.2958]
% 5-ht1b: [0.5172, 0.6172, 0.6575, 0.1931]
% 5-ht1f: [0.1783, 0.5440, 1.0966, 0.2369]
% 5-ht2a: [0.3890, 0.2679, 0.3523, 0.2864]
% 5-ht2c: [0.2626, 0.3549, 0.4423, 0.1749]
% project:[0.3467, 0.2238, 0.4139, 0.2839]
% intercept:[0.5310, 0.5115, 0.4680, 0.3863]
%
% by Hiro Taiyo Hamada, 2023/June

figure('Position', [100,500,1500,600]);

colors = {[0, 1, 1], [0, 0.2, 0.2], [1, 0, 1], [0, 0.7, 0.7]};
boxplot(htR, 'Colors', colors, 'Symbol', 'k+', 'Widths', 0.8);

hold on;

for k = 1:size(htR,2)
    xpos = k;
    errorbar(xpos, mean(htR(:,k)), err(:,k), 'LineStyle', 'none', 'Color', 'k', 'LineWidth', 1);
end

xticklabels({'5ht1a','5ht1b','5ht1f', '5ht2a', '5ht2c', '5ht\_proj', 'intercept'});
xtickangle(40);

set(gca, 'FontSize', 36, 'LineWidth', 2);
legend('Session1:Awake','Session2:Awake', 'Session3:Anesthesia', 'Session4:Awake');
box off;

ylim([-2.5,2]);
ylabel('weights');
end