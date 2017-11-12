clc; clear all;

syms alpha beta gamma real

q = [alpha;beta;gamma];

r_BF_inB = [...
    - sin(beta + gamma) - sin(beta);...
  sin(alpha)*(cos(beta + gamma) + cos(beta) + 1) + 1;...
  -cos(alpha)*(cos(beta + gamma) + cos(beta) + 1)];


% determine the foot point Jacobian J_BF_inB=d(r_BF_inB)/dq
J_BF_inB = ...

% what generalized velocity dq do you have to apply in a configuration q = [0;60°;-120°]
% to lift the foot in vertical direction with v = [0;0;-1m/s];
v = [0; 0; -1]
qi = [0; 60*(pi/180); -120*(pi/180)];

% Determine the numerical value of the foot point jacobian for initial joint angles qi
JBF = ...
    
% Determine the numerical value for dq
dq = ...

valid