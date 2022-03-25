% Azaz Hassan Khan
% Task_5
close all
clear all
clc
% Bilinear Transformation
Fs=500e3;
Ts = 1/Fs;
s = tf('s'); % Defining the Laplace parameter "s"
H_S = 0.005/((0.0001592*s)+1) 
z = tf('z',Ts); % Defining "z" for Digital Filter at sampling time Ts
ZZ = ((2/Ts)*(z-1))/(z+1);   %% Bilinear Transform 
H_Z = 0.005/((0.0001592*ZZ)+1)
figure
bode(H_Z,'--r') % Bode Plot for Discrete Filter