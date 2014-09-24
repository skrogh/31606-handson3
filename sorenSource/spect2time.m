function [ synTime, T ] = spect2time( synFreq, fs, len )
%SPECT2TIME Genreates a timeseries signal from spectrum synFreq and
%   extends/truncates to length

synFreq = synFreq*length(synFreq);

% generate time signal
synTime = ifft( synFreq );

% resize signal
synTime = repmat( synTime, ceil( fs*len/length(synTime) ), 1 );
synTime = synTime(1:fs*len);

%genreate time vector
T = 0:1/fs:length(synTime)/fs-1/fs;

end

