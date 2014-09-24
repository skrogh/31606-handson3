function [ Y, F, dF ] = make_spectrum( signal, fs, window, zeropadBy )
%MAKE_SPECTRUM A wrapper function to return the fft of a signal and a
%vector containing frequencies
%   * 'signal' is a matrix with samples along columns and channels along rows
%   * 'fs' is the sample frequency (must be scalar)
%
%   optional arguments:
%   * 'window' is a column vector containing the window function to use. Use
%   matlabs build in windowgenerator functions to make these.
%   * 'zeropadBy'. The signal is zeropadded by this many zeros after
%   windowing

len = size(signal);
% if signal is row vector, transpose it
if ( len(1) == 1 )
    signal = signal';
    len = size(signal);
end

% apply window function
if exist('window', 'var')
    signal = signal .* repmat(window,1,len(2));
end

% zeropad
if exist('zeropadBy', 'var')
    signal = [ zeros(zeropadBy, len(2)); signal; zeros(zeropadBy, len(2)) ];
    len = size(signal);
end

% compute spectrum (note: it will be complex-valued).
Y = fft(signal);


% calculate df
timeTotal = len(1) / fs;
dF = 1/timeTotal;

F = [ 0 : dF : fs - dF]';
F(ceil(end/2)+1:end) = F(ceil(end/2)+1:end) - fs;


end

