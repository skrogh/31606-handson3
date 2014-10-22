%% 2.1 bounce bounce

% setup some parameters:
Fs = 44100; % in Hz
delay = 0.03; % in s
delayZ = round(Fs*delay); % delay in samples.
% note that this only allows delays in multiples of 1/Fs
% if we want a more precise delay, we cound use interpolation
alpha = 0.6; % dampening

%%  FIR delay:
b = [1; zeros(delayZ-1,1); alpha];
a = 1;

impz(b,a,Fs*2,Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/firDelay30imp.eps','psc2')

freqz(b,a,linspace(0,500,20000),Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/firDelay30freq.eps','psc2')


%%  IIR delay:
a = [1; zeros(delayZ-1,1); -alpha];
b = 1;
impz(b,a,Fs*2,Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/iirDelay30imp.eps','psc2')

freqz(b,a,linspace(0,500,20000),Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/iirDelay30freq.eps','psc2')

%% Different delay times
delay = 0.01; % in s
delayZ = round(Fs*delay); % delay in samples.
%  IIR delay:
a = [1; zeros(delayZ-1,1); -alpha];
b = 1;
impz(b,a,Fs*2,Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/iirDelay10imp.eps','psc2')

freqz(b,a,linspace(0,500,20000),Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/iirDelay10freq.eps','psc2')

delay = 0.2; % in s
delayZ = round(Fs*delay); % delay in samples.
%  IIR delay:
a = [1; zeros(delayZ-1,1); -alpha];
b = 1;
impz(b,a,Fs*2,Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 5])
saveas(gcf,'./pics/iirDelay200imp.eps','psc2')

freqz(b,a,linspace(0,500,20000),Fs)
set(gca,'Fontsize',10)
set(gcf,'paperunits','centimeters','Paperposition',[0 0 15 10])
saveas(gcf,'./pics/iirDelay200freq.eps','psc2')