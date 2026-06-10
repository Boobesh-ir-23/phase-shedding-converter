%% =========================================================
%  TOPOLOGY EFFICIENCY COMPARISON — SHRIMITHA ENERGY SOLUTIONS
%  Two-Stage Parallel Non-Inverting DC-DC Converter
%  TOPOLOGY 1 : Shared Buck  + Two-Phase Boost
%  TOPOLOGY 2 : Shared Boost + Two-Phase Buck
%
%  Plots : Load (%) vs Efficiency (%) for
%          Figure 1 — 24V → 48V  (Boost Mode)
%          Figure 2 — 48V → 24V  (Buck Mode)
%          Figure 3 — 48V → 12V  (Buck Mode)
% =========================================================
clc; clear; close all;

%% ---------- COMMON X-AXIS ----------
load_pct = [100, 80, 60, 50, 40, 30, 20, 10];   % Load percentage (%)

% =========================================================
%  FIGURE 1 :  24V → 48V  (Boost Mode)
% =========================================================

% Topology 1 — Boost WITHOUT phase shedding
T1_boost_noPS = [92.73, 93.31, 93.68, 93.76, 93.67, 93.27, 92.53, 90.49];

% Topology 1 — Boost WITH phase shedding
T1_boost_PS   = [92.68, 93.25, 93.67, 94.22, 94.36, 94.36, 93.76, 93.08];

% Topology 2 — Boost (single converter, phase shedding not applicable)
T2_boost      = [93.50, 94.16, 94.79, 95.08, 95.15, 95.08, 94.60, 93.05];

figure(1);
set(gcf, 'Name', '24V to 48V Boost Mode Comparison', ...
         'NumberTitle', 'off', 'Position', [100 500 780 500]);

plot(load_pct, T1_boost_noPS, 'b-o', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'b', 'MarkerSize', 7); hold on;

plot(load_pct, T1_boost_PS,   'b--s', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'w',  'MarkerSize', 7);

plot(load_pct, T2_boost,      'r-^', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'r',  'MarkerSize', 7);

hold off;
set(gca, 'XDir', 'reverse');          % 100 % on left → 10 % on right
xlim([10 100]);  ylim([89 97]);
xticks(fliplr(load_pct));             % ascending required even with XDir reverse
grid on;  box on;

xlabel('Load (%)',           'FontSize', 12, 'FontWeight', 'bold');
ylabel('Efficiency (%)',     'FontSize', 12, 'FontWeight', 'bold');
title('24V \rightarrow 48V  —  Boost Mode Efficiency Comparison', ...
      'FontSize', 13, 'FontWeight', 'bold');

legend('Topology 1 — No Phase Shedding', ...
       'Topology 1 — With Phase Shedding', ...
       'Topology 2 — (Phase Shedding N/A)', ...
       'Location', 'southwest', 'FontSize', 10);

annotation_str = {'Phase shedding in T1 improves'; ...
                  'efficiency at light loads (≤50%)'};
annotation('textbox', [0.13 0.14 0.28 0.10], 'String', annotation_str, ...
           'FontSize', 8.5, 'EdgeColor', [0.4 0.4 0.4], ...
           'BackgroundColor', [1 1 0.85], 'FitBoxToText', 'on');


% =========================================================
%  FIGURE 2 :  48V → 24V  (Buck Mode)
% =========================================================

% Topology 1 — Buck (phase shedding not possible — single stage)
T1_buck24_noPS = [93.77, 94.05, 94.40, 94.56, 94.60, 95.70, 95.85, 97.24];

% Topology 2 — Buck WITHOUT phase shedding
T2_buck24_noPS = [93.09, 93.07, 92.90, 92.68, 92.32, 91.60, 90.03, 90.49];

% Topology 2 — Buck WITH phase shedding
T2_buck24_PS   = [93.65, 94.69, 93.04, 93.35, 93.27, 93.01, 92.33, 91.8];

figure(2);
set(gcf, 'Name', '48V to 24V Buck Mode Comparison', ...
         'NumberTitle', 'off', 'Position', [200 450 780 500]);

plot(load_pct, T1_buck24_noPS, 'b-o', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'b', 'MarkerSize', 7); hold on;

plot(load_pct, T2_buck24_noPS, 'r-s', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'r', 'MarkerSize', 7);

plot(load_pct, T2_buck24_PS,   'r--^', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'w',   'MarkerSize', 7);

hold off;
set(gca, 'XDir', 'reverse');
xlim([10 100]);  ylim([88 99]);
xticks(fliplr(load_pct));
grid on;  box on;

xlabel('Load (%)',        'FontSize', 12, 'FontWeight', 'bold');
ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
title('48V \rightarrow 24V  —  Buck Mode Efficiency Comparison', ...
      'FontSize', 13, 'FontWeight', 'bold');

legend('Topology 1 — (Phase Shedding N/A)', ...
       'Topology 2 — No Phase Shedding', ...
       'Topology 2 — With Phase Shedding', ...
       'Location', 'northwest', 'FontSize', 10);

annotation_str2 = {'T1 efficiency rises at light load'; ...
                   'due to shared-buck voltage regulation'};
annotation('textbox', [0.55 0.14 0.30 0.10], 'String', annotation_str2, ...
           'FontSize', 8.5, 'EdgeColor', [0.4 0.4 0.4], ...
           'BackgroundColor', [0.88 1 0.88], 'FitBoxToText', 'on');


% =========================================================
%  FIGURE 3 :  48V → 12V  (Buck Mode)
% =========================================================

% Topology 1 — Buck (phase shedding not possible)
T1_buck12_noPS = [84.90, 85.90, 86.60, 86.90, 87.20, 87.40, 87.40, 87.90];

% Topology 2 — Buck WITHOUT phase shedding
T2_buck12_noPS = [85.30, 85.90, 86.40, 86.50, 86.60, 86.40, 85.88, 83.43];

% Topology 2 — Buck WITH phase shedding
T2_buck12_PS   = [86.80, 87.30, 87.60, 86.69, 86.99, 87.146, 87.08, 85.99];

figure(3);
set(gcf, 'Name', '48V to 12V Buck Mode Comparison', ...
         'NumberTitle', 'off', 'Position', [300 400 780 500]);

plot(load_pct, T1_buck12_noPS, 'b-o', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'b', 'MarkerSize', 7); hold on;

plot(load_pct, T2_buck12_noPS, 'r-s', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'r', 'MarkerSize', 7);

plot(load_pct, T2_buck12_PS,   'r--^', 'LineWidth', 1.8, ...
     'MarkerFaceColor', 'w',   'MarkerSize', 7);

hold off;
set(gca, 'XDir', 'reverse');
xlim([10 100]);  ylim([82 90]);
xticks(fliplr(load_pct));
grid on;  box on;

xlabel('Load (%)',        'FontSize', 12, 'FontWeight', 'bold');
ylabel('Efficiency (%)', 'FontSize', 12, 'FontWeight', 'bold');
title('48V \rightarrow 12V  —  Buck Mode Efficiency Comparison', ...
      'FontSize', 13, 'FontWeight', 'bold');

legend('Topology 1 — (Phase Shedding N/A)', ...
       'Topology 2 — No Phase Shedding', ...
       'Topology 2 — With Phase Shedding', ...
       'Location', 'southwest', 'FontSize', 10);

annotation_str3 = {'T2 + Phase Shedding gives best'; ...
                   'efficiency across mid-to-full load'};
annotation('textbox', [0.13 0.72 0.30 0.10], 'String', annotation_str3, ...
           'FontSize', 8.5, 'EdgeColor', [0.4 0.4 0.4], ...
           'BackgroundColor', [1 0.93 0.85], 'FitBoxToText', 'on');


% =========================================================
%  OPTIONAL: Print peak efficiency summary to command window
% =========================================================
fprintf('\n========== PEAK EFFICIENCY SUMMARY ==========\n');
fprintf('\n--- 24V → 48V (Boost) ---\n');
fprintf('  T1 No PS   : %.2f%%  at %d%% load\n', max(T1_boost_noPS), load_pct(T1_boost_noPS == max(T1_boost_noPS)));
fprintf('  T1 With PS : %.2f%%  at %d%% load\n', max(T1_boost_PS),   load_pct(T1_boost_PS   == max(T1_boost_PS)));
fprintf('  T2 (no PS) : %.2f%%  at %d%% load\n', max(T2_boost),      load_pct(T2_boost      == max(T2_boost)));

fprintf('\n--- 48V → 24V (Buck) ---\n');
fprintf('  T1 (no PS) : %.2f%%  at %d%% load\n', max(T1_buck24_noPS), load_pct(T1_buck24_noPS == max(T1_buck24_noPS)));
fprintf('  T2 No PS   : %.2f%%  at %d%% load\n', max(T2_buck24_noPS), load_pct(T2_buck24_noPS == max(T2_buck24_noPS)));
fprintf('  T2 With PS : %.2f%%  at %d%% load\n', max(T2_buck24_PS),   load_pct(T2_buck24_PS   == max(T2_buck24_PS)));

fprintf('\n--- 48V → 12V (Buck) ---\n');
fprintf('  T1 (no PS) : %.2f%%  at %d%% load\n', max(T1_buck12_noPS), load_pct(T1_buck12_noPS == max(T1_buck12_noPS)));
fprintf('  T2 No PS   : %.2f%%  at %d%% load\n', max(T2_buck12_noPS), load_pct(T2_buck12_noPS == max(T2_buck12_noPS)));
fprintf('  T2 With PS : %.2f%%  at %d%% load\n', max(T2_buck12_PS),   load_pct(T2_buck12_PS   == max(T2_buck12_PS)));
fprintf('==============================================\n\n');