close all
clear all
%% 1.3 Fourier transform of a recorded signal
% Load wave file
[piano, pianoFs, pianoNbits] = wavread( 'piano.wav' );

pianoT = 0:1/pianoFs:length(piano)/pianoFs - 1/pianoFs;

% * Plot time signal from 0s to 1s
figure('Name','fig:1-3-1s','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( pianoT, piano );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis([0 1 min(piano) max(piano)])
% add labels
title('piano note from 0s - 1s')
xlabel('time / s')
ylabel('amplitude / a.u.')
%save
saveas(gcf,'./pics/1-3-1s.eps','psc2')

% * Plot time signal from 0.95s to 1s
figure('Name','fig:1-3-period','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( pianoT, piano );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis([0.95 1 min(piano(pianoFs*0.95:pianoFs)) max(piano(pianoFs*0.95:pianoFs))])
% add labels
title('pianonote from 0.9s - 1s')
xlabel('time / s')
ylabel('amplitude / a.u.')
%save
saveas(gcf,'./pics/1-3-period.eps','psc2')

% * Plot spectrum of whole signal on double log axis
[ Y, F ] = make_spectrum( piano, pianoFs );
% normalize fft
Y = Y * 2;

% * Plot spectrum log
figure('Name','fig:1-3-log','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = semilogx( F(1:end/2), mag2db(abs(Y(1:end/2))) );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis tight
% add labels
title('piano note spectrum on log frequency axis')
xlabel('frequency / Hz')
ylabel('amplitude / dB')
%save
saveas(gcf,'./pics/1-3-log.eps','psc2')

% * Plot spectrum lin
figure('Name','fig:1-3-lin','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( F(1:end/2), mag2db(abs(Y(1:end/2))) );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis tight
% add labels
title('piano note spectrum on linear frequency axis')
xlabel('frequency / Hz')
ylabel('amplitude / dB')
%save
saveas(gcf,'./pics/1-3-lin.eps','psc2')

figure(10)
% * plot with index along x to extract index of peak freq.
plot( mag2db(abs(Y(1:end/2))) )
% Set custom data curser callback. New callback increases resolution on
% readout to 10 decimals (instead of 4)
set(datacursormode,'UpdateFcn',@curserUpdate10);
axis tight

% manually read indexes
peakIndex = [ 1211, 2424, 3639, 4853, 6064, 7284, 8503, 9725, 10950, 12178, ...
   13409, 14637, 15883, 17130, 18382, 19629, 20893, 22155, 23434, 24707, ...
   25997, 27285, 28592, 29898, 31216, 32538, 34264, 35219, 36579, 37963, ...
   39310, 40685 ]; 

% * generate with phase 0 for all signals

% generate frequency and phase vectors
freqVect = F( peakIndex );
amplVect = abs( Y( peakIndex ) );
% get base freq
f_0 = freqVect(1)

[ synFreq, F_ ] = generateSpectrum( f_0:f_0:f_0*length(freqVect)-f_0, amplVect, f_0/10, pianoFs );

% * Plot perfect harmonics
figure('Name','fig:1-3-zpph_fft','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( F(1:end/2), mag2db(abs(Y(1:floor(end/2)))) );
hold on
axis( [ 0 4500 -150 -30 ] );
h2 = stem( F_(1:end/2), mag2db( abs( synFreq(1:floor(end/2)) )*2 ), 'r' );
%setting some cosmetics
set(h1, 'linewidth',1)
set(h2, 'linewidth',1)
set(gca,'Fontsize',10)
% add labels
title('spectrum of original piano note and synthesized note with perfect harmonics')
xlabel('frequency / Hz')
ylabel('amplitude / dB')
%save
saveas(gcf,'./pics/1-3-zpph_fft.eps','psc2')


[ synTime, T ] = spect2time( synFreq, pianoFs, 2 );
% * Plot perfect harmonics, time domain
figure('Name','fig:1-3-zpph_time','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( T, [ real(synTime), imag(synTime) ] );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis tight
xlim( [ 0.95 1 ] )
% add labels
title('synthesized signal from 0.95s - 1s with perfect harmonics and zero-phase')
xlabel('time / s')
ylabel('amplitude / a.u.')
%save
saveas(gcf,'./pics/1-3-zpph_time.eps','psc2')



% * generate with correct for all signals
% generate frequency and phase vectors
freqVect = F( peakIndex );
amplVect = Y( peakIndex );

[ synFreq, F_ ] = generateSpectrum( f_0:f_0:f_0*length(freqVect)-f_0, amplVect, 1/100, pianoFs );

% make plots
[ synTime, T ] = spect2time( synFreq, pianoFs, 2 );
% * Plot perfect harminics with phase, time domain
figure('Name','fig:1-3-nzpph_time','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( T, [ real(synTime), imag(synTime) ] );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis tight
xlim( [ 0.95 1 ] )
% add labels
title('synthesized signal from 0.95s - 1s with perfect harmonics and non-zero-phase')
xlabel('time / s')
ylabel('amplitude / a.u.')
%save
saveas(gcf,'./pics/1-3-nzpph_time.eps','psc2')


%% bonus
% * generate with phase 0 for all signals

% generate frequency and phase vectors - frequency as read
freqVect = F( peakIndex );
amplVect = abs( Y( peakIndex ) );
% get base freq
f_0 = freqVect(1)

[ synFreq, F_ ] = generateSpectrum( freqVect, amplVect, 1/100, pianoFs );

figure(11)
subplot(2,1,1)
plot( F(1:end/2), mag2db(abs(Y(1:end/2))) )
hold on
stem( F_(1:end/2), mag2db( abs( synFreq(1:end/2) )*2 ), 'r' );
axis tight

subplot(2,1,2)
[ synTime, T ] = spect2time( synFreq, pianoFs, 2 );
plot( T, real(synTime) );
hold on
plot( T, imag(synTime), 'r' );
axis tight

% * generate with correct for all signals - frequency as read
% generate frequency and phase vectors
freqVect = F( peakIndex );
amplVect = Y( peakIndex );

[ synFreq, F_ ] = generateSpectrum( freqVect, amplVect, 1/100, pianoFs );

% * Plot imperfect harmonics, spectrum
figure('Name','fig:1-3-nzpih_fft','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( F(1:end/2), mag2db(abs(Y(1:floor(end/2)))) );
hold on
axis( [ 0 4500 -150 -30 ] );
h2 = stem( F_(1:end/2), mag2db( abs( synFreq(1:floor(end/2)) )*2 ), 'r' );
%setting some cosmetics
set(h1, 'linewidth',1)
set(h2, 'linewidth',1)
set(gca,'Fontsize',10)
% add labels
title('spectrum of original piano note and synthesized note with imperfect harmonics')
xlabel('frequency / Hz')
ylabel('amplitude / dB')
%save
saveas(gcf,'./pics/1-3-nzpih_fft.eps','psc2')


[ synTime, T ] = spect2time( synFreq, pianoFs, 10 );
% * Plot imperfect harmonics, time domain
figure('Name','fig:1-3-nzpih_time','Position',[0 0 1500 500])
% define papersize for export
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
% make plot
h1 = plot( T, [ real(synTime), imag(synTime) ] );
%setting some cosmetics
set(h1, 'linewidth',1)
set(gca,'Fontsize',10)
axis tight
xlim( [ 0.25 0.5 ] )
% add labels
title('synthesized signal from 0.25s - 0.5s with imperfect harmonics and zero-phase')
xlabel('time / s')
ylabel('amplitude / a.u.')
%save
saveas(gcf,'./pics/1-3-nzpih_time.eps','psc2')

