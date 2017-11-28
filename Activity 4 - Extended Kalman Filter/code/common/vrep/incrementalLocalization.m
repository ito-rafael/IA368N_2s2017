function [x_posterori, P_posterori] = incrementalLocalization(x, P, u, S, M, params, k, g, l)
% [x_posterori, P_posterori] = incrementalLocalization(x, P, u, S, R, M,
% k, l, g) returns the a posterori estimate of the state and its covariance,
% given the previous state estimate, control inputs, laser measurements and
% the map

C_TR = diag([repmat(0.1^2, 1, size(S, 2)) repmat(0.1^2, 1, size(S, 2))]);
[z, R, ans] = extractLinesPolar(S(1,:), S(2,:), C_TR, params);

%STARTRM
figure(2), cla, hold on;
%==============================================================================
%compute z_prior
%hint: several steps to get z_prior
% S = [];
% S = [S; th_1 th_2 ... th_n];
% S = [S; d_1  d_2  ... d_n];
% th_n is the nth laser scan angle
%  d_n is the nth laser scan distance

z_prior = [];
N = length(M(1,:));
% compute a z for each entry
for i=1:N
    [h, H] = measurementFunction(x, M(:,i));
    z_prior(1,i) = h(1);
    z_prior(2,i) = h(2);
end

plot(z(1,:), z(2,:),'bo');
plot(z_prior(1,:), z_prior(2,:),'rx');
xlabel('angle [rad]'); ylabel('distance [m]')
legend('measurement','prior')
drawnow
% estimate robot pose
% hint: you just coded this function
[x_posterori, P_posterori] = filterStep(x, P, u, z, R, M, k, g, l);
%[x_posterori, P_posterori] = filterStep(x, P, u, z_prior, R, M, k, g, l);
%==============================================================================
%ENDRM
end
