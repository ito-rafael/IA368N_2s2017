function [x_posteriori, P_posteriori] = filterStep(x, P, u, Z, R, M, k, g, l)
% [x_posteriori, P_posteriori] = filterStep(x, P, u, z, R, M, k, g, l)
% returns an a posteriori estimate of the state and its covariance

%STARTRM

% propagate the state (p. 337) , here kr=kl=k
Q = #; 

[x_priori, F_x, F_u] = #; %hints: you just coded this function
P_priori = #;

if size(Z,2) == 0
    x_posteriori = x_priori;
    P_posteriori = P_priori;
    return;
end
    
[v, H, R] = #;%hints: you just coded this function

y = reshape(v, [], 1);
H = reshape(permute(H, [1,3,2]), [], 3);
R = blockDiagonal(R);

% update state estimates (pp. 335)
S = #; %S is the innovation covariance matrix
K = #;

x_posteriori = x_priori + K * y;
P_posteriori = (eye(size(P_priori)) - K*H) * P_priori;

%ENDRM
