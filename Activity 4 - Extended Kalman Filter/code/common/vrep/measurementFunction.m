function [h, H_x] = measurementFunction(x, m)
% [h, H_x] = measurementFunction(x, m) returns the predicted measurement
% given a state x and a single map entry m. H_x denotes the Jacobian of the
% measurement function with respect to the state evaluated at the state
% provided.
% Map entry and state are defined according to "Introduction to Autonomous Mobile Robots" pp. 337

%STARTRM
%==============================================================================
% interpretation of input parameters
%==============================================================================
% x = [x y th]'
%--------------------------
% r = x*cos(a) + y*sin(a)
% m = []
% m = [m; a0 a1 a2 ... an];
% m = [m; r0 r1 r2 ... rn];
%==============================================================================
% model a measurement ẑ as if the robot is in state x (robot coordinate frame)
%==============================================================================
h = [];
N = length(m(1,:));
% m(1,i) = alpha(i)
% m(2,i) = r(i)
% x(1) = x
% x(2) = y
% x(3) = th
for i=1:N
    h(1,i) = m(1,i) - x(3);
    h(2,i) = m(2,i) - (x(1)*cos(m(1,i)) + x(2)*sin(m(1,i)));
end
%==============================================================================
% calculus of the Jacobian Ĥ of the measurement model
%==============================================================================
% m(1,i) = alpha(i)
H_x = [];
H_x = [H_x;         0             0        -1 ];
H_x = [H_x;   -cos(m(1,i))   -sin(m(1,i))   0 ];
%==============================================================================
%ENDRM

[h(1), h(2), isRNegated] = normalizeLineParameters(h(1), h(2));

if isRNegated
    H_x(2, :) = - H_x(2, :);
end
