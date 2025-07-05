
% Setup commands
clc; clear; close all;

% Setting up Parameters
fs = 1000;              % Sampling frequency(Hz)
t = 0:1/fs:1;           % Time vector(1 sec duration)
f_signal = 5;           % Base signal frequency(Hz)
noise_level = 0.5;      % Amplitude of noise

% Creating the signals
signal_clean = sin(2*pi*f_signal*t);
noise = noise_level * randn(size(t));
signal_noisy = signal_clean + noise;

% Moving Average Filter
windowSize = 20;
b_ma = (1/windowSize) * ones(1, windowSize);
signal_ma = filter(b_ma, 1, signal_noisy);

% Butterworth Low-Pass Filter
fc = 10;                           % Cutoff frequency (Hz)
Wn = fc / (fs/2);                  % Normalized cutoff
[b_lp, a_lp] = butter(4, Wn);       % 4th-order Butterworth
signal_lp = filtfilt(b_lp, a_lp, signal_noisy);

% Savitzky-Golay Filter
signal_sg = sgolayfilt(signal_noisy, 3, 21);  % 3rd-order poly, 21-pt window


% PLOT RESULTS
figure('Name', 'Signal Denoising Methods', 'NumberTitle', 'off');
subplot(4,1,1);
plot(t, signal_noisy, 'r'); title('Noisy Signal'); ylabel('Amplitude');
xlim([0 1]);

subplot(4,1,2);
plot(t, signal_ma, 'b'); title('Moving Average Filter'); ylabel('Amplitude');
xlim([0 1]);

subplot(4,1,3);
plot(t, signal_lp, 'g'); title('Butterworth Low-Pass Filter'); ylabel('Amplitude');
xlim([0 1]);

subplot(4,1,4);
plot(t, signal_sg, 'm'); title('Savitzky-Golay Filter'); ylabel('Amplitude'); xlabel('Time (s)');
xlim([0 1]);

sgtitle('Comparison of Signal Denoising Methods');


