function [Y, freq] = spectrum(X, fs); 
%INPUT: Signal (X), sampling frequency (fs). OUTPUT: FFT (Y), frequency vector (freq).
Y = fft(X);         %compute spectrum
Y = 2*Y/length(Y);  %physical scaling
T = length(X)/fs;   %signal sample time
delta_f = 1/T;      %sample increment
freq = [0:delta_f:fs/2,-fs/2:delta_f:0-delta_f];  %frequency vector
end %eof