% Azaz Hassan Khan
% Task_4
close all
clear all
clc
RH = 995e3; % Sum of high-side resistances = 990kOhm
RL = 5e3;   % Low-side resistance = 10 kOhm=
Co = 32e-9; % Output filter Cap = 20nF
s = tf('s'); % Defining the Laplace parameter "s"
Gain = RL/(RL + RH); % DC Gain of the Filter
Rp = (RL*RH)/(RL + RH); % RL in parallel with RH
LPF = 1/(1 + s*Rp*Co); % Low-Pass Filter Transfer Function
H_S = (Gain*LPF) % LPF with Gain
figure
bode(LPF) % Bode Plot for LPF
hold on
bode(H_S,'r') % Bode Plot for LPF with Gain
grid on
legend('LPF','H(s)')