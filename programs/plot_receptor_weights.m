function plot_receptor_weights(b1, b2, b3, b4)
% plot_receptor_weights - Visualize 5-HT receptor regression weights across sessions
%
% This function creates a boxplot comparing the regression weights of 5-HT
% receptor expression and structural density for predicting BOLD responses
% across four experimental sessions (3 awake + 1 anesthesia).
%
% Syntax:
%   plot_receptor_weights(b1, b2, b3, b4)
%
% Input:
%   b1 - [7 x nSub] regression weights from Session 1 (Awake)
%   b2 - [7 x nSub] regression weights from Session 2 (Awake)
%   b3 - [7 x nSub] regression weights from Session 3 (Anesthesia)
%   b4 - [7 x nSub] regression weights from Session 4 (Awake)
%
%   Weight indices:
%     1: 5-HT1A receptor expression
%     2: 5-HT1B receptor expression
%     3: 5-HT1F receptor expression
%     4: 5-HT2A receptor expression
%     5: 5-HT2C receptor expression
%     6: Serotonergic projection density
%     7: Intercept
%
% Output:
%   Figure with boxplots showing weight distributions for each receptor/predictor
%
% Notes:
%   - Corresponds to Figure 5d in the paper
%   - Session 3 (magenta) shows reversed weights due to anesthesia effects
%   - Positive weights indicate excitatory contribution to BOLD response
%
% See also: main_corr5HTprojAndCOPE
%
% Author: Hiro Taiyo Hamada
% Reference: Hamada et al., Nat Commu 2024

    figure('Position', [100, 100, 1800, 750]);
    
    receptors = {'5ht1a', '5ht1b', '5ht1f', '5ht2a', '5ht2c', '5ht_proj', 'intercept'};
    num_receptors = length(receptors);
    
    % Define colors for each session
    color1 = [0, 1, 1];
    color2 = [0, 0.2, 0.2];
    color3 = [1, 0, 1];
    color4 = [0, 0.7, 0.7];
    
    % Create a cell array to store data for each session
    data = {b1', b2', b3', b4'};
    
    % Create a boxplot with data from all sessions
    positions = 1:num_receptors;

    DisplayNames = {'Session1:Awake', 'Session2:Awake', 'Session3:Anesthesia', 'Session4:Awake'};

    hold on;
    for i = 1:4
        h = boxplot(data{i}, 'Positions', positions + (i-2)*0.2-0.15, 'Widths', 0.15, 'Colors', eval(sprintf('color%d', i)));
        h
        set(h,'LineWidth', 4);
    end
    
    yline(0, '--', 'LineWidth', 2, 'Color', 'k');

    set(gca, 'XTick', 1:num_receptors, 'XTickLabel', receptors, 'XTickLabelRotation', 45, 'TickLabelInterpreter', 'none');
    xlabel('Receptors');
    ylabel('Weights');
    
    set(gca, 'FontSize', 36, 'LineWidth', 3);

    box_vars = findall(gca,'Tag','Box');
    hLegend = legend(box_vars([22,16,8,1]), {'Session1:Awake', 'Session2:Awake', 'Session3:Anesthesia', 'Session4:Awake'}, 'Location', 'southeast');

    box off;
end