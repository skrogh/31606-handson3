function [B] = Bspline(L, n); %Inputs: Length (L), order (n). Outputs: B-spline (B).
h = ones(L,1); %create ones
B = h;
if n ~= 0 
   for k = 1:n    %convolve recursively n times
       B = conv(B,h);
   end
end
B = B/norm(B,1); %normalize
end %eof