% Made by Azaz Hassan Khan || 18jzele0262 || LAB 4
clear
close all
clc
% Initializing the variables
Fs = 1500;                % Sampling Frequency in Hz
Ts = 1/Fs;                % Sampling Period in Sec
NN = 6000;                % No. of points in the signal 
n = 0:NN-1;               % Sample index for x(n)
deg2rad = pi/180;         % Converts Degrees to Radians

%Initializing the signals
x1_n = 20*sin(2*pi*300*n*Ts + deg2rad*20);  % First term in the signal
x2_n = -5*cos(2*pi*500*n*Ts - deg2rad*30);  % Second term in the signal
x3_n = 33*cos(2*pi*35*n*Ts + deg2rad*45);   % Third term in the signal
%Summing the Signals
x_n = x1_n + x2_n + x3_n;         % Composite Signal

% Computing the FFT of the Time-Domain Signal
X_k = fft(x_n);                   % Taking Fourier Transform of the signal
k = 0:NN-1;                       % Sample Index for X(k)
% Calculating magnitude double-sided spectrum
Mag_X_k_double_sided = abs(X_k)/NN;     
% Calculating the phase of the double-sided spectrum
Phase_X_k = phase(X_k);
% Converting the sample index in to Frequency fo the Plotting purpose
Freq_double_sided = k*Fs/NN;

% Compute the single-sided spectrum from the double-sided spectrum.
Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);  
% Multiplying the single-sided components by two except the DC component
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);  
k1 = 0:(NN/2)-1;                % Sample Axis for Single-sided spectrum
 % Converting the sample index in to Frequency
freq = Fs*(0:(NN/2)-1)/NN;

% Taking inverse Fourier Transform of the signal to get  time-domain signal

x_inv = ifft(X_k);                % Inverse Fourier Transform

% Plotting the Composite Signal
figure
stem(n, x_n,'linewidth',2)        % Plotting the Signals
grid on                           %Grid on
xlabel('Samples (n)')             %x_Label of graph
ylabel('x(n)')                    %Y_Label of graph
title('Signal in Time-Domain')    %Title of the graph

% Plotting the Magnitude of Double Sided spectrum Fast Fourier Transform
figure
plot(Freq_double_sided, Mag_X_k_double_sided,'linewidth',2)
grid on                           %Grid on
xlabel('Frequency (Hz)')          %X_Label of graph
ylabel('Magnitude of X(k)')       %Y_Label of graph
title('Double-Sided Spectrum of the signal x(n)') %Title of the graph

% Plotting the Phase of  Double Sided spectrum Fast Fourier Transform
figure
plot(k, Phase_X_k,'linewidth',2)  
grid on                            %Grid on
xlabel('Samples (k)')              %X_Label of graph
ylabel('Phase of X(k)')            %Y_Label of graph

% Plotting the Magnitude of Single Sided spectrum Fast Fourier Transform
figure
plot(freq, Mag_X_k_single_sided,'linewidth',2)
grid on
title('Single-Sided Spectrum of the signal x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')

% Plotting the Inverse Fast Fourier Transform
figure
stem(n, x_inv,'linewidth',2)
grid on
xlabel('Samples (n)')
ylabel('x(n)')
title('Inverse Fast Fourier Transform')    %Title of the graph
 