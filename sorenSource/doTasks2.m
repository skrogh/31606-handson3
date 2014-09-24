close all
clear all
%% 2 Low bitrate telephone transmission

% * generate column vector of ones:
h0 = ones(7,1);
h1 = conv( h0, h0 );
h2 = conv( h1, h0 );
h3 = conv( h2, h0 );

% * normalize
h0 = h0/norm( h0, 1 ); % normalize along first dimention
h1 = h1/norm( h1, 1 ); % normalize along first dimention
h2 = h2/norm( h2, 1 ); % normalize along first dimention
h3 = h3/norm( h3, 1 ); % normalize along first dimention

% * plot some bsplines
figure(1)
plot(h0);
hold on
plot(h1, 'r');
plot(h2, 'g');
plot(h3, 'k');

% * frequency respones of Bsplines
fs = 44100;
zeroPad = 10000;

figure(2)
[ Y, F, dF ] = make_spectrum( [ zeros( zeroPad, 1 ); h0; zeros( zeroPad, 1 ) ], fs );
Y = [ Y(floor(end/2)+2:end) ; Y(1:floor(end/2)+1) ];
F = [ F(floor(end/2)+2:end) ; F(1:floor(end/2)+1) ];
plot( F, abs(Y) );
hold on
[ Y, F, dF ] = make_spectrum( [ zeros( zeroPad, 1 ); h1; zeros( zeroPad, 1 ) ], fs );
Y = [ Y(floor(end/2)+2:end) ; Y(1:floor(end/2)+1) ];
F = [ F(floor(end/2)+2:end) ; F(1:floor(end/2)+1) ];
plot( F, abs(Y), 'r' );
[ Y, F, dF ] = make_spectrum( repmat( h3, 10, 1 ), fs ); % [ zeros( zeroPad, 1 ); h2; zeros( zeroPad, 1 ) ]
Y = [ Y(floor(end/2)+2:end) ; Y(1:floor(end/2)+1) ];
F = [ F(floor(end/2)+2:end) ; F(1:floor(end/2)+1) ];
plot( F, abs(Y), 'g' );
[ Y, F, dF ] = make_spectrum( [ zeros( zeroPad, 1 ); h3; zeros( zeroPad, 1 ) ], fs );
Y = [ Y(floor(end/2)+2:end) ; Y(1:floor(end/2)+1) ];
F = [ F(floor(end/2)+2:end) ; F(1:floor(end/2)+1) ];
plot( F, abs(Y), 'k' );
% plot lines for our band
line( [fs/7, fs/7], [ 0, 1 ] )
line( [-fs/7, -fs/7], [ 0, 1 ] )

% * attennuation at 1, 4 and 5kHz
[ Y, F, dF ] = make_spectrum( [ zeros( zeroPad, 1 ); h3; zeros( zeroPad, 1 ) ], fs );
mag_1k = abs(Y(round(1000/dF)))
mag_4k = abs(Y(round(4000/dF)))
mag_5k = abs(Y(round(5000/dF)))

stem( [ F(round(1000/dF)), F(round(4000/dF)), F(round(5000/dF)) ], ...
[ mag_1k, mag_4k, mag_5k ], 'r' );