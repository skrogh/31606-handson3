%% 1.1 placing poles part 1
P1 = 0.3; %pole at 0.3
P2 = 0.95; %pole at 0.95
P3 = 1.05; %pole at 1.05, unstable
P4 = -0.95; %pole at -0.95
%zeros at 0
Z1 = 0; Z2 = 0; Z3 = 0; Z4 = 0;

%plot the poles and zeros
figure(1)
h1 = subplot(2,2,1)
[hz1, hp1, ht1] = zplane(Z1,P1);
title( '\gamma_1 = 0.3' );
h2 = subplot(2,2,2)
[hz2, hp2, ht2] = zplane(Z2,P2);
title( '\gamma_1 = 0.95' );
h3 = subplot(2,2,3)
[hz3, hp3, ht3] = zplane(Z3,P3);
title( '\gamma_1 = 1.05' );
h4 = subplot(2,2,4)
[hz4, hp4, ht4] = zplane(Z4,P4);
title( '\gamma_1 = -0.95' );


%cosmetics
set(findobj(hz1, 'Type', 'line'), 'Color', 'b');
set(findobj(hp1, 'Type', 'line'), 'Color', 'b');
set(findobj(hz2, 'Type', 'line'), 'Color', 'g');
set(findobj(hp2, 'Type', 'line'), 'Color', 'g');
set(findobj(hz3, 'Type', 'line'), 'Color', 'r');
set(findobj(hp3, 'Type', 'line'), 'Color', 'r');
set(findobj(hz4, 'Type', 'line'), 'Color', 'm');
set(findobj(hp4, 'Type', 'line'), 'Color', 'm');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 10] );
saveas(gcf, './pics/ha6_1_1_zplane.eps', 'psc2');

%Impulse responses
A1 = poly(P1); B1 = poly(Z1); %Matlab terminology for {de,}numerator
A2 = poly(P2); B2 = poly(Z2);
A3 = poly(P3); B3 = poly(Z3);
A4 = poly(P4); B4 = poly(Z4);

%plot the responses
figure(2)
[H, T] = impz(B1,A1);
%stem(T, H, 'b', 'filled')
h1 = plot( T, H, 'b' );
hold on
[H, T] = impz(B2,A2);
%stem(T, H, 'g', 'filled')
h2 = plot( T, H, 'g' );
[H, T] = impz(B3,A3);
%stem(T, H, 'r', 'filled')
h3 = plot( T, H, 'r' );
[H, T] = impz(B4,A4);
%stem(T, H, 'm', 'filled')
h4 = plot( T, H, 'm' );
hold off
axis([0, 20, -1.5, 1.5])
set([h1,h2,h3,h4], 'Linewidth', 1)
title( 'Impulse responses' )
legend( '\gamma_1=0.3', '\gamma_1=0.95', '\gamma_1=1.05', '\gamma1=-0.95', 'Location', 'BestOutside' );
xlabel( 'sample nr.' );
ylabel( 'amplitude' );
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas( gcf, './pics/ha6_1_1_impz.eps', 'psc2' );

%plot frequency responses
figure(3)
[H1, T1] = freqz(B1,A1);
[H2, T2] = freqz(B2,A2);
[H3, T3] = freqz(B3,A3);
[H4, T4] = freqz(B4,A4);

subplot(2,1,1);
plot(T1/pi, 20*log10(abs(H1)), 'b' );
hold on
plot(T2/pi, 20*log10(abs(H2)), 'g' );
plot(T3/pi, 20*log10(abs(H3)), 'r' );
plot(T4/pi, 20*log10(abs(H4)), 'm' );
hold off
title( 'Frequency reponse' )
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Magnitude [dB]');
legend( '\gamma_1=0.3', '\gamma_1=0.95', '\gamma_1=1.05', '\gamma1=-0.95', 'Location', 'BestOutside' );
subplot(2,1,2);
plot(T1/pi, unwrap(angle(H1))*180/pi, 'b' );
hold on;
plot(T2/pi, unwrap(angle(H2))*180/pi, 'g' );
plot(T3/pi, unwrap(angle(H3))*180/pi, 'r' );
plot(T4/pi, unwrap(angle(H4))*180/pi, 'm' );
hold off;
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Phase [degrees]');
axis([0, 1, -80, 80])
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 8] );
saveas( gcf, './pics/ha6_1_1_freqz.eps', 'psc2' );

%% 1.1 placing poles part 2
clf(1); clf(2); clf(3);
%zplane expects column vectors
P1 = [0.3, 0.3]'; %poles at 0.3
P2 = [0.95, 0.95]'; %poles at 0.95
P3 = [1.05, 1.05]'; %poles at 1.05, unstable
P4 = [-0.95, -0.95]'; %poles at -0.95
%zeros at 0
Z1 = [0, 0]'; Z2 = [0, 0]'; Z3 = [0, 0]'; Z4 = [0, 0]';

%plot the poles and zeros
figure(1)
subplot(2,2,1)
[hz1, hp1, ht1] = zplane(Z1,P1);
title( '\gamma_{1,2} = 0.3' );
%axis([-1.5,1.5,-1.5,1.5],'square')
subplot(2,2,2)
[hz2, hp2, ht2] = zplane(Z2,P2);
title( '\gamma_{1,2} = 0.95' );
subplot(2,2,3)
[hz3, hp3, ht3] = zplane(Z3,P3);
title( '\gamma_{1,2} = 1.05' );
subplot(2,2,4)
[hz4, hp4, ht4] = zplane(Z4,P4);
title( '\gamma_{1,2} = -0.95' );

%cosmetics
set(findobj(hz1, 'Type', 'line'), 'Color', 'b');
set(findobj(hp1, 'Type', 'line'), 'Color', 'b');
set(findobj(hz2, 'Type', 'line'), 'Color', 'g');
set(findobj(hp2, 'Type', 'line'), 'Color', 'g');
set(findobj(hz3, 'Type', 'line'), 'Color', 'r');
set(findobj(hp3, 'Type', 'line'), 'Color', 'r');
set(findobj(hz4, 'Type', 'line'), 'Color', 'm');
set(findobj(hp4, 'Type', 'line'), 'Color', 'm');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 10] );
saveas(gcf, './pics/ha6_1_2_zplane.eps', 'psc2');

%Impulse responses
A1 = poly(P1); B1 = poly(Z1); %Matlab terminology for {de,}numerator
A2 = poly(P2); B2 = poly(Z2);
A3 = poly(P3); B3 = poly(Z3);
A4 = poly(P4); B4 = poly(Z4);

%plot the responses
figure(2)
[H, T] = impz(B1,A1);
%stem(T, H, 'b', 'filled', 'LineStyle', 'none')
plot(T, H, 'b' );
hold on
[H, T] = impz(B2,A2);
%stem(T, H, 'g', 'filled', 'LineStyle', 'none')
plot(T, H, 'g' );
[H, T] = impz(B3,A3);
%stem(T, H, 'r', 'filled', 'LineStyle', 'none')
plot( T, H, 'r' );
[H, T] = impz(B4,A4);
%stem(T, H, 'm', 'filled', 'LineStyle', 'none')
plot( T, H, 'm' );
hold off
axis([0, 100, -10, 10])
title( 'Impulse responses' )
legend( '\gamma_{1,2}=0.3', '\gamma_{1,2}=0.95', '\gamma_{1,2}=1.05', '\gamma{1,2}=-0.95','Location', 'BestOutside' );
xlabel( 'sample nr.' );
ylabel( 'amplitude' );
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas( gcf, './pics/ha6_1_2_impz.eps', 'psc2' );

%plot frequency responses
figure(3)
[H1, T1] = freqz(B1,A1);
[H2, T2] = freqz(B2,A2);
[H3, T3] = freqz(B3,A3);
[H4, T4] = freqz(B4,A4);

subplot(2,1,1);
plot(T1/pi, 20*log10(abs(H1)), 'b' );
hold on
plot(T2/pi, 20*log10(abs(H2)), 'g' );
plot(T3/pi, 20*log10(abs(H3)), 'r' );
plot(T4/pi, 20*log10(abs(H4)), 'm' );
hold off
title( 'Frequency reponse' )
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Magnitude [dB]');
legend( '\gamma_1=0.3', '\gamma_1=0.95', '\gamma_1=1.05', '\gamma1=-0.95', 'Location', 'BestOutside' );
subplot(2,1,2);
plot(T1/pi, unwrap(angle(H1))*180/pi, 'b' );
hold on;
plot(T2/pi, unwrap(angle(H2))*180/pi, 'g' );
plot(T3/pi, unwrap(angle(H3))*180/pi, 'r' );
plot(T4/pi, unwrap(angle(H4))*180/pi, 'm' );
hold off;
axis([0, 1, -160, 160])
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Phase [degrees]');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 8] );
saveas( gcf, './pics/ha6_1_2_freqz.eps', 'psc2' );

%% 1.1 placing poles part 3
clf(1); clf(2); clf(3); 
%poles
P1 = [0.75+0.4i, 0.75-0.4i]'; %0.75+-0.4i
P2 = [0.75+0.75i, 0.75-0.75i]'; %0.75+-0.75i
P3 = [-0.75+0.4i, -0.75-0.4i]'; %-0.75+-0.4i
%zeros
Z1 = [0, 0]'; Z2 = [0, 0]'; Z3 = [0, 0]';

%plot the poles and zeros
figure(1)
subplot(2,2,1)
[hz1, hp1, ht1] = zplane(Z1,P1);
title( '\gamma_{1,2} = 0.75 \pm 0.4i' );
%axis([-1.5,1.5,-1.5,1.5],'square')
subplot(2,2,2)
[hz2, hp2, ht2] = zplane(Z2,P2);
title( '\gamma_{1,2} = 0.75 \pm 0.75i' );
subplot(2,2,3)
[hz3, hp3, ht3] = zplane(Z3,P3);
title( '\gamma_{1,2} = -0.75 \pm 0.4i' );

%cosmetics
set(findobj(hz1, 'Type', 'line'), 'Color', 'b');
set(findobj(hp1, 'Type', 'line'), 'Color', 'b');
set(findobj(hz2, 'Type', 'line'), 'Color', 'g');
set(findobj(hp2, 'Type', 'line'), 'Color', 'g');
set(findobj(hz3, 'Type', 'line'), 'Color', 'r');
set(findobj(hp3, 'Type', 'line'), 'Color', 'r');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 10] );
saveas(gcf, './pics/ha6_1_3_zplane.eps', 'psc2');

%Impulse responses
A1 = poly(P1); B1 = poly(Z1); %Matlab terminology for {de,}numerator
A2 = poly(P2); B2 = poly(Z2);
A3 = poly(P3); B3 = poly(Z3);

%plot the responses
figure(2)
[H, T] = impz(B1,A1);
%stem(T, H, 'b', 'filled', 'LineStyle', 'none')
plot( T, H, 'b' );
hold on
[H, T] = impz(B2,A2);
plot( T, H, 'g' );
%stem(T, H, 'g', 'filled', 'LineStyle', 'none')
[H, T] = impz(B3,A3);
%stem(T, H, 'r', 'filled', 'LineStyle', 'none')
plot( T, H, 'r' );
hold off;
axis([0, 30, -10, 10])
title( 'Impulse responses' )
legend( '\gamma_{1,2}=0.75\pm0.4i', '\gamma_{1,2}=0.75\pm0.75i', '\gamma_{1,2}=-0.75\pm0.4i', 'Location', 'BestOutside' );
xlabel( 'sample nr.' );
ylabel( 'amplitude' );
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas( gcf, './pics/ha6_1_3_impz.eps', 'psc2' );

%plot frequency responses
figure(3)
[H1, T1] = freqz(B1,A1);
[H2, T2] = freqz(B2,A2);
[H3, T3] = freqz(B3,A3);

subplot(2,1,1);
plot(T1/pi, 20*log10(abs(H1)), 'b' );
hold on
plot(T2/pi, 20*log10(abs(H2)), 'g' );
plot(T3/pi, 20*log10(abs(H3)), 'r' );
hold off
title( 'Frequency reponse' )
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Magnitude [dB]');
legend( '\gamma_{1,2}=0.75\pm0.4i', '\gamma_{1,2}=0.75\pm0.75i', '\gamma_{1,2}=-0.75\pm0.4i', 'Location', 'BestOutside' );
subplot(2,1,2);
plot(T1/pi, unwrap(angle(H1))*180/pi, 'b' );
hold on;
plot(T2/pi, unwrap(angle(H2))*180/pi, 'g' );
plot(T3/pi, unwrap(angle(H3))*180/pi, 'r' );
plot(T4/pi, unwrap(angle(H4))*180/pi, 'm' );
hold off;
axis([0, 1, -160, 160])
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Phase [degrees]');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 8] );
saveas( gcf, './pics/ha6_1_3_freqz.eps', 'psc2' );

%% Vary magnitude of 0.75+-0.75i
clf(1); clf(2); clf(3);
Porg = [0.7*(1+i),0.7*(1-i)]'; %close to unit circle
Zorg = [0, 0]';
%convert to polar
Corg = abs(Porg);
thetaOrg = abs(unwrap(angle(Porg))); 
thetaOrg = thetaOrg(1);%get scalar
thetaOrg = thetaOrg;
theta1 = 0.2618; %vary theta by 30 degrees down
theta2 = 1.3090; % and up
thetaOrg = [thetaOrg; -thetaOrg]; %back to pole pair
theta1 = [theta1; -theta1];
theta2 = [theta2; -theta2];

%varying strength of pole pair
P1 = Corg.*exp(i*thetaOrg); %org pole
P2 = Corg*0.75.*exp(i*thetaOrg); %same angle 75% magnitude
P3 = Corg*0.5.*exp(i*thetaOrg); %same angle 50% magnitude
P4 = Corg*0.25.*exp(i*thetaOrg); %same angle 25% magnitude
P5 = Corg*0.75.*exp(i*theta1);
P6 = Corg*0.75.*exp(i*theta2);
%zeros all 0
Z1 = Zorg; Z2 = Zorg; Z3 = Zorg; Z4 = Zorg; Z5 = Zorg; Z6 = Zorg;

%plot the poles and zeros
figure(1)
subplot(3,2,1)
[hz1, hp1, ht1] = zplane(Z1,P1);
title( 'C=0.99, \theta=45^\circ' )
%axis([-1.5,1.5,-1.5,1.5],'square')
subplot(3,2,2)
[hz2, hp2, ht2] = zplane(Z2,P2);
title( 'C=0.74, \theta=45^\circ' )
subplot(3,2,3)
[hz3, hp3, ht3] = zplane(Z3,P3);
title( 'C=0.50, \theta=45^\circ' )
subplot(3,2,4)
[hz4, hp4, ht4] = zplane(Z4,P4);
title( 'C=0.25, \theta=45^\circ' )
subplot(3,2,5)
[hz5, hp5, ht5] = zplane(Z5,P5);
title( 'C=0.74, \theta=15^\circ' )
subplot(3,2,6)
[hz6, hp6, ht6] = zplane(Z6,P6);
title( 'C=0.74, \theta=75^\circ' )

%cosmetics
set(findobj(hz1, 'Type', 'line'), 'Color', 'b');
set(findobj(hp1, 'Type', 'line'), 'Color', 'b');
set(findobj(hz2, 'Type', 'line'), 'Color', 'g');
set(findobj(hp2, 'Type', 'line'), 'Color', 'g');
set(findobj(hz3, 'Type', 'line'), 'Color', 'r');
set(findobj(hp3, 'Type', 'line'), 'Color', 'r');
set(findobj(hz4, 'Type', 'line'), 'Color', 'm');
set(findobj(hp4, 'Type', 'line'), 'Color', 'm');
set(findobj(hz5, 'Type', 'line'), 'Color', 'k');
set(findobj(hp5, 'Type', 'line'), 'Color', 'k');
set(findobj(hz6, 'Type', 'line'), 'Color', 'c');
set(findobj(hp6, 'Type', 'line'), 'Color', 'c');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 10] );
saveas(gcf, './pics/ha6_1_4_zplane.eps', 'psc2');

%Impulse responses
A1 = poly(P1); B1 = poly(Z1); %Matlab terminology for {de,}numerator
A2 = poly(P2); B2 = poly(Z2);
A3 = poly(P3); B3 = poly(Z3);
A4 = poly(P4); B4 = poly(Z4);
A5 = poly(P5); B5 = poly(Z5);
A6 = poly(P6); B6 = poly(Z6);

%plot the responses
figure(2)
[H, T] = impz(B1,A1);
plot(T, H, 'b' );
hold on
[H, T] = impz(B2,A2);
plot(T, H, 'g' );
[H, T] = impz(B3,A3);
plot( T, H, 'r' );
[H, T] = impz(B4,A4);
plot( T, H, 'm' );
[H, T] = impz(B5,A5);
plot( T, H, 'k' );
[H, T] = impz(B6,A6);
plot( T, H, 'c' );
hold off
axis([0, 20, -3, 3])
title( 'Impulse responses' )
legend( 'C=0.99,\theta=45^\circ', 'C=0.74,\theta=45^\circ', 'C=0.50,\theta=45^\circ', 'C=0.25,\theta=45^\circ', 'C=0.74,\theta=15^\circ', 'C=0.75,\theta=75^\circ', 'Location', 'BestOutside' );
xlabel( 'sample nr.' );
ylabel( 'amplitude' );
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas( gcf, './pics/ha6_1_4_impz.eps', 'psc2' );

%plot frequency responses
figure(3)
[H1, T1] = freqz(B1,A1);
[H2, T2] = freqz(B2,A2);
[H3, T3] = freqz(B3,A3);
[H4, T4] = freqz(B4,A4);
[H5, T5] = freqz(B5,A5);
[H6, T6] = freqz(B6,A6);
subplot(2,1,1);
plot(T1/pi, 20*log10(abs(H1)), 'b' );
hold on
plot(T2/pi, 20*log10(abs(H2)), 'g' );
plot(T3/pi, 20*log10(abs(H3)), 'r' );
plot(T4/pi, 20*log10(abs(H4)), 'm' );
plot(T5/pi, 20*log10(abs(H5)), 'k' );
plot(T6/pi, 20*log10(abs(H6)), 'c' );
hold off
title( 'Frequency reponse' )
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Magnitude [dB]');
legend( 'C=0.99,\theta=45^\circ', 'C=0.74,\theta=45^\circ', 'C=0.50,\theta=45^\circ', 'C=0.25,\theta=45^\circ', 'C=0.74,\theta=15^\circ', 'C=0.75,\theta=75^\circ', 'Location', 'BestOutside' );
subplot(2,1,2);
plot(T1/pi, unwrap(angle(H1))*180/pi, 'b' );
hold on;
plot(T2/pi, unwrap(angle(H2))*180/pi, 'g' );
plot(T3/pi, unwrap(angle(H3))*180/pi, 'r' );
plot(T4/pi, unwrap(angle(H4))*180/pi, 'm' );
plot(T5/pi, unwrap(angle(H5))*180/pi, 'k' );
plot(T6/pi, unwrap(angle(H6))*180/pi, 'c' );
hold off;
axis([0, 1, -160, 160])
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Phase [degrees]');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 8] );
saveas( gcf, './pics/ha6_1_4_freqz.eps', 'psc2' );

%% 1.1 part 4 zeros instead of poles
clf(1); clf(2); clf(3); 
%poles
P1 = [0.75+0.4i, 0.75-0.4i]'; %0.75+-0.4i
P2 = [0, 0]'; 
%zeros
Z1 = [0, 0]'; Z2 = [0.75+0.4i, 0.75-0.4i]';

%plot the poles and zeros
figure(1)
subplot(1,2,1)
[hz1, hp1, ht1] = zplane(Z1,P1);
title('Pole \gamma_{1,2}=0.75\pm0.4i');
%axis([-1.5,1.5,-1.5,1.5],'square')
subplot(1,2,2)
[hz2, hp2, ht2] = zplane(Z2,P2);
title('Zero \gamma_{1,2}=0.75\pm0.4i');

%cosmetics
set(findobj(hz1, 'Type', 'line'), 'Color', 'b');
set(findobj(hp1, 'Type', 'line'), 'Color', 'b');
set(findobj(hz2, 'Type', 'line'), 'Color', 'g');
set(findobj(hp2, 'Type', 'line'), 'Color', 'g');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas(gcf, './pics/ha6_1_5_zplane.eps', 'psc2');

%Impulse responses
A1 = poly(P1); B1 = poly(Z1); %Matlab terminology for {de,}numerator
A2 = poly(P2); B2 = poly(Z2);

%plot the responses
figure(2)
[H, T] = impz(B1,A1);
%stem(T, H, 'b', 'filled', 'LineStyle', 'none')
plot( T, H, 'b' );
hold on
[H, T] = impz(B2,A2);
%stem(T, H, 'g', 'filled', 'LineStyle', 'none')
plot( T, H, 'g' );
hold off;
axis([0, 20, -10, 10])
title( 'Impulse responses' )
legend( 'Poles', 'Zeros', 'Location', 'BestOutside' );
xlabel( 'sample nr.' );
ylabel( 'amplitude' );
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 4] );
saveas( gcf, './pics/ha6_1_5_impz.eps', 'psc2' );

%plot frequency responses
figure(3)
[H1, T1] = freqz(B1,A1);
[H2, T2] = freqz(B2,A2);

subplot(2,1,1);
plot(T1/pi, 20*log10(abs(H1)), 'b' );
hold on
plot(T2/pi, 20*log10(abs(H2)), 'g' );
hold off
title( 'Frequency reponse' )
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Magnitude [dB]');
legend( 'Poles', 'Zeros', 'Location', 'BestOutside' );
subplot(2,1,2);
plot(T1/pi, unwrap(angle(H1))*180/pi, 'b' );
hold on;
plot(T2/pi, unwrap(angle(H2))*180/pi, 'g' );
hold off;
axis([0, 1, -160, 160])
xlabel( 'Normalized frequency [pi rad / sample]');
ylabel('Phase [degrees]');
set(gcf, 'paperunits', 'centimeters', 'Paperposition', [0, 0, 14, 8] );
saveas( gcf, './pics/ha6_1_5_freqz.eps', 'psc2' );
