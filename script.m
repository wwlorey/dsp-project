clear all; close all; clc; % Delete local vars, graphs

% Read in the the WAV files
[a,Fa] = audioread('Bear3.wav');
[b,Fb] = audioread('prdog4.wav');

% Truncate the longer signal a to be the same length
% as signal b
aBegin = 25000;
len = length(b);
a = a(aBegin + 1:aBegin + len); % Offset truncation of a to get good bear sound

% Add the two signals
c = a + b;

F = Fa; % F = Fa = Fb

% Take FFT of signal a and display graph
m1 = pow2(nextpow2(len)); % choose the next higher power of 2
A = fft(a,m1); % take the fft of signal
f1 = (0:m1-1)*(F/m1); % set your frequency variable range
power = abs(A).^2/m1;
% calculate the power of the signal
plot(f1(1:floor(m1/2)),power(1:floor(m1/2))) % plots the power
xlim([0 5000])
xlabel('Frequency (Hz)'); % label the horizontal axis
ylabel('Power'); % label the vertical axis
title('Power Spectrum Components for signal a'); % title the graph

figure;

% Take FFT of signal b and display graph
m2 = pow2(nextpow2(len)); % choose the next higher power of 2
B = fft(b,m2); % take the fft of signal
f2 = (0:m2-1)*(F/m2); % set your frequency variable range
power = abs(B).^2/m2;
% calculate the power of the signal
plot(f2(1:floor(m2/2)),power(1:floor(m2/2))) % plots the power
xlim([0 5000])
xlabel('Frequency (Hz)'); % label the horizontal axis
ylabel('Power'); % label the vertical axis
title('Power Spectrum Components for signal b'); % title the graph

figure;

% Take FFT of signal c and display graph
m3 = pow2(nextpow2(len)); % choose the next higher power of 2
C = fft(c,m3); % take the fft of signal
f3 = (0:m3-1)*(F/m3); % set your frequency variable range
power = abs(C).^2/m3;
% calculate the power of the signal
plot(f3(1:floor(m3/2)),power(1:floor(m3/2))) % plots the power
xlim([0 5000])
xlabel('Frequency (Hz)'); % label the horizontal axis
ylabel('Power'); % label the vertical axis
title('Power Spectrum Components for signal c'); % title the graph


% Play the combined signal
sound(c,Fa);
