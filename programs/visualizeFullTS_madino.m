function [] = visualizeFullTS_mandino(CBVtime_aligned, ROIname, resultpath_madino, color)
% This program is intended to visualize full time series from Mandino et
% al., 2022
% 
%
%
% by Hiro Taiyo Hamada, Araya Inc.

color = [0.3, 0, 0.3];
nROI = length(ROIname);

% calculate the pvalues
for iroi = 1:nROI,
    
    % extract all stimulation trials
    tempsignal = -CBVtime_aligned(:, :, iroi);
    tempsignal = mean(tempsignal);
    tempsignal = detrend(tempsignal);
    
    %figure;
    plot(transpose(tempsignal), 'color', color, 'LineWidth', 3)
    %stdshade(tempsignal, 0.2, color);
    set(gcf,'Position',[100 100 2000 400]);
    set(gca, 'FontSize', 28, 'LineWidth', 5);
    xlabel('Time(seconds)'); ylabel('ΔCBV');
    box off;
    
    xticks([0 20 30 50 60 80 90 110 120 140 150 170 180]);
    xticklabels({'-40', '0', '20', '60', '80','120','140','180','200','240','260','300','320'})
    
    figurename = fullfile(resultpath_madino, strcat(ROIname{iroi},'_TS_','.png'));
    saveas(gca, figurename);
end