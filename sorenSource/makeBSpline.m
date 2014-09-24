function [ spline ] = makeBSpline( a, n )
%MAKEBSPLINE Creates a b spline of length a and order n
h0 = ones( a, 1 );
spline = ones( a, 1 );
for i=1:n
    spline = conv( spline, h0 );
end

spline = spline / norm( spline, 1 );


end

