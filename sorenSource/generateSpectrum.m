function [ synFreq, F ] = generateSpectrum( freqVect, amplVect, dF, fs )
%GENERATE_SPECTRUM genereates the spectrum from a list of frequencies and
%amplitudes that fits the best into the spectrum of resolution dF
%   freqVect and amplVect is the frequency and amplitude vectors
%   dF is the desired spectrum resolution
%   fs is the sample frequency

% choose nearest dF, that gives an integer number of samples:
dF =  fs / round(fs/dF);

% generate a vector of zeros for us to set the magnitudes in:
synFreq = zeros( round(fs/dF), 1 );

% set bin value for the bin closest to each specified frequency:
for i = 1:length(freqVect)
    % positive frequency
    synFreq( 1 + round((freqVect(i))/dF) ) = amplVect( i )/2;
    % negative frequency
    synFreq( end + 1 - round((freqVect(i))/dF) ) = conj(amplVect( i )/2);
end

% genreate frequeny vector
F = ( 0 : dF : fs - dF )';
F(ceil(end/2)+1:end) = F(ceil(end/2)+1:end) - fs;

end

