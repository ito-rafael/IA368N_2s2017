function [ vu, omega ] = calculateControlOutput( robotPose, goalPose, parameters )
%CALCULATECONTROLOUTPUT This function computes the motor velocities for a differential driven robot

% current robot position and orientation
x = robotPose(1);
y = robotPose(2);
theta = robotPose(3);

% goal position and orientation
xg = goalPose(1);
yg = goalPose(2);
thetag = goalPose(3);

% compute control quantities
rho = sqrt((xg-x)^2+(yg-y)^2);  % pythagoras theorem, sqrt(dx^2 + dy^2)
lambda = atan2(yg-y, xg-x);     % angle of the vector pointing from the robot to the goal in the inertial frame
alpha = lambda - theta;         % angle of the vector pointing from the robot to the goal in the robot frame
alpha = normalizeAngle(alpha);

% the following paramerters should be used:

%==============================================================================
% Task 3:
%==============================================================================
% parameters.Kalpha,
% parameters.Kbeta,
% parameters.Krho: controller tuning parameters

vu = parameters.Krho * rho; % [m/s]
beta = normalizeAngle(-lambda + thetag);
omega = parameters.Kalpha*alpha + parameters.Kbeta * beta; % [rad/s]
%==============================================================================
% Task 4:
%==============================================================================
% parameters.backwardAllowed: This boolean variable should switch the between the two controllers
% parameters.useConstantSpeed: Turn on constant speed option
% parameters.constantSpeed: The speed used when constant speed option is on
%{
% parameters.useConstantSpeed is defined in "controller.m" and set as 0.1
if (parameters.useConstantSpeed == true)
    % robot moving FORWARD
    if ((alpha >= -pi/2) && (alpha < pi/2))
        vu = parameters.constantSpeed; % [m/s]
    % robot moving BACKWARD
    else
        % ((alpha >= pi/2) && (alpha < -pi/2))
        vu = -parameters.constantSpeed; % [m/s]
    end
end
%}
%==============================================================================
end
