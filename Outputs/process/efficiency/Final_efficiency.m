%% =========================================================
%  Topology 2 — Efficiency & Regulation Analysis
%  Plots 1, 2, 3 | Phase Shedding vs No Phase Shedding
%  Conversions: 48V→12V and 48V→24V
% =========================================================

clear; clc; close all;

%% ---------------------------------------------------------
%  RAW DATA  (ascending load order: 10% → 100%)
% ---------------------------------------------------------

load_pct = [10, 20, 30, 40, 50, 60, 80, 100];

% ---- 48V → 12V | With Phase Shedding ----
Pin_12_PS  = [27.92,  54.58,  81.03, 107.2,  135.4, 161.6, 213.8, 265.4];
Pout_12_PS = [24.03,  47.053, 70.66, 93.29,  118.1, 140.9, 186,   230  ];

% ---- 48V → 12V | Without Phase Shedding ----
Pin_12_NPS  = [28.91, 55.73, 82.42, 108.9, 135.4, 161.6, 213.8, 265.5];
Pout_12_NPS = [24.13, 48,    71.76, 94.92, 118,   140.9, 186,   230.2 ];

% ---- 48V → 24V | With Phase Shedding ----
Pin_24_PS  = [22.18, 43.08, 63.91, 85.83, 107.4, 127.8, 169.2, 210.6];
Pout_24_PS = [19.97, 39.8,  59.47, 80.1,  99.33, 118.9, 157.9, 196.6];
Vout_24_PS = [23.98, 23.94, 23.89, 23.85, 23.89, 23.89, 23.84, 23.8 ];

% ---- 48V → 24V | Without Phase Shedding ----
Pin_24_NPS  = [28.26, 44.33, 65.25, 87.3,  107,   127.8, 169.2, 210.6];
Pout_24_NPS = [25.14, 39.92, 59.77, 80.65, 99.24, 118.9, 157.9, 196.7];
Vout_24_NPS = [26.91, 23.98, 23.95, 23.93, 23.91, 23.88, 23.84, 23.8 ];

%% ---------------------------------------------------------
%  CALCULATE EFFICIENCY
% ---------------------------------------------------------

eta_12_PS  = (Pout_12_PS  ./ Pin_12_PS)  * 100;
eta_12_NPS = (Pout_12_NPS ./ Pin_12_NPS) * 100;
eta_24_PS  = (Pout_24_PS  ./ Pin_24_PS)  * 100;
eta_24_NPS = (Pout_24_NPS ./ Pin_24_NPS) * 100;

% ---- Color scheme ----
c_ps  = [0.000, 0.447, 0.741];
c_nps = [0.850, 0.325, 0.098];

%% =========================================================
%  PLOT 1 — Efficiency vs Load% | 48V → 12V
% =========================================================

figure(1);
set(gcf, 'Position', [80, 500, 720, 460]);

plot(load_pct, eta_12_PS, '-o', ...
    'Color', c_ps,  'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_ps, ...
    'DisplayName', 'With Phase Shedding');
hold on;
plot(load_pct, eta_12_NPS, '-s', ...
    'Color', c_nps, 'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_nps, ...
    'DisplayName', 'Without Phase Shedding');

% --- Data labels ---
for i = 1:length(load_pct)
    text(load_pct(i), eta_12_PS(i) + 0.22, ...
        sprintf('%.2f', eta_12_PS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_ps, 'FontWeight', 'bold');
    text(load_pct(i), eta_12_NPS(i) - 0.28, ...
        sprintf('%.2f', eta_12_NPS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_nps, 'FontWeight', 'bold');
end
hold off;

xlabel('Load (%)',       'FontSize', 12, 'FontWeight', 'bold');
ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
title('Efficiency vs Load  —  48V \rightarrow 12V  |  Topology 2', ...
    'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'southwest', 'FontSize', 11);
xlim([5 105]);
ylim([82 89]);
set(gca, 'XTick', [10 20 30 40 50 60 80 100], 'FontSize', 11);
grid on;
box on;

%% =========================================================
%  PLOT 2 — Efficiency vs Load% | 48V → 24V
% =========================================================

figure(2);
set(gcf, 'Position', [820, 500, 720, 460]);

plot(load_pct, eta_24_PS, '-o', ...
    'Color', c_ps,  'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_ps, ...
    'DisplayName', 'With Phase Shedding');
hold on;
plot(load_pct, eta_24_NPS, '-s', ...
    'Color', c_nps, 'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_nps, ...
    'DisplayName', 'Without Phase Shedding');

% --- Data labels ---
for i = 1:length(load_pct)
    text(load_pct(i), eta_24_PS(i) + 0.22, ...
        sprintf('%.2f', eta_24_PS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_ps, 'FontWeight', 'bold');
    text(load_pct(i), eta_24_NPS(i) - 0.28, ...
        sprintf('%.2f', eta_24_NPS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_nps, 'FontWeight', 'bold');
end
hold off;

xlabel('Load (%)',       'FontSize', 12, 'FontWeight', 'bold');
ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
title('Efficiency vs Load  —  48V \rightarrow 24V  |  Topology 2', ...
    'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'southwest', 'FontSize', 11);
xlim([5 105]);
ylim([87 95]);
set(gca, 'XTick', [10 20 30 40 50 60 80 100], 'FontSize', 11);
grid on;
box on;

% 12V output voltage data (ascending: 10% to 100%)
Vout_12_PS  = [11.76, 11.7,  11.65, 11.59, 11.68, 11.64, 11.58, 11.52];
Vout_12_NPS = [11.82, 11.81, 11.76, 11.71, 11.68, 11.64, 11.58, 11.52];

%% =========================================================
%  PLOT 3 — Output Voltage Regulation | 48V → 24V
% =========================================================

figure(3);
set(gcf, 'Position', [80, 30, 720, 460]);

plot(load_pct, Vout_24_PS, '-o', ...
    'Color', c_ps,  'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_ps, ...
    'DisplayName', 'With Phase Shedding');
hold on;
plot(load_pct, Vout_24_NPS, '-s', ...
    'Color', c_nps, 'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_nps, ...
    'DisplayName', 'Without Phase Shedding');

yline(24, '--k', 'Target: 24 V', ...
    'FontSize', 10, 'LineWidth', 1.5, ...
    'LabelHorizontalAlignment', 'right', ...
    'LabelVerticalAlignment', 'bottom', ...
    'HandleVisibility', 'off');

% Data labels — PS below, NPS above; skip NPS where identical to PS
for i = 1:length(load_pct)
    text(load_pct(i), Vout_24_PS(i) - 0.12, ...
        sprintf('%.2f', Vout_24_PS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_ps, 'FontWeight', 'bold');
    if abs(Vout_24_NPS(i) - Vout_24_PS(i)) > 0.01
        text(load_pct(i), Vout_24_NPS(i) + 0.12, ...
            sprintf('%.2f', Vout_24_NPS(i)), ...
            'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
            'Color', c_nps, 'FontWeight', 'bold');
    end
end
hold off;

xlabel('Load (%)',                       'FontSize', 12, 'FontWeight', 'bold');
ylabel('Output Voltage  V_{out}  (V)',   'FontSize', 12, 'FontWeight', 'bold');
title('Output Voltage Regulation vs Load  —  48V \rightarrow 24V  |  Topology 2', ...
    'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
xlim([5 105]);
ylim([23.5 27.5]);
set(gca, 'XTick', [10 20 30 40 50 60 80 100], ...
         'YTick', [23.5, 24, 24.5, 25, 25.5, 26, 26.5, 27, 27.5], ...
         'FontSize', 11);
grid on;
box on;

%% =========================================================
%  PLOT 4 — Output Voltage Regulation | 48V → 12V
% =========================================================

figure(4);
set(gcf, 'Position', [820, 30, 720, 460]);

plot(load_pct, Vout_12_PS, '-o', ...
    'Color', c_ps,  'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_ps, ...
    'DisplayName', 'With Phase Shedding');
hold on;
plot(load_pct, Vout_12_NPS, '-s', ...
    'Color', c_nps, 'LineWidth', 1.8, ...
    'MarkerSize', 7, 'MarkerFaceColor', c_nps, ...
    'DisplayName', 'Without Phase Shedding');

yline(12, '--k', 'Target: 12 V', ...
    'FontSize', 10, 'LineWidth', 1.5, ...
    'LabelHorizontalAlignment', 'right', ...
    'LabelVerticalAlignment', 'top', ...
    'HandleVisibility', 'off');

% Data labels — PS below, NPS above; skip NPS where identical to PS
for i = 1:length(load_pct)
    text(load_pct(i), Vout_12_PS(i) - 0.04, ...
        sprintf('%.2f', Vout_12_PS(i)), ...
        'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
        'Color', c_ps, 'FontWeight', 'bold');
    if abs(Vout_12_NPS(i) - Vout_12_PS(i)) > 0.01
        text(load_pct(i), Vout_12_NPS(i) + 0.04, ...
            sprintf('%.2f', Vout_12_NPS(i)), ...
            'FontSize', 7.5, 'HorizontalAlignment', 'center', ...
            'Color', c_nps, 'FontWeight', 'bold');
    end
end
hold off;

xlabel('Load (%)',                       'FontSize', 12, 'FontWeight', 'bold');
ylabel('Output Voltage  V_{out}  (V)',   'FontSize', 12, 'FontWeight', 'bold');
title('Output Voltage Regulation vs Load  —  48V \rightarrow 12V  |  Topology 2', ...
    'FontSize', 12, 'FontWeight', 'bold');
legend('Location', 'northeast', 'FontSize', 11);
xlim([5 105]);
ylim([11.3 12.2]);
set(gca, 'XTick', [10 20 30 40 50 60 80 100], ...
         'YTick', [11.3, 11.4, 11.5, 11.6, 11.7, 11.8, 11.9, 12.0, 12.1, 12.2], ...
         'FontSize', 11);
grid on;
box on;

%% ---------------------------------------------------------
%  OPTIONAL: Save figures as PNG (uncomment to use)
% ---------------------------------------------------------
% exportgraphics(figure(1), 'Plot1_Eff_12V.png',  'Resolution', 300);
% exportgraphics(figure(2), 'Plot2_Eff_24V.png',  'Resolution', 300);
% exportgraphics(figure(3), 'Plot3_Reg_24V.png',  'Resolution', 300);
% exportgraphics(figure(4), 'Plot4_Reg_12V.png',  'Resolution', 300);