load_percentage = [10, 20, 30, 40, 50, 60, 80, 100];
eff_without = [90.49, 92.53, 93.27, 93.67, 93.76, 93.68, 93.31, 92.73];
eff_with = [93.08, 93.76, 94.36, 94.36, 94.22, 93.67, 93.25, 92.68];

figure('Name', 'Phase Shedding Efficiency Comparison', 'Color', 'w');

plot(load_percentage, eff_without, '-o', 'LineWidth', 2, 'MarkerSize', 7, 'Color', [0.8500 0.3250 0.0980]);
hold on;
plot(load_percentage, eff_with, '-s', 'LineWidth', 2, 'MarkerSize', 7, 'Color', [0 0.4470 0.7410]);

xline(50, '--k', 'Phase Shedding Threshold(50% of the Load)', 'LabelVerticalAlignment', 'bottom', ...
      'LabelHorizontalAlignment', 'left', 'LineWidth', 1.5, 'FontSize', 11);

title('Phase Shedding vs Without Phase Shedding (2 Phase NIBB Converter)', 'FontSize', 12);
xlabel('Load Demand (%)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Converter Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');

legend('Without Shedding (Fixed 2-Phase)', 'With Shedding (Adaptive)', ...
       'Location', 'southeast', 'FontSize', 11);

xlim([10 100]);
ylim([90 95]);
xticks(10:10:100);

grid on;
hold off;