function [ Y, freq ] = make_spectrum( signal, fs )
%MAKE_SPECTRUM Returns Y, the spectrum values at times in freq
%   Detailed explanation goes here
%Compute the spectrum (complex valued)
Y = fft( signal );

% The fft needs to be scaled in order to give a physically plausible
% scaling ( why? )
Y = Y/length(Y);
  %NOTE: Don't do this when ifft is wanted, there length(Y)/2 must be used
  %instead

% Frequency vector
T = length(signal)/fs; %signal sample time
dF = 1/T; %frequency resolution
F = [ 0 : dF : fs - dF]';
F(ceil(end/2)+1:end) = F(ceil(end/2)+1:end) - fs;


end