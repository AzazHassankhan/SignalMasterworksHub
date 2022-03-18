% Made by Azaz Hassan Khan || 18jzele0262 || LAB 12
clear
close all
clc
Data= audioread('Lab12_Music.m4a');       %loading music
X = Data(:,1);                            %First  column
plot(X,'linewidth',2)                     %plotting
grid on                                   %Grid on
xlabel('Index (n)')                       %X_Label of graph
ylabel('Magnitude of x(n)')               %Y_Label of graph
title('Signal in Time Domain)')           %Title of the graph
hold on

%Magnitude Spectrum of the Single-Sided Spectrum

Fs = 44100;      % Sampling Frequency
Ts = 1/Fs;      % Sampling Time
NN = length(X);  % Finding no. of samples in the input signal
X_k = fft(X);    % Finding spectrum of the input signal
Mag_X_k_double_sided = abs(X_k)/NN; % Calculating Spectrum Magnitude 
Mag_X_k_single_sided = Mag_X_k_double_sided(1:NN/2);   % compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
Mag_X_k_single_sided(2:NN/2) = 2*Mag_X_k_single_sided(2:NN/2);    % Ignoring the DC component
freq = Fs*(0:(NN/2)-1)/NN;          % Converting k in to Frequency
% Plotting Magnitude Spectrum of the Single-Sided Spectrum
figure
plot(freq, Mag_X_k_single_sided,'linewidth',2)
title('Single-Sided Spectrum of the signals, x(n) and x_f(n)')
xlabel('Frequency (Hz))')
ylabel('Spectrum Magnitude')

% Analog Low-Pass Filter with 84 Hz Cut-off Frequency
s = tf('s');    % Defining "s" for Analog Filter
H_s = ((1+1.6e-05*s)/(1+0.0002*s)); % LP Filter Transfer Function
% Plotting the Bode Plot for the Analog Filter
figure
bode(H_s)
title('Low-Pass Filter Bode Plot')
grid on


% Discretization of Low-Pass Filter
z = tf('z',Ts); % Defining "z" for Digital Filter at sampling time Ts
ZZ = (2/Ts)*((z-1)/(z+1));    % Bilinear Transformation
H_z = ((1+1.6e-05*ZZ)/(1+0.0002*ZZ)); 
% Comparing the Digtial Filter with the Analog Filter
figure
bode(H_s)
hold on
bode(H_z,'--r')
hold off
grid on
legend('H(s)','H(z)')
x_sn=Data;
NN = length(x_sn);  % Finding no. of samples in the input signal
% Calculating IIR Filter Output 
y_vector = zeros(1,NN);     % Initializing the Filter Output Vector
% Initializing the variables needed for computing the Filter Output

y_n_3 = 0;      
y_n_2 = 0;
y_n_1 = 0;
x_n_3 = 0;
x_n_2 = 0;
x_n_1 = 0;
% Calculating the Filter Output one sample at a time
for ii = 1:NN
      x_n = x_sn(ii);     % Get new Input sample and assign it to x(n)
       % Calculate the output sample y(n)
    y_n =  (2.411/18.64)*x_n + (2/18.64)*x_n_1 +(-0.4112/18.64) *x_n_2 + (-2/18.64)*y_n_1 + (16.64/18.64)*y_n_2 ;
        % Save it to the output vector
    y_vector(ii) = y_n;
        % Update the previous samples
   
    y_n_3 = y_n_2;
    y_n_2 = y_n_1;
    y_n_1 = y_n;
    
    x_n_3 = x_n_2;
    x_n_2 = x_n_1;
    x_n_1 = x_n;
end

figure
plot(x_sn)
hold on
plot( y_vector,'k')
hold off
grid on
xlabel('Samples (n)')
ylabel('Voltage (V)')
title('Filtering Noise from Signal Using IIR and FIR Filters')
legend('Signal + Noise','IIR FilLter')
