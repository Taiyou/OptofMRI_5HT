function boxplot_example(htR, err)
    figure('Position', [100,500,1500,600]);

    colors = {'cyan', [0, 0.2, 0.2], 'magenta', [0, 0.7, 0.7]};
    boxplot(htR, 'Colors', colors, 'Symbol', 'k+', 'Widths', 0.8);

    hold on;
    
    xpos = 1:size(htR,2);
    for k = 1:size(htR,2)
        if k == 1
            color = [0, 1, 1];
        elseif k == 2
            color = [0, 0.2, 0.2];
        elseif k == 3
            color = [1, 0, 1];
        else
            color = [0, 0.7, 0.7];
        end
        errorbar(xpos(k), mean(htR(:,k)), err(:,k), 'LineStyle', 'none', 'Color', color, 'LineWidth', 1);
    end

    xticklabels({'5ht1a','5ht1b','5ht1f', '5ht2a', '5ht2c', '5ht\_proj', 'intercept'});
    xtickangle(40);

    set(gca, 'FontSize', 36, 'LineWidth', 2);
    legend('Session1:Awake','Session2:Awake', 'Session3:Anesthesia', 'Session4:Awake');
    box off;
    
    ylim([-2.5,2]);
    ylabel('weights');
end