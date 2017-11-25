function [x_posteriori, P_posteriori] = filterStep(x, P, u, Z, R, M, k, g, l)
% [x_posteriori, P_posteriori] = filterStep(x, P, u, z, R, M, k, g, l)
% returns an a posteriori estimate of the state and its covariance
%STARTRM
%==============================================================================
% propagate the state (p. 337) , here kr=kl=k
% u = [sl sr]'
Q = [];
Q = [Q;  k*u(2)     0    ];
Q = [Q;    0      k*u(1) ];
%==============================================================================
%hints: you just coded this function
[x_priori, F_x, F_u] = transitionFunction(x,u,l);
P_priori = (F_x * P * (F_x')) + (F_u * Q * (F_u'));
%==============================================================================
if size(Z,2) == 0
    x_posteriori = x_priori;
    P_posteriori = P_priori;
    return;
end
%==============================================================================
%hints: you just coded this function
[v, H, R] = associateMeasurements(x_priori, P_priori, Z, R, M, g);
%==============================================================================
y = reshape(v, [], 1);
H = reshape(permute(H, [1,3,2]), [], 3);
R = blockDiagonal(R);
%==============================================================================
% update state estimates (pp. 335)
%S is the innovation covariance matrix
S = (H * P_priori * (H')) + R;
K = P_priori * (H') * inv(S);

P_posteriori = (eye(size(P_priori)) - K*H) * P_priori;
x_posteriori = x_priori + K * y;
%==============================================================================
%ENDRM
end
