%Made by Azaz hassan Khan || 18jzele0262 || Lab 3 (task 2)
clc                                  %clear screen
close all                            %clear workspace and command window
clear all                            %clear matlab memory
% Part (a)
Fs=2;                               %Sampling frequency, Fs
Ts=0.5;                             %Ts=1/Fs
n1=0:1:9;                           %No.of samples are 0 to 9 for Piece 1
X1= n1*Ts;
n2=10:1:19;                         %No.of samples are 10 to 19 for Piece 2
X2= [5 5 5 5 5 5 5 5 5 5];
ns = [n1 n2];% Use the square bracket operator [] to concatenate t
x = [X1 X2];% Use the square bracket operator [] to concatenate x
% (Part b)
Vpp = 5;                            % Peak-to-peak value of triangular wave
N = 20;                             % N Samples of DTS signal
n = 0:1:N-1;                        % Dts Time axis for the x(t)
FF = 20;                            % Number of harmonics in the x(t)
x_k = 0;                            % Initializing the xk variable
x_signal = 0;                       % Initializing the x(t) variable
k_vector = zeros(1,FF+1);           % k vector to store  harmonic number
Ck_vector = zeros(1,FF+1);          % Ck vector to store  harmonics
temp=0;                             % Initializing the temp variable
ii = 0;                             % Initializing the ii variable
for k =0:1:N-1
       temp=0;                      % Initializing the temp variable
       Bug=0;                       % Initializing the Bug variable
       C_k = 0;                     % Initializing the Ck variable
       ii = ii + 1;                 %incrementing the value by 1
       for d=0:1:9                  
            temp=0.025*d*exp((-1j*pi*k*d)/10)+temp;
       end
       for d=10:1:19
            Bug=0.25*exp(-1j*pi*k*d/10)+Bug;
       end
       C_k=Bug+temp;
       k_vector(ii) = k;         % Storing the indices in the vector
       Ck_vector(ii) = abs(C_k); % Storing the Harmonics in the vector
% Synthesizing the time-domain signal
       x_k = C_k*exp(1j*k*2*pi*n/N);     % kth harmonic signal
       x_signal = x_signal + x_k;        % Taking summation of  harmonics
end
subplot(3,1,1)                             %Subplot 1
stem(ns,x,'b','linewidth',2.5);        % Using stem command  Piece-wise DTS
grid on;                            % Turn-on the Grid
xlabel('Time (sec)');               % Label the X-Axis in figure    
ylabel('Amplitude (volts)');        % Label the Y-Axis in figure    
title('DT signal versus Samples');  %title of the graph
subplot(3,1,2)                             %Subplot 1
stem(k_vector, Ck_vector,'linewidth',2.5)  %Plot the signal
grid on                                    
xlabel('Indices, k')                       %title of X-axis
ylabel('C_k')                              %title of Y-axis
title('Magnitude Spectrum of the Signal')  %title of Plot
subplot(3,1,3)                         %Subplot 2
stem(n, real(x_signal),'linewidth',2.5)                %Plot the signal
grid on                                %On the grids
xlabel('Time, t (sec)')                %title of X-axis
ylabel('x_s_u_m(t)')                    %title of Y-axis
title('Reconstruct the time-domain DT')  %title of Plot
