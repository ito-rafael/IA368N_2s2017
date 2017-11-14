clc; clear all;
pkg load symbolic;
syms alpha beta gamma real;
% hide all warnings
warning('off','all');
%===============================================================================
% write down the rotation matrices using the symbolic parameters alpha, beta, gamma
R_B1 = [];
R_B1 = [R_B1;   1,       0,           0       ];
R_B1 = [R_B1;   0,   cos(alpha),  -sin(alpha) ];
R_B1 = [R_B1;   0,   sin(alpha),   cos(alpha) ];
%---------------------------------------------
R_12 = [];
R_12 = [R_12;   cos(beta),    0,    sin(beta) ];
R_12 = [R_12;    sym(0),      1,        0     ];
R_12 = [R_12;  -sin(beta),    0,    cos(beta) ];
%---------------------------------------------
R_23 = [];
R_23 = [R_23;   cos(gamma),   0,   sin(gamma) ];
R_23 = [R_23;     sym(0),     1,        0     ];
R_23 = [R_23;  -sin(gamma),   0,   cos(gamma) ];
%===============================================================================
% check answers
valid_octave
