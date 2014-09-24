function [Y_dB] = to_dB(Y);
%conversion to decibel logarithmic scale
Y_dB = 20*log10(abs(Y));
%eof
end