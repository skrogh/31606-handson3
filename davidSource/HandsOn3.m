%% Hands-on 3 - 2014-09-18

clear all
clc

%% 1.1 Toolbox: Spectrum

[test_signal, time]   = sinusoid(1, 1000, 0, 4000, 2); %amp. 1, freq. 4kHz, phase 0, samp.freq. 2.5kHz, duration 2s
[test_spectrum, freq] = spectrum(test_signal, 4000);
test_spectrum = test_spectrum/2; %Scaling for both positive and negative

plot(fftshift(freq), mag2db(abs(fftshift(test_spectrum))))
ylim([-100 25]);
title('Test Sinusoid at 1kHz')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%% 1.2 Fourier transform of a synthetic signal

fs = 400000; %Maximum signal frequency is 2^10*f_0 = 102400. Therefore fs > 2*102400.
Ts = 2;      %2s duration
f0 = 100;    
N = 10;

%Signal synthesis
time = 0:1/fs:Ts;
signal = 0;
for k = 0:N
    signal = signal + cos(2*pi*(2^k)*f0*time + k*pi/3);
end

%% Plots with linear scale 

[S, freq] = spectrum(signal, fs);

figure

subplot(2,2,1);
plot(time, signal);
xlim([0.9 0.93]); %From 0.9s to 0.93s.
title('Synthesized Signal (Time Domain)')
xlabel('Time [s]')
ylabel('Amplitude [-]')

subplot(2,2,2);
plot(freq, abs(S));
xlim([0 105000]);
ylim([0 0.6]);
title('Synthesized Signal (Frequency Domain)')
xlabel('Frequency [Hz]')
ylabel('Magnitude [-]')

subplot(2,2,3);
plot(freq, real(S));
xlim([0 105000]);
ylim([-0.6 0.6]);
title('Synthesized Signal (Frequency Domain)')
xlabel('Frequency [Hz]')
ylabel('Real Part [-]')

subplot(2,2,4);
plot(freq, imag(S));
xlim([0 105000]);
ylim([-0.6 0.6]);
title('Synthesized Signal (Frequency Domain)')
xlabel('Frequency [Hz]')
ylabel('Imaginary Part [-]')

%% Plot with double logarithmic scale / Plot with linear scale centered on 400Hz

[S, freq] = spectrum(signal, fs);

figure

subplot(2,1,1);
semilogx(freq, mag2db(abs(S)));
hold on
plot(f0, 0, 'or', 'MarkerSize', 5);
xlim([0 200000]);
ylim([-150 50]);
title('Synthesized Signal (Frequency Domain)')
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')

subplot(2,1,2);
plot(freq, abs(S));
hold on
line([400 400],[0 1.5], 'LineStyle','--', 'LineWidth', 1, 'Color',[0.8 0.1 0.1])
xlim([395 405]);
ylim([0 1.5]);
title('Synthesized Signal (Frequency Domain)')
xlabel('Frequency [Hz]')
ylabel('Magnitude [-]')

%% Save and reload synthetic signal

signal = signal/max(abs(signal)); %Normalize signal to avoid clipping

audiowrite('synthetic_signal.wav', signal, fs, 'BitsPerSample', 16)
signal_reloaded = audioread(['C:\Users\Aztar\Documents\MATLAB' filesep 'synthetic_signal.wav']);

plot(time, signal, 'b')
hold on
plot(time, signal_reloaded, 'r')
hold on
title('Original vs. Reloaded signal')
xlim([0.9 0.93]);
xlabel('Time [s]');
ylabel('Amplitude [-]');
legend('Original signal','Reloaded signal');

%% 1.3 Fourier transform of a recorded signal

[signal_piano, fs_piano] = audioread(['C:\Users\Aztar\Documents\MATLAB' filesep 'piano.wav']);
Ts_piano = length(signal_piano)/fs_piano; %Total time

[S, freq] = spectrum(signal_piano, fs_piano);

figure

subplot(2,2,1);
%Plot piano signal from 0s to 1s
time_01 = 0:1/fs_piano:1-1/fs_piano;
signal_01 = signal_piano(1:fs_piano);
plot(time_01, signal_01)
xlabel('Time [s]');
ylabel('Amplitude [-]');
title('Piano.wav (Time Domain)')

subplot(2,2,2);
%Plot piano spectrum doublelog
plot(freq(1:length(freq)/2), mag2db(abs(S(1:length(freq)/2))));
xlim([0 2.25*10^4]);
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
title('Piano.wav (Frequency Domain)')

subplot(2,2,3);
%Plot piano spectrum 
plot(freq(1:length(freq)/2), mag2db(abs(S(1:length(freq)/2))));
xlim([0 500]);
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
title('Piano.wav (Frequency Domain)')

subplot(2,2,4);
%Plot piano spectrum
plot(freq(1:length(freq)/2), mag2db(abs(S(1:length(freq)/2))));
xlim([130 131]);
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
title('Piano.wav (Frequency Domain)')

sound(signal_piano, 44100)

%% Synthesis of piano signal with amplitude and phase

clear all
clc

[signal_piano, fs_piano] = audioread(['C:\Users\Aztar\Documents\MATLAB' filesep 'piano.wav']);
Ts_piano = length(signal_piano)/fs_piano; %Total time
t = 0:1/fs_piano:Ts_piano;

[S, freq] = spectrum(signal_piano, fs_piano);
S = S/2; %Scaling for both positive and negative

[S_pk, freq_pk] = findpeaks(abs(S));

Y = zeros(1, length(freq));

for p = 1:length(freq_pk)
    Y(freq_pk(p)) = S(freq_pk(p));
end

Q = ifft(Y,'symmetric');
Q = Q*length(Q);

figure

subplot(2,1,1);
plot(fftshift(freq),fftshift(mag2db(abs(Y))))
xlabel('Frequency [Hz]')
ylabel('Magnitude [dB]')
title('Synthesized piano (Frequency Domain)')

subplot(2,1,2);
plot(t, Q)
xlabel('Time [s]')
ylabel('Amplitude [-]')
title('Synthesized piano (Time Domain)')

sound(Q, fs_piano)


%% 2 Low bitrate telephone transmission

%% B-spline spectrum

fs = 44100;

N = 3;
L = 6;

b_lowpass = Bspline(L, N);
h = [b_lowpass' zeros(1, fs-length(b_lowpass))];
[b_spectrum, freq] = spectrum(h, fs);
b_spectrum = b_spectrum/max(b_spectrum);

figure

subplot(2,1,1);
plot(freq(1:fs/2), abs(b_spectrum(1:fs/2)))
xlim([0 2.25*10^4]);
ylim([0 1.2]);
title('B-Spline of length 6 order 3')
xlabel('Frequency [Hz]')
ylabel('Amplitude [-]')

subplot(2,1,2);
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_spectrum(1:fs/2)))))
title('B-Spline of length 6 order 3')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%% Multiple B-spline spectra

fs = 44100;

b_0 = Bspline(6, 0);
b_1 = Bspline(6, 1);
b_2 = Bspline(6, 2);
b_3 = Bspline(6, 3);
b_4 = Bspline(6, 4);
b_5 = Bspline(6, 5);

h_0 = [b_0' zeros(1, fs-length(b_0))];
[b_0s, freq] = spectrum(h_0, fs);
h_1 = [b_1' zeros(1, fs-length(b_0))];
[b_1s, freq] = spectrum(h_1, fs);
h_2 = [b_2' zeros(1, fs-length(b_0))];
[b_2s, freq] = spectrum(h_2, fs);
h_3 = [b_3' zeros(1, fs-length(b_0))];
[b_3s, freq] = spectrum(h_3, fs);
h_4 = [b_4' zeros(1, fs-length(b_0))];
[b_4s, freq] = spectrum(h_4, fs);
h_5 = [b_5' zeros(1, fs-length(b_0))];
[b_5s, freq] = spectrum(h_5, fs);

b_0s = b_0s/max(b_0s);
b_1s = b_1s/max(b_1s);
b_2s = b_2s/max(b_2s);
b_3s = b_3s/max(b_3s);
b_4s = b_4s/max(b_4s);
b_5s = b_5s/max(b_5s);

figure

subplot(3,1,1);
plot(b_0, 'Color', [1.0 0 0.0], 'LineWidth', 1)
hold on
plot(b_1, 'Color', [0.8 0 0.2], 'LineWidth', 1)
hold on
plot(b_2, 'Color', [0.6 0 0.4], 'LineWidth', 1)
hold on
plot(b_3, 'Color', [0.4 0 0.6], 'LineWidth', 1)
hold on
plot(b_4, 'Color', [0.2 0 0.8], 'LineWidth', 1)
hold on
plot(b_5, 'Color', [0.0 0 1.0], 'LineWidth', 1)
hold on
xlim([1 25]);
%ylim([0 0]);
title('B-spline impulse responses')
xlabel('Coefficient [-]')
ylabel('Amplitude [-]')
p = legend('n = 0','n = 1','n = 2','n = 3','n = 4','n = 5','n = 6');
set(p,'FontSize', 8);

subplot(3,1,2);
plot(freq(1:fs/2), abs(b_0s(1:fs/2)), 'Color', [1.0 0 0.0], 'LineWidth', 1)
hold on
plot(freq(1:fs/2), abs(b_1s(1:fs/2)), 'Color', [0.8 0 0.2], 'LineWidth', 1)
hold on
plot(freq(1:fs/2), abs(b_2s(1:fs/2)), 'Color', [0.6 0 0.4], 'LineWidth', 1)
hold on
plot(freq(1:fs/2), abs(b_3s(1:fs/2)), 'Color', [0.4 0 0.6], 'LineWidth', 1)
hold on
plot(freq(1:fs/2), abs(b_4s(1:fs/2)), 'Color', [0.2 0 0.8], 'LineWidth', 1)
hold on
plot(freq(1:fs/2), abs(b_5s(1:fs/2)), 'Color', [0.0 0 1.0], 'LineWidth', 1)
hold on
xlim([0 2.25*10^4]);
ylim([0 1.2]);
title('Normalized B-spline spectra in linear scale')
xlabel('Frequency [Hz]')
ylabel('Amplitude [-]')
p = legend('n = 0','n = 1','n = 2','n = 3','n = 4','n = 5','n = 6');
set(p,'FontSize', 8);

subplot(3,1,3);
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_0s(1:fs/2)))), 'Color', [1.0 0 0.0], 'LineWidth', 1)
hold on
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_1s(1:fs/2)))), 'Color', [0.8 0 0.2], 'LineWidth', 1)
hold on
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_2s(1:fs/2)))), 'Color', [0.6 0 0.4], 'LineWidth', 1)
hold on
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_3s(1:fs/2)))), 'Color', [0.4 0 0.6], 'LineWidth', 1)
hold on
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_4s(1:fs/2)))), 'Color', [0.2 0 0.8], 'LineWidth', 1)
hold on
semilogx(fftshift(freq(1:fs/2)), fftshift(mag2db(abs(b_5s(1:fs/2)))), 'Color', [0.0 0 1.0], 'LineWidth', 1)
hold on
ylim([-150 0])
xlim([10^2 3*10^4]);
title('Normalized B-spline spectra in double logarithmic scale')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')
p = legend('n = 0','n = 1','n = 2','n = 3','n = 4','n = 5','n = 6', 3);
set(p,'FontSize', 8);


%% Main task

b_lowpass = Bspline(6,3);
[s, fs] = audioread(['C:\Users\Aztar\Documents\MatLab' filesep 'spoken_sentence_44100.wav']);

%% Original and filtered signal

figure

s_original = s;
[s_original_spectrum, freq] = spectrum(s_original, fs);
subplot(2,1,1);
semilogx(freq(1:end-1), mag2db(abs(s_original_spectrum)));
set(gca,'XTick', logspace(-1,4,6));
title('Original signal')
xlim([0 3*10^4]);
ylim([-225 -25]);
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

s_filtered = conv(b_lowpass, s);
[s_filtered_spectrum, freq] = spectrum(s_filtered, fs);
subplot(2,1,2);
semilogx(freq(1:end-1), mag2db(abs(s_filtered_spectrum)));
set(gca,'XTick', logspace(-1,4,6));
%plot(freq(1:end-1), abs(s_filtered_spectrum));
title('Filtered signal')
xlim([0 3*10^4]);
ylim([-450 -25]);
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%sound(s_filtered, fs);


%% Filter, downsample, upsample and remove artifacts

figure

%Low-pass and plot spectrum
s_f = conv(b_lowpass, s);
[s_f_spectrum, freq] = spectrum(s_f, fs);
subplot(2,2,1);
semilogx(freq(1:end-1), mag2db(abs(s_f_spectrum)));
set(gca,'XTick', logspace(0,4,5));
xlim([0 3*10^4]);
ylim([-450 -25]);
title('Filtered signal')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%Downsample signal and plot spectrum
s_fd = downsample(s_f, 7);
[s_fd_spectrum, freq] = spectrum(s_fd, fs);
subplot(2,2,2);
semilogx(freq(1:end-1), mag2db(abs(s_fd_spectrum)));
set(gca,'XTick', logspace(0,4,5));
xlim([0 3*10^4]);
ylim([-175 -25]);
title('Downsampled signal')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%Upsample signal and plot spectrum
s_fdu = reshape(ones(7,1)*s_fd(:)', length(s_fd)*7, 1);
[s_fdu_spectrum, freq] = spectrum(s_fdu, 44100);
subplot(2,2,3);
semilogx(freq(1:end-1), mag2db(abs(s_fdu_spectrum)));
set(gca,'XTick', logspace(0,4,5));
xlim([0 3*10^4]);
ylim([-450 -25]);
title('Upsampled signal')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')

%Remove artifacts and plot spectrum
b_reconstruct = Bspline(6,5);
s_fdur = conv(b_reconstruct, s_fdu);
[s_fdur_spectrum, freq] = spectrum(s_fdur, 44100);
subplot(2,2,4);
semilogx(freq(1:end-1), mag2db(abs(s_fdur_spectrum)));
set(gca,'XTick', logspace(0,4,5));
xlim([0 3*10^4]);
ylim([-450 -25]);
title('Reconstructed signal')
xlabel('Frequency [Hz]')
ylabel('Amplitude [dB]')


%% END

%% plotting
% make new figure and place on screen
figure('Name','Name of figure','Position',[400 300 400 400])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 10 4])
h1 = plot(t_1,sig_1,'-')
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
title('f_s = 10000Hz')
ylim([-1.1 1.1])
xlabel('time / s')
ylabel('amplitude / a.u.')
saveas(gcf,'../pics/lecture1_sampling_1.eps','psc2')


