%Made by Azaz hassan Khan || 18jzele0262 || Lab 3 (task 1) (part a)
clc                                  %clear screen
close all                            %clear workspace and command window
clear all                            %clear matlab memory
%Initializing the variables
Vpp = 5;                             % Peak-to-peak value of triangular wave
To = 10;                          % Period of the signal
t = (-2*To):0.1:(2*To);      % Time axis for the x(t)
FF = 10;                             %just change those numbers to 5,20,50
C_k = 0;                             % Initializing the Ck variable
x_k = 0;                             % Initializing the xk variable
x_signal = 0;                        % Initializing the x(t) variable
k_vector = zeros(1,2*FF+1);          % k vector to store  harmonic number
Ck_vector = zeros(1,2*FF+1);         % Ck vector to store  harmonics
ii = 0;
%Running the for loop to sum the harmonics component
for k = -FF:1:FF
    ii = ii + 1;
   if k == 0
       C_k = 15/4;          % DC Component of the signal
   else
C_k = (cos(k*pi)/(To*(k*2*pi*0.1)^2))-(1/(To*(k*2*pi*0.1)^2))-(5/(To*1j*(k*2*pi*0.1)));    % kth harmonic coefficient
   end
       k_vector(ii) = k;    % Storing the indices in the vector
       Ck_vector(ii) = abs(C_k); % Storing the Harmonics in the vector
% Synthesizing the time-domain signal
       x_k = C_k * exp(1i*k*2*pi*t/To);     % kth harmonic signal
       x_signal = x_signal + x_k;   % Taking summation of all the harmonics
 end
subplot(2,1,1)                             %Subplot 1
stem(k_vector, Ck_vector,'linewidth',2.5)  %Plot the signal
grid on                                    
xlabel('Indices, k')                       %title of X-axis
ylabel('C_k')                              %title of Y-axis
title('Magnitude Spectrum of the Signal')  %title of Plot
subplot(2,1,2)                         %Subplot 2
plot(t, real(x_signal),'linewidth',2.5)                %Plot the signal
grid on                                %On the grids
xlabel('Time, t (sec)')                %title of X-axis
ylabel('x_s_u_m(t)')                    %title of Y-axis
title('Reconstruct the time-domain DT')  %title of Plot
