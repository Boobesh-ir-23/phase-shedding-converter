%% 48V → 12V Phase Shedding — Efficiency Visualization
%  Project : Two-stage parallel NIBB | Shrimitha Energy Solutions | 2026
%  Topology: Two-phase interleaved NIBB | fsw = 50 kHz | L = 200 µH/phase
% ─────────────────────────────────────────────────────────────────────────

clc; clear; close all;

%% ─── 1. Data ──────────────────────────────────────────────────────────────
load_pct = [10,    20,    30,    40,    50,    60,    80,    100  ];

ps_sw    = [0.371, 0.658, 0.944, 1.277, 1.566, 1.893, 2.457, 3.104];
ps_oth   = [3.526, 6.403, 9.433,12.685,15.349,19.009,25.496,32.509];
ps_eff   = [86.05, 87.06, 87.20, 87.02, 87.10, 87.08, 86.94, 86.62];

nops_sw  = [0.475, 0.783, 1.055, 1.332, 1.565, 1.893, 2.456, 3.015];
nops_oth = [4.403, 7.164, 9.957,12.878,15.377,19.009,25.516,32.433];
nops_eff = [83.18, 85.78, 86.66, 86.97, 87.07, 87.08, 86.93, 86.65];

delta = ps_eff - nops_eff;   % positive = PS wins

%% ─── 2. PCHIP smooth interpolation ───────────────────────────────────────
%  PCHIP (piecewise cubic Hermite) preserves monotonicity and avoids
%  Runge-phenomenon overshoot better than plain spline for this dataset.
x_fine      = linspace(10, 100, 800);
ps_smooth   = pchip(load_pct, ps_eff,   x_fine);
nops_smooth = pchip(load_pct, nops_eff, x_fine);

%% ─── 3. Colors ────────────────────────────────────────────────────────────
c_ps   = [0.11, 0.62, 0.46];   % teal  — with phase shedding
c_nops = [0.85, 0.35, 0.19];   % coral — without phase shedding
c_grid = [0.88, 0.88, 0.88];
c_zero = [0.40, 0.40, 0.40];

%% ─── 4. Figure layout ─────────────────────────────────────────────────────
figure('Name', '48V-12V Phase Shedding', ...
       'Position', [80, 80, 960, 700], ...
       'Color', 'w');

% ── Panel 1: Efficiency curves ─────────────────────────────────────────────
ax1 = subplot(2, 1, 1);
hold on;

% Smooth curves
h1 = plot(x_fine, ps_smooth,   '-',  'Color', c_ps,   'LineWidth', 2.8);
h2 = plot(x_fine, nops_smooth, '--', 'Color', c_nops, 'LineWidth', 2.8);

% Raw-data markers (excluded from legend via HandleVisibility)
plot(load_pct, ps_eff, 'o', ...
     'Color', c_ps,   'MarkerFaceColor', c_ps,   'MarkerSize', 7, ...
     'HandleVisibility', 'off');
plot(load_pct, nops_eff, '^', ...
     'Color', c_nops, 'MarkerFaceColor', c_nops, 'MarkerSize', 7, ...
     'HandleVisibility', 'off');

% Annotate PS efficiency peak
[pk_val, pk_i] = max(ps_eff);
text(load_pct(pk_i), pk_val + 0.15, ...
     sprintf('Peak  %.2f%%', pk_val), ...
     'FontSize', 9, 'Color', c_ps, 'FontWeight', 'bold', ...
     'HorizontalAlignment', 'center');

% Annotate 10% load gap (largest PS benefit)
gap10 = delta(1);
text(13, 84.65, sprintf('\\Delta_{10\\%%} = %.2f pp', gap10), ...
     'FontSize', 9, 'Color', [0.3, 0.3, 0.3], ...
     'HorizontalAlignment', 'left');

% Crossover guideline at 60% load
xline(60, 'Color', [0.55, 0.55, 0.55], 'LineStyle', ':', 'LineWidth', 1.4, ...
      'HandleVisibility', 'off');
text(61, 82.65, 'Crossover  \approx60% load', ...
     'FontSize', 8.5, 'Color', [0.45, 0.45, 0.45]);

hold off;

legend([h1, h2], {'With phase shedding', 'Without phase shedding'}, ...
       'Location', 'southwest', 'FontSize', 10.5, 'Box', 'off');
xlabel('Load  (%)',          'FontSize', 11);
ylabel('Efficiency  \eta (%)', 'FontSize', 11);
title('48V \rightarrow 12V: Efficiency vs Load', 'FontSize', 13, 'FontWeight', 'bold');

grid on;
ax1.GridColor = c_grid;  ax1.GridAlpha = 1;
ax1.Box       = 'off';   ax1.LineWidth = 0.8;
ax1.XLim      = [5,  105];
ax1.YLim      = [82.2, 87.9];
ax1.XTick     = load_pct;

% ── Panel 2: Efficiency gain bars ──────────────────────────────────────────
ax2 = subplot(2, 1, 2);
hold on;

% Assign per-bar colors: teal if PS wins or ties, coral if No-PS wins
bar_clrs = zeros(numel(delta), 3);
for k = 1:numel(delta)
    if delta(k) >= -0.01       % >= -0.01 treats true-zero at 60% as PS tie
        bar_clrs(k,:) = c_ps;
    else
        bar_clrs(k,:) = c_nops;
    end
end

b        = bar(load_pct, delta, 0.55, 'FaceColor', 'flat', 'EdgeColor', 'none');
b.CData  = bar_clrs;

% Zero reference line
plot([5, 105], [0, 0], '-', 'Color', c_zero, 'LineWidth', 1.2, ...
     'HandleVisibility', 'off');

% Value labels on bars
for k = 1:numel(delta)
    v    = delta(k);
    yoff = 0.08;
    if v < 0; yoff = -0.14; end
    text(load_pct(k), v + yoff, sprintf('%+.2f', v), ...
         'HorizontalAlignment', 'center', 'FontSize', 8.5, ...
         'FontWeight', 'bold', 'Color', [0.15, 0.15, 0.15]);
end
hold off;

xlabel('Load  (%)',   'FontSize', 11);
ylabel('Gain  (pp)',  'FontSize', 11);
title('Phase shedding efficiency gain  (PS \minus No-PS,  percentage points)', ...
      'FontSize', 11, 'FontWeight', 'normal');

grid on;
ax2.GridColor = c_grid;  ax2.GridAlpha = 1;
ax2.Box       = 'off';   ax2.LineWidth = 0.8;
ax2.XLim      = [5,  105];
ax2.XTick     = load_pct;

% ── Shared figure title ────────────────────────────────────────────────────
sgtitle('48V \rightarrow 12V Conversion — Phase Shedding Efficiency Analysis', ...
        'FontSize', 14, 'FontWeight', 'bold');

% ── Optional: export as high-res PNG ──────────────────────────────────────
%  set(gcf, 'Renderer', 'painters');
%  exportgraphics(gcf, '48v_12v_phase_shedding.png', 'Resolution', 300);