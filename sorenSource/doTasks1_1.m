close all
clear all
%% 1.1 Toolbox: Spectrum
% * write a function [Y, freq] = make_spectrum(signal, fs)
% in file 'make_spectrum.m'

% *Generate a sinusoid of frequency 1000 Hz and amplitude of 1 and pass the
% signal to your new function. Plot the result over the frequency and make
% sure the peak is on the correct frequency.
fs = 10000;
f = 1000;
t = 0:1/fs:1-1/fs;
x = sin( f * 2 * pi * t );

[ Y, F ] = make_spectrum( x, fs );
% normalize fft
Y = Y/length(Y);

figure(1)
stem( F, abs( Y ) );
title( '|Y| for FFT of 1s of 1kHz sine' );
xlabel( 'frequency [Hz]' );
ylabel( '|Y|' );
