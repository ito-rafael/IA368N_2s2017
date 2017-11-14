clc; clear all

syms alpha beta gamma real

lb = 1; l1 = 1; l2 = 1; l3 = 1;

% rotational matrices calculated in previous problem set
R_B1 = [1,0,0;0,cos(alpha),-sin(alpha);0,sin(alpha),cos(alpha)];
R_12 = [cos(beta),0,sin(beta);0,1,0;-sin(beta),0,cos(beta)];
R_23 = [cos(gamma),0,sin(gamma);0,1,0;-sin(gamma),0,cos(gamma)];

% write down the 3x1 relative position vectors for link length l_i=1
r_B1_inB = ...;
r_12_in1 = ...;
r_23_in2 = ...;
r_3F_in3 = ...;

% write down the homogeneous transformation matrices
H_B1 = ...;
H_12 = ...;
H_23 = ...;

% create the cumulative transformation matrix
H_B3 = ...; 

% find the foot point position vector
r_BF_inB = ...;
     
valid
