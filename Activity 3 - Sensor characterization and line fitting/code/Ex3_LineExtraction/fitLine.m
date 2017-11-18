%---------------------------------------------------------------------
% This function computes the parameters (r, alpha) of a line passing
% through input points that minimize the total-least-square error.
%
% Input:   XY - [2,N] : Input points
%
% Output:  alpha, r: paramters of the fitted line

function [alpha, r] = fitLine(XY)
% Compute the centroid of the point set (xmw, ymw) considering that
% the centroid of a finite set of points can be computed as
% the arithmetic mean of each coordinate of the points.

% XY(1,:) contains x position of the points
% XY(2,:) contains y position of the points

    N = length(XY(1,:));
    %========================================
    % the centroid of a finite set of points
    %========================================
    % calculate arithmetic mean for X points
    sum_x = 0;
    for i=1:N
        sum_x = sum_x + XY(1,i);
    end
    xc = sum_x / N;
    %----------------------------------------
    % calculate arithmetic mean for X points
    sum_y = 0;
    for i=1:N
        sum_y = sum_y + XY(2,i);
    end
    yc = sum_y / N;
    %========================================
    %   computation of parameter alpha
    %========================================
    sum_n = 0;
    denom = 0;
    for i=1:N
        sum_n = sum_n + (XY(1,i) - xc)   *   (XY(2,i) - yc);
        denom = denom + (XY(2,i) - yc)^2 - (XY(1,i) - xc)^2;
    end
    nom = -2 * sum_n;
    alpha = atan2(nom,denom) / 2;
    %========================================
    %   computation of parameter r
    %========================================
    r = xc*cos(alpha) + yc*sin(alpha);
    %========================================

% Eliminate negative radii
if r < 0,
    alpha = alpha + pi;
    if alpha > pi, alpha = alpha - 2 * pi; end
    r = -r;
end

end
