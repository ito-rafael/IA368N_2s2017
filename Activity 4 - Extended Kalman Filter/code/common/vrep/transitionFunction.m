function [f, F_x, F_u] = transitionFunction(x,u, l)
% [f, F_x, F_u] = transitionFunction(x,u,l) predicts the state x at time t given
% the state at time t-1 and the input u at time t. F_x denotes the Jacobian
% of the state transition function with respect to the state evaluated at
% the state and input provided. F_u denotes the Jacobian of the state
% transition function with respect to the input evaluated at the state and
% input provided.
% State and input are defined according to "Introduction to Autonomous Mobile Robots", pp. 337

%STARTRM
%==============================================================================
% x = [x y th]'
% u = [sl sr]'
delta_sl = u(1);
delta_sr = u(2);
delta_s  = (u(2) + u(1)) / 2;
delta_th = (u(2) - u(1)) / (2*l);
theta    = x(3,1);
%==============================================================================
% "a priori" estimate of the current state
f = [];
f = [f; x(1) +  delta_s * cos(theta + delta_th) ];
f = [f; x(2) +  delta_s * sin(theta + delta_th) ];
f = [f; x(3) +          (2 * delta_th)          ];
%==============================================================================
% calculate the Jacobian of function f with respect to x (x,y,th)
F_x = [];
F_x = [F_x; 1 0 -delta_s * sin(theta + delta_th) ];
F_x = [F_x; 0 1  delta_s * cos(theta + delta_th) ];
F_x = [F_x; 0 0                 1                ];
%==============================================================================
% calculate the Jacobian of function f with respect to u (delta_sl, delta_sr)
u1 = 0.5*cos(theta + delta_th) + delta_s/(2*l)*sin(theta + delta_th);
u2 = 0.5*cos(theta + delta_th) - delta_s/(2*l)*sin(theta + delta_th);
u3 = 0.5*sin(theta + delta_th) - delta_s/(2*l)*cos(theta + delta_th);
u4 = 0.5*sin(theta + delta_th) + delta_s/(2*l)*cos(theta + delta_th);
F_u = [];
F_u = [F_u;    u1      u2  ];
F_u = [F_u;    u3      u4  ];
F_u = [F_u;   -1/l     1/l ];
%==============================================================================
%ENDRM
