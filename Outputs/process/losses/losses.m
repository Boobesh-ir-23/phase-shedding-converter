%% nibb_loss_from_simlog.m
%  Run your Simulink model first, then run this script.
%  Switching losses  = 0.5*Voff*Isw*(ton+toff)*fsw  [IRFP460, per MOSFET]
%  All other losses  = Pin - Pout - Psw_total        [from energy balance]
%  eta               = Pout / Pin
% -------------------------------------------------------------------------
clc;
fsw  = 50e3;   % switching frequency [Hz]
t_ss = 8e-3;   % steady-state start  [s]

%% ---- IRFP460 switching parameters -------------------------------------
ton  = 59e-9;  % rise time  [s]
toff = 58e-9;  % fall time  [s]

%% ---- Steady-state mask -------------------------------------------------
w = tout > (max(tout) - 1e-3);
%% ---- Pin and Pout ------------------------------------------------------
Pin  = 48 * mean(Iin_meas(w));    % 48V ideal source: P = V * mean(I)
Pout = mean(Pout_meas(w));        % output Power Measurement block

%% ---- Switching loss per MOSFET ----------------------------------------
mosfets = {'S1', S1_i, S1_v
            'S2', S2_i, S2_v
            'S3', S3_i, S3_v};

N   = size(mosfets, 1);
Psw = zeros(N, 1);

for k = 1:N
    iw      = mosfets{k,2}(w);
    vw      = mosfets{k,3}(w);
    Isw     = prctile(iw, 99);
    Voff    = prctile(vw, 99);
    Psw(k)  = 0.5 * Voff * Isw * (ton + toff) * fsw;
end

Psw_total = sum(Psw);

%% ---- Other losses from energy balance ----------------------------------
P_other = Pin - Pout - Psw_total;

%% ---- Efficiency --------------------------------------------------------
eta = 100 * Pout / Pin;

%% ---- Report ------------------------------------------------------------
fprintf('--- Switching Losses ---\n');
for k = 1:N
    fprintf('  %-4s  %.4f W\n', mosfets{k,1}, Psw(k));
end
fprintf('\n--- Summary ---\n');
fprintf('Pin                              = %.3f W\n', Pin);
fprintf('Pout                             = %.3f W\n', Pout);
fprintf('Switching losses (MOSFETs)       = %.3f W\n', Psw_total);
fprintf('Other losses (cond+mag+ESR)      = %.3f W\n', P_other);
fprintf('Total losses                     = %.3f W\n', Psw_total + P_other);
fprintf('eta (Pout/Pin)                   = %.2f %%\n', eta);