close all
clear all


%% 1.1 Toolbox: Spectrum
% Sinusoid generation
fs = 10e3; %10kHz sampling rate
f = 1e3; %1kHz frequency
T = 1; %1s period
A = 1; %Amplitude of 1
[t,y] = sine( A, f, 0, fs, T);
% Get the spectrum
[Y,freq] = make_spectrum( y, fs );
%plot power density spectrum
figure(1)
%define parameters for export
set(gcf, 'paperunits','centimeters','Paperposition',[0,0,10,4]);
h1 = plot(freq,abs(Y))

%cosmetics
set(h1, 'linewidth', 1);
set(gca,'Fontsize', 10);
title('f_s = 10kHz');
ylim([0, 0.7]);
xlim([-3000,3000]);
xlabel('frequency [Hz]')
ylabel('amplitude');
saveas(gcf, './pics/3-1-1.eps','psc2');

%% 1.2 Fourier transform of a synthetic signal
% Synthesizing the signal s[t]
T = 2; %period of 2s
N = 10; %sum limit
f0 = 100; %lowest frequency in generated signal
%Highest frequency is 2^N*f0=1024*100=1.024e5, choosing fs 4 times that
fs = 2^N*f0*4;
t = [0:1/fs:T-1/fs]; %time vector

% Generate signal
s = zeros(1,length(t));
for k = 0:N;
    s = s + cos(2*pi*2^k*f0*t+k*pi/3);
end

figure(1)
% plot s[0.9s,0.93s]
set(gcf, 'paperunits','centimeters','Paperposition',[0,0,15,4]);
h1 = plot(t,s); 
%cosmetics
set(h1, 'linewidth', 1);
set(gca,'Fontsize', 10);
title('s[t]');
ylim([-8,8]);
xlim([0.9,0.93]);
xlabel('time [s]')
ylabel('amplitude');
saveas(gcf, './pics/3-1-2.eps','psc2');


figure(2)
set(gcf, 'paperunits','centimeters','Paperposition',[0,0,15,8]);
% spectrum of s
[Y,freq] = make_spectrum(s,fs);
subplot(2,1,1);
%positive frequencies magnitude
h1 = plot(freq(1:ceil(length(freq)/2)),2*abs(Y(1:(ceil(length(Y)/2)))))
%cosmetics
set(h1, 'linewidth', 1);
set(gca,'Fontsize', 10);
title('Magnitude spectrum')
ylim([0,1.1]);
xlim([0,105000]);
xlabel('Frequency [Hz]')
ylabel('magnitude');
% all frequencies magnitude
%subplot(2,2,2);
%plot(fftshift(freq),2*abs(fftshift(Y)))
%real part
subplot(2,2,3);
h2 = plot(freq(1:ceil(length(freq)/2)),real(2*Y(1:(ceil(length(Y)/2))))) %only pos freqs
%cosmetics
title('Real part');
ylim([-1.1,1.1]);
xlim([0,105000]);
xlabel('Frequency [Hz]')
ylabel('amplitude');
%im part
subplot(2,2,4);
h3 = plot(freq(1:ceil(length(freq)/2)),imag(2*Y(1:(ceil(length(Y)/2))))) %only pos freqs
%cosmetics
title('Imag part');
ylim([-1.1,1.1]);
xlim([0,105000]);
xlabel('Frequency [Hz]')
ylabel('amplitude');
saveas(gcf, './pics/3-1-3.eps','psc2');

% log dB plot
figure(3)
set(gcf, 'paperunits','centimeters','Paperposition',[0,0,15,5]);
semilogx(freq(1:ceil(length(freq)/2)),10*log10(2*abs(Y(1:(ceil(length(Y)/2)))))) %extract only pos freqs
%make the red dot on first peak
[pks, locs] = findpeaks(10*log10(2*abs(Y(1:(ceil(length(Y)/2))))), 'MINPEAKHEIGHT', -10);
hold on
plot(freq(locs(1)),pks(1),'or', 'MarkerSize', 15);
hold off
%cosmetics
set(gca, 'XTick', logspace(0, 5,6));
title('s magnitude spectrum in dB');
ylim([-160,50]);
xlim([0,150000]);
xlabel('Frequency [Hz]')
ylabel('magnitude [dB]');
saveas(gcf, './pics/3-1-4.eps','psc2');

%spectrum range 395-405
figure(4)
set(gcf, 'paperunits','centimeters','Paperposition',[0,0,10,4]);
plot(freq,2*abs(Y)); xlim([395,405]);
line([400;400],[0;1.4],'LineStyle','--','Color', 'r')
title('s magnitude spectrum');
ylim([0,1.1]);
xlabel('Frequency [Hz]')
ylabel('magnitude');
saveas(gcf, './pics/3-1-5.eps','psc2');

% save s to ha3_s_12.wav
NBits = 16;
name = 'ha3_s_12.wav';
wavwrite(s/max(abs(s)),fs,NBits,name); %s has to be scaled to between -1 and 1 or it will be clipped
%read it back in
s_wav = wavread(name)'*max(abs(s)); %convert to row vector and scale to orignal
%plot and compare with original
figure(1)
hold on
plot(t,s_wav,'r'); xlim([0.9,0.93]);
line([400;400],[0;1.4],'LineStyle','--','Color', 'r')
title('s original vs. wav readin');
ylim([-8,8]);
xlabel('time [s]')
ylabel('amplitude');
legend('org. signal','.wav file');
saveas(gcf, './pics/3-1-6.eps','psc2');
hold off