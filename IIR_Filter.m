clear
close all
clc

format long

%% Loading the test data

Data = load('Lab14_Sensor_Data.CSV');

DATA = Data(:,1); % First column is the Time


%% Plotting the Sensor Output Voltage

figure
plot(DATA)
xlabel('Time (sec)')
ylabel('Sensor Output Voltage (V)')
grid on



%% Analyzing the Spectrum of the Input Signal

Ts = 1e-6;      % Sampling Time
Fs = 1/Ts;      % Sampling Frequency

NN = length(DATA);    % Total # of samples in each data vector

X_k = fft(DATA);    % Finding spectrum of the input signal

Mag_X_k_double_sided = abs(X_k)/NN; % Calculating Spectrum Magnitude 

Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);   % compute the single-sided spectrum
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Making the amplitude twice exxcept for the DC component

freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency

% Plotting Magnitude Spectrum of the Single-Sided Spectrum
figure
plot(freq, Mag_X_k_single_sided)
grid on
xlim([0 3000])
title('Single-Sided Spectrum of the Sensor Voltage, x(n)')
xlabel('Frequency (Hz))')
ylabel('Magnitude of X(k)')



%% Analog Low-Pass Filter with 84 Hz Cut-off Frequency

s = tf('s');    % Defining "s" for Analog Filter

H_s = ((s + 3400)/(s + 500)); % LP Filter Transfer Function

% Plotting the Bode Plot for the Analog Filter
figure
bode(H_s)
title('Low-Pass Filter Bode Plot')
grid on
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)
set(gcf,'color','w')

%% Discretization of Low-Pass Filter

z = tf('z',Ts); % Defining "z" for Digital Filter at sampling time Ts

ZZ = (2/Ts)*(z-1)/(z+1);    % Bilinear Transformation

H_z = ((ZZ + 3400)/(ZZ + 500)); % Digital Filter Transfer Function fc = 500Hz

% Comparing the Digtial Filter with the Analog Filter
figure
bode(H_s)
hold on
bode(H_z,'--r')
hold off
title('Comparing the Transfer Functions')
grid on
legend('H(s)','H(z)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)
set(gcf,'color','w')

%% Calculating IIR Filter Output 

y_vector = zeros(1,NN);     % Initializing the Filter Output Vector

n = 1:NN;   % Index Vector for plotting Signals

% Initializing the variables needed for computing the Filter Output    
y_n_2 = 0;
y_n_1 = 0;

x_n_2 = 0;
x_n_1 = 0;

% Calculating the Filter Output one sample at a time
for ii = 1:NN
    
    x_n = DATA(ii);     % Get new Input sample and assign it to x(n)
    
    % Calculate the output sample y(n) using the current and previous samples
    y_n = (300510/2.00e06) * x_n + (1020/2.00e06)*x_n_1 + (-299490/2.00e06)*x_n_2 + (1000/2.00e06)*y_n_1 + (1.9975e06/2.00e06)*y_n_2; % fc = 500Hz    

    % Save it to the output vector
    y_vector(ii) = y_n;
    
    % Update the previous samples
    y_n_2 = y_n_1;
    y_n_1 = y_n;

    x_n_2 = x_n_1;
    x_n_1 = x_n;

end

% Plot the Input noisy signal and output filtered signal
figure
plot(n,DATA)
hold on
plot(n, y_vector,'r')
hold off
grid on
xlabel('Samples (n)')
ylabel('Voltages (V)')
title('Filtering Noise from Sensor Output Using IIR Filter')
legend('Sensor Output','Filtered Signal')

% Plot the Input noisy signal and output filtered signal
figure

subplot(2,1,1)
plot(n,DATA)
grid on
xlabel('Samples (n)')
ylabel('Voltages (V)')
title('Filtering Noise from Sensor Output Using IIR Filter')

subplot(2,1,2)
plot(n, y_vector,'r')
grid on
xlabel('Samples (n)')
ylabel('Voltages (V)')

legend('Sensor Output','Filtered Signal')


%% Analyzing the Spectrum of the Filtered Signal

X_k1 = fft(y_vector);    % Finding spectrum of the input signal

Mag_X_k1_double_sided = abs(X_k1)/NN; % Calculating Spectrum Magnitude 

Mag_X_k1_single_sided = Mag_X_k1_double_sided(1:NN/2);   % compute the single-sided spectrum
Mag_X_k1_single_sided(2:NN/2) = 2*Mag_X_k1_single_sided(2:NN/2);    % Ignoring the DC component

freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency

% Plotting Magnitude Spectrum of the Filtered and Unfiltered Signals
figure
plot(freq, Mag_X_k_single_sided)
hold on
plot(freq, Mag_X_k1_single_sided,'r')
hold off
grid on
xlim([0 3000])
legend('Unfiltered Sensor Voltage','Filtered Sensor Voltage')
title('Single-Sided Spectrum of the Sensor Voltages')
xlabel('Frequency (Hz))')
ylabel('Magnitude (V)')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2)
set(gcf,'color','w')
