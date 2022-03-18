clear
close all
clc

% Loading and Plotting Accelerometer Data

Data = load('Lab4_Accelerometer_Data.csv');	% Loading the Accelerometer data

Acc_x_data = Data(:,1); % First column is Acceleration in G in the X direction
Acc_y_data = Data(:,2); % Second column is Acceleration in G in the Y direction
Acc_z_data = Data(:,3); % Third column is Acceleration in G in the Z direction

figure
subplot(3,1,1)
plot(Acc_x_data, 'linewidth',2)
grid on
xlabel('Index (n)')
ylabel('A_X (Gs)')

subplot(3,1,2)
plot(Acc_y_data, 'linewidth',2)
grid on
xlabel('Index (n)')
ylabel('A_Y (Gs)')

subplot(3,1,3)  
plot(Acc_z_data, 'linewidth',2)
grid on
xlabel('Index (n)')
ylabel('A_Z (Gs)')


% Removing noise from the signal

n = length(Acc_x_data);		% Finding the number of samples in the Acceleration vector

Acc_x_clean = zeros(n,1);	% Initializing a variable with zeros. This will be used to store "clean" data

noise = 0.1;                % Defining Noise threshold in Gs

% For loop for simulated run-time environment

for kk = 1:n        % Counter for signal samples

        if Acc_x_data(kk) >= noise || Acc_x_data(kk) <= -noise  % Check noise threshold in the signal

            Acc_x_clean(kk) = Acc_x_data(kk);       % Signal value is higher than noise, store it.

        end

end

figure
plot(Acc_x_data)
hold on
plot(Acc_x_clean, 'r')
hold off
grid on
xlabel('Index (n)')
ylabel('A_X (Gs)')
legend('Original Data', 'Cleaned Data')
title('Acceleration in the X-Direction')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2.5)


% Removing DC Offset from the Signal

Acc_z_no_offset = Acc_z_data + 1;   % Adding 1 to it to remove the offset from the signal

figure
subplot(2,1,1)
plot(Acc_z_data)
grid on
xlabel('Index (n)')
ylabel('A_Z (Gs)')
legend('Original Data')
title('Acceleration in the Z-Direction')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2.5)

subplot(2,1,2)
plot(Acc_z_no_offset)
grid on
xlabel('Index (n)')
ylabel('A_Z (Gs)')
legend('Offset corrected Data')
h1 = findobj(gcf,'type','line');
set(h1,'linewidth',2.5)