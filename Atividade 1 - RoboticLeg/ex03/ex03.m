clc; clear all;
pkg load symbolic
syms alpha beta gamma real
% hide all warnings
warning('off','all');
q = [alpha;beta;gamma];
%===============================================================================
r_BF_inB = [];
r_BF_inB = [r_BF_inB;           - sin(beta + gamma) - sin(beta)             ];
r_BF_inB = [r_BF_inB;   sin(alpha)*(cos(beta + gamma) + cos(beta) + 1) + 1  ];
r_BF_inB = [r_BF_inB;    -cos(alpha)*(cos(beta + gamma) + cos(beta) + 1)    ];
%===============================================================================
% determine the foot point Jacobian J_BF_inB=d(r_BF_inB)/dq
%{
function J_BF_inB = calc_jacobian(q)
    alpha = q(1);
    beta  = q(2);
    gamma = q(3);
    J_BF_inB = [];
    J_BF_inB = [J_BF_inB;                       0,                             -cos(beta+gamma)-cos(beta),              -cos(beta+gamma)          ];
    J_BF_inB = [J_BF_inB;   cos(alpha)*(cos(beta+gamma)+cos(beta)+1),   -sin(alpha)*(sin(beta+gamma)+sin(beta)),    -sin(alpha)*sin(beta+gamma)   ];
    J_BF_inB = [J_BF_inB;   sin(alpha)*(cos(beta+gamma)+cos(beta)+1),     cos(alpha)*sin(beta+gamma)+sin(beta),        cos(alpha)*sin(beta+gamma) ];
end
%}
J_BF_inB = [];
J_BF_inB = [J_BF_inB;                       0,                             -cos(beta+gamma)-cos(beta),              -cos(beta+gamma)          ];
J_BF_inB = [J_BF_inB;   cos(alpha)*(cos(beta+gamma)+cos(beta)+1),   -sin(alpha)*(sin(beta+gamma)+sin(beta)),    -sin(alpha)*sin(beta+gamma)   ];
J_BF_inB = [J_BF_inB;   sin(alpha)*(cos(beta+gamma)+cos(beta)+1),     cos(alpha)*sin(beta+gamma)+sin(beta),        cos(alpha)*sin(beta+gamma) ];
%===============================================================================
% what generalized velocity dq do you have to apply in a configuration q = [0;60�;-120�]
% to lift the foot in vertical direction with v = [0;0;-1m/s];
v = [0; 0; -1];
qi = [0; 60*(pi/180); -120*(pi/180)];
%===============================================================================
% Determine the numerical value of the foot point jacobian for initial joint angles qi
%JBF = double(calc_jacobian(qi));
JBF = double(subs(J_BF_inB,[alpha beta gamma],qi'));
pseudo_inv_JBF = inv(JBF'*JBF)*JBF';
%===============================================================================
% Determine the numerical value for dq
dq = pseudo_inv_JBF * v;
%===============================================================================
%valid_octave
valid_octave
