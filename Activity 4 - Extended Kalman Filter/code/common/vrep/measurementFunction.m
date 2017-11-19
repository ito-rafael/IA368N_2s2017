function [h, H_x] = measurementFunction(x, m)
% [h, H_x] = measurementFunction(x, m) returns the predicted measurement
% given a state x and a single map entry m. H_x denotes the Jacobian of the
% measurement function with respect to the state evaluated at the state
% provided.
% Map entry and state are defined according to "Introduction to Autonomous Mobile Robots" pp. 337

%STARTRM
%==============================================================================
% x = [x y th]'
%--------------------------
% r = x*cos(a) + y*sin(a)
% m = []
% m = [m; a0 a1 a2 ... an];
% m = [m; r0 r1 r2 ... rn];
%==============================================================================
h = #;
%==============================================================================
H_x = #;
%==============================================================================
%ENDRM

[h(1), h(2), isRNegated] = normalizeLineParameters(h(1), h(2));

if isRNegated
    H_x(2, :) = - H_x(2, :);
end
