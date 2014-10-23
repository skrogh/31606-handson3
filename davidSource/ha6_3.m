%% 3.1 Ex. 12.6 in the book - again

Rp = -2;  %Gp dB
Rs = -11; %Gs dB
Wh = 35;  %rad/s - angular nyquist freq apprx 5.57 Hz
Wp = 10/Wh; %normalized passband corner freq
Ws = 15/Wh; %normalized stopband corner freq

fs = 2*Wh/(2*pi); %sampling freq
Th = 2*pi/Wh; %period

%generate LP Butterworth filter
[n, Wc] = buttord(Wp, Ws, Rp, Rs);
[b, a]  = butter(n, Wc);
[H, w]  = freqz(b, a, 2^16, 2*pi*fs);
[h, t]  = impz(b, a);
wc = Wc*Wh;

%plot frequency response
figure
subplot(2,1,1)
plot(w, abs(H), 'Color', [0.00 0 1.00], 'LineWidth', 1);
xlim([0 Wh])
ylim([0 1.05])
title('LP Butterworth (\omega_c = 10.86 rad/s, n = 3) \\ Magnitude response')
xlabel('Angular frequency [rad/s]')
ylabel('Magnitude [-]')
subplot(2,1,2)
plot(w, (180/pi)*angle(H), 'Color', [0.00 0 1.00], 'LineWidth', 1);
xlim([0 Wh])
ylim([-200 200])
title('LP Butterworth (\omega_c = 10.86 rad/s, n = 3) \\ Phase response')
xlabel('Angular frequency [rad/s]')
ylabel('Phase [degrees]')

%transfer function is b/a (polynomial in negative powers)

%% Plot z-plane pole-zero diagram

figure 
zplane(b, a)
title('LP Butterworth (\omega_c = 10.86 rad/s, n = 3) \\ Pole-Zero diagram')

%% 3.2 The issue of phase shifts and order

%% Zero phase shift filter (using filtfilt)

%create pure tone (10 rad/s)
fs = 2*Wh/(2*pi);
Ts = 5;
t = 0:1/fs:Ts;
w0 = 10;  % < 35 rad/s
f0 = w0/(2*pi);
s = cos(w0*t);

s_f = filter(b, a, s);
s_ff = filtfilt(b, a, s);

figure
subplot(2,1,1)
plot(t, s,  'Color', [1.00 0 0.00], 'LineWidth', 1);
hold on
plot(t, s_ff, 'Color', [0.00 0 1.00], 'LineWidth', 1);
hold on
xlim([0 5])
ylim([-1 1])
title('Pure tone (10 rad/s) filtered with zero phase shift (filtfilt)')
xlabel('Time [s]')
ylabel('Amplitude [-]')
p = legend('Original signal', 'Filtered signal', 1);
set(p,'FontSize', 8);
subplot(2,1,2)
plot(t, s,  'Color', [1.00 0 0.00], 'LineWidth', 1);
hold on
plot(t, s_f, 'Color', [0.00 0 1.00], 'LineWidth', 1);
hold on
xlim([0 5])
ylim([-1 1])
title('Pure tone (10 rad/s) filtered with non-zero phase shift (filter)')
xlabel('Time [s]')
ylabel('Amplitude [-]')
p = legend('Original signal', 'Filtered signal', 1);
set(p,'FontSize', 8);

%% Higher order filter

%higher filter order can be obtained via series connection/cascade
H_1 = H;
H_2 = H.*H;
H_3 = H.*H.*H;

figure %plot frequency response
subplot(2,1,1)
plot(w, abs(H_1), 'Color', [0.00 0 1.00], 'LineWidth', 1);
hold on
plot(w, abs(H_2), 'Color', [0.50 0 0.50], 'LineWidth', 1);
hold on
plot(w, abs(H_3), 'Color', [1.00 0 0.00], 'LineWidth', 1);
hold on
xlim([0 Wh])
ylim([0 1.05])
title('Magnitude response')
xlabel('Angular frequency [rad/s]')
ylabel('Magnitude [-]')
p = legend('Original', 'Two in series', 'Three in series', 1);
set(p,'FontSize', 8);
subplot(2,1,2)
plot(w, (180/pi)*angle(H_1), 'Color', [0.00 0 1.00], 'LineWidth', 1);
hold on
plot(w, (180/pi)*angle(H_2), 'Color', [0.50 0 0.50], 'LineWidth', 1);
hold on
plot(w, (180/pi)*angle(H_3), 'Color', [1.00 0 0.00], 'LineWidth', 1);
hold on
xlim([0 Wh])
ylim([-200 200])
title('Phase response')
xlabel('Angular frequency [rad/s]')
ylabel('Phase [degrees]')
p = legend('Original', 'Two in series', 'Three in series', 4);
set(p,'FontSize', 8);
