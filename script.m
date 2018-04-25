clear all; close all; clc; % Delete local vars, graphs

% Read in the the WAV files
[a,Fa] = audioread('whaleclicks.wav');
[b,Fb] = audioread('Bear3.wav');

% Truncate the longer signal a to be the same length
% as signal b
aBegin = 0;%25000;
len = length(b);
a = a(aBegin + 1:aBegin + len); % Offset truncation of a to get good bear sound

%clip_level = .01;
%a = min(a, a*0 + clip_level);
%a = max(a, a*0 - clip_level);

%sound(a, Fa);
%pause(2);
%sound(b, Fb);

% Add the two signals
c = a + b;
length(c)
%sound(c, Fa);
%pause(6);
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
title('Power Spectrum Components for signal a (whale)'); % title the graph

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
title('Power Spectrum Components for signal b (bear)'); % title the graph

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
% sound(c,F);

% Filter specs:


bpFilt = designfilt('lowpassfir', ...       % Response type
       'FilterOrder',200, ...            % Filter order
       'PassbandFrequency',200, ...    % Frequency constraints
       'StopbandFrequency',250, ...
       'DesignMethod','ls', ...         % Design method
       'PassbandWeight',1, ...         % Design method options
       'StopbandWeight',5, ...
       'SampleRate',F / (2 * pi));               % Sample rate
     
fvtool(bpFilt)

%[x, y] = impz(bpFilt);
%k = fft(x);
%plot(k);
%output = conv(x, C);

output = filter(bpFilt, C);


% Take FFT of signal c and display graph
m3 = pow2(nextpow2(len)); % choose the next higher power of 2
%C = fft(output,m3); % take the fft of signal
f3 = (0:m3-1)*(F/m3); % set your frequency variable range
power = abs(output).^2/m3;
% calculate the power of the signal
plot(f3(1:floor(m3/2)),power(1:floor(m3/2))) % plots the power
xlim([0 5000])
xlabel('Frequency (Hz)'); % label the horizontal axis
ylabel('Power'); % label the vertical axis
title('Power Spectrum Components for signal output'); % title the graph



%[b, a] = butter(1, 200/(F/2), 'low');
%output = filter(b, a, c);
d = abs(ifft(output));
%sound(c, F);
%pause(8);
sound(d,F);
length(d)
