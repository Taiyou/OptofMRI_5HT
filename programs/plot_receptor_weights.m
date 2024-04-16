function plot_receptor_weights(b1, b2, b3, b4)
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