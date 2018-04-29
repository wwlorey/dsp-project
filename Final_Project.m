% EE3410 Final Project - Douglas Basler and William Lorey 
clear all; close all; clc;

%Import Signals
[taps,fs_taps]=audioread('taps.wav');
[bear,fs_bear] = audioread('Bear3.wav');

%Bear is shorter, so set len to bear's length
len = length(bear);

%Truncate taps to a length of len, with starting point at x_begin
x_begin = 0;
taps = taps(x_begin + 1:x_begin+len);

%Add the two signals
combined = taps+bear;

%Set frequency for playback and calculations
f = fs_bear;

%Play taps and pause for seven seconds
sound(taps,f)
pause(7)

%Play bear and pause for seven seconds
sound(bear,f)
pause(7)

%Play combined signals and pause for seven seconds
sound(combined,f)
pause(7)

% Calibration signal to adjust amplitude scaling
%t=[0:len-1]/f;
%taps=cos(2*pi*500*t);
% When I put this in and did xf=fft(taps); I saw a sinusoid at
% 500 Hz with an amplitude of 1.5e5 V, so I changed the fft command
% to xf=fft(taps)/1.5e5 to correct the scaling so that it had an
%amplitude of 1V

%FFT of taps and plotting frequencies and amplitude of signal
xf=fft(taps)/1.5e5;
freq1=[0:length(xf)-1]*f/length(xf);
plot(freq1,abs(xf));
title('Spectrum of Taps')
xlabel('Frequency(Hz)')
ylabel('Amplitude(V)')
xlim([100 1500]);

%Return here to check scaling
%return

figure;

%FFT of bear and plotting frequencies and amplitude of signal

yf=fft(bear)/1.5e5;
freq2=[0:length(yf)-1]*f/length(yf);
plot(freq2,abs(yf));
title('Spectrum of Bear')
xlabel('Frequency(Hz)')
ylabel('Amplitude(V)')
xlim([0 500]);

figure;

%Butterworth Filter Specifications
cutoff = 500;
Fcn = cutoff/(f/2);
order = 6;

%Create Lowpass Butterworth Filter to filter out bear
[b,a] = butter(order, Fcn, 'low');

%Amplitude response of Filter
freqz(b,a)
title('Frequency response of Filter')

%Filter Signal
output = filter(b,a,combined);

%play results
sound(output,f)
