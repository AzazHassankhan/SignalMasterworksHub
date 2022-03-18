clear 
close all
clc

%% Discrete-Time Signal + Noise

n = 1:2000;     % Samples (n)

f_signal = 50;  % Desirable Signal Frequency
f_noise = 10e3; % Noise Frequency
Fs = 50e3;      % Sampling Frequency
Ts = 1/Fs;      % Sampling Time

x_signal = 280*sqrt(2)*sin(2*pi*f_signal*Ts*n);     % Desirable Signal
x_noise = 50*sin(2*pi*f_noise*Ts*n);                % Noise Signal

x_sn = 2.5 + 0.005*(x_signal + x_noise);    % Input Signal = Desirable Signal + Noise

% Plot the input Signal
figure
plot(n,x_sn)        
grid on
xlabel('Samples (n)')
ylabel('Voltage (v)')
title('Input Signal + Noise')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)


%% Calculating FIR Filter Output  

NN = length(x_sn);  % Finding no. of samples in the input signal

y_vector = zeros(1,NN);   % Initializing the Filter Output Vector

% Initializing the variables needed for computing the Filter Output
x_n_15 = 0;
x_n_14 = 0;
x_n_13 = 0;
x_n_12 = 0;
x_n_11 = 0;
x_n_10 = 0;
x_n_9 = 0;
x_n_8 = 0;
x_n_7 = 0;
x_n_6 = 0;
x_n_5 = 0;
x_n_4 = 0;
x_n_3 = 0;
x_n_2 = 0;
x_n_1 = 0;

% Calculating the Filter Output one sample at a time
for ii = 1:NN
    
    x_n = x_sn(ii);    % Get new Input sample and assign it to x(n)
    
    % Calculate the FIR Filter Output for M = 3
     y_n = (1/3)*(x_n + x_n_1 + x_n_2);
    
    % Calculate the FIR Filter Output for M = 6
%     y_n = (1/6)*(x_n + x_n_1 + x_n_2 + x_n_3 + x_n_4 + x_n_5);

    % Calculate the FIR Filter Output for M = 11
%     y_n = (1/11)*(x_n + x_n_1 + x_n_2 + x_n_3 + x_n_4 + x_n_5 + x_n_6 + x_n_7 + x_n_8 + x_n_9 + x_n_10);

    % Calculate the FIR Filter Output for M = 16
%    y_n = (1/16)*(x_n + x_n_1 + x_n_2 + x_n_3 + x_n_4 + x_n_5 + x_n_6 + x_n_7 + x_n_8 + x_n_9 + x_n_10 + x_n_11 + x_n_12 + x_n_13 + x_n_14 + x_n_15);
    
    % Save it to the output vector
    y_vector(ii) = y_n;
    
    % Update the previous samples
    x_n_15 = x_n_14;
    x_n_14 = x_n_13;
    x_n_13 = x_n_12;
    x_n_12 = x_n_11;
    x_n_11 = x_n_10;
    x_n_10 = x_n_9;
    x_n_9 = x_n_8;
    x_n_8 = x_n_7;
    x_n_7 = x_n_6;
    x_n_6 = x_n_5;
    x_n_5 = x_n_4;
    x_n_4 = x_n_3;
    x_n_3 = x_n_2;
    x_n_2 = x_n_1;
    x_n_1 = x_n;

end

% Plot the Input noisy signal and output filtered signal
figure
plot(n,x_sn)
hold on
plot(n, y_vector,'r')
hold off
grid on
xlabel('Samples (n)')
ylabel('Voltage (V)')
title('Filtering Noise from Signal Using FIR Filter')
legend('Signal + Noise','FIR Filtered Signal')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)

%% Spectrum of the Original and Filtered Signals

NN = length(x_sn);  % Finding no. of samples in the input signal
 
X_k = fft(x_sn);    % Finding spectrum of the input signal

Mag_X_k_double_sided = abs(X_k)/NN; % Calculating Spectrum Magnitude 

Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);   % compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Ignoring the DC component

% Finding the spectrum of the filtered signal
 
Y_k = fft(y_vector);    % Finding spectrum of the input signal

Mag_Y_k_double_sided = abs(Y_k)/NN; % Calculating Spectrum Magnitude 

Mag_Y_k_single_sided = Mag_Y_k_double_sided(1:NN/2);   % compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Mag_Y_k_single_sided(2:NN/2) = 2*Mag_Y_k_single_sided(2:NN/2);    % Ignoring the DC component

freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency

% Plotting Magnitude Spectrum of the Single-Sided Spectrum
figure
plot(freq, Mag_X_k_single_sided)
hold on
plot(freq, Mag_Y_k_single_sided,'--r')
hold off
grid on
legend('Orginal Signal','Filtered Signal')
title('Single-Sided Spectrum of the signals, x(n) and x_f(n)')
xlabel('Frequency (Hz))')
ylabel('Spectrum Magnitude')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2.5)
