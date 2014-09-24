close all
clear all
%% 1.2 Fourier transform of a synthetic signal
% * Synthesize a certain signal:

fs = 2^10*100*3; % higest frequency is 2^10*100Hz.
t = 0:1/fs:2-1/fs;
f0 = 100;

s = zeros( 1, length(t) );
for k = 0:10
    s = s + cos( 2*pi*2^k*f0*t + k * pi/3 );
end

% * Plot from 0.9s to 0.93s
part = round(0.9*fs) : round(0.93*fs);
figure(1)
plot( t(part), s(part) );
title( 'Complex signal from 0.9s ot 0.93s' );
xlabel( 'Time [s]' );
ylabel( 'Amplitude' );
axis 'tight'

% * Plot fft
[ Y, F, dF ] = make_spectrum( s, fs );
F = F( 1 : floor(length(F)/2) );
Y = Y( 1 : length(F) );
% normalize fft
Y = Y / length(Y);

figure(2)
subplot(1,3,1);
plot( F, abs(Y) );
axis 'tight'
subplot(1,3,2);
plot( F, real(Y) );
axis 'tight'
subplot(1,3,3);
plot( F, imag(Y) );
axis 'tight'

% * same but with semilox x axis
figure(3)
semilogx( F, abs(Y) );
hold on
stem( 100, max(abs(Y)), 'r' );
semilogx( F, abs(Y) ); % lazy put on top
axis 'tight'
% plot the read circle:

% * same but centered arround 400 hz
part = round(395/dF) : round(405/dF);
figure(4)
subplot(1,1,1);
plot( F(part), abs(Y(part)) );
hold on
stem( 400, max(abs(Y)), 'r' );
axis 'tight'
% plot the read circle:



