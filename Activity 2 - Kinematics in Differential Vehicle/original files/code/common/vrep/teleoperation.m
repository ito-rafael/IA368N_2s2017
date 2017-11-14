%% V-REP Simulation Exercise 2-3: Teleoperation
% Tests the algorithm within a V-Rep simulation.

% In order to run the simulation:
%   - Start V-Rep
%   - Load the scene /scene/Exercise2.ttt
%   - Hit the run button
%   - Start this script


clear;
close all;
%% Parameters setup

%% define that we will use the real P3DX and/or the simulated one
global realRobot ;
realRobot = 0; %realRobot=0 for simulation and realRobot=1 to use the real robot 

global laserStr;
laserStr = '/perception/laser/';

global poseStr;
poseStr = '/motion/pose';

global vel2Str;
vel2Str = '/motion/vel2';

global stopStr;
stopStr = '/motion/stop';

global parameters;

%% initialization
if realRobot==1
    % http_init will add the necessary paths
    http_init;
    
    % Declaration of variables
    connection = 'http://10.1.3.130:4950';
    %connection = 'http://143.106.11.166:4950';
    
    parameters.wheelDiameter = .195;
    parameters.wheelRadius = parameters.wheelDiameter/2.0;
    parameters.interWheelDistance = .381/2;
    
    %1% Pioneer_p3dx_setTargetGhostPose(connection, -2, 0, 0);
    
    %% Set the initial pose of the robot ( TO CHANGE INTO A FUNCTION SET_POSE)
    %1%http_put([connection '/motion/pose'], struct ('x',0,'y',-2 *1000,'th',90)) ;
    %http_put([connection '/motion/pose'], struct ('x',0,'y',0,'th',0)) ;
    % parameters.scannerPoseWrtPioneer_p3dx = Pioneer_p3dx_getScannerPose(connection);
else
    %% Initialize connection with V-Rep
    connection = simulation_setup();
    connection = simulation_openConnection(connection, 0);
    simulation_start(connection);
    
    %% Get static data from V-Rep
    Pioneer_p3dx_init(connection);
    parameters.wheelDiameter = Pioneer_p3dx_getWheelDiameter(connection);
    parameters.wheelRadius = parameters.wheelDiameter/2.0;
    parameters.interWheelDistance = Pioneer_p3dx_getInterWheelDistance(connection);
    parameters.scannerPoseWrtPioneer_p3dx = Pioneer_p3dx_getScannerPose(connection);
    Pioneer_p3dx_setTargetGhostVisible(connection, 1);
    
end
%initialization ends here

Pioneer_p3dx_setPose(connection, 0,0,0);

% define target position
%Pioneer_p3dx_setTargetGhostPose(connection, 0, -1, deg2rad(90));
%1%Pioneer_p3dx_setTargetGhostPose(connection, -1, 0, 0);
Pioneer_p3dx_setTargetGhostPose(connection, 1.6, 0.6, deg2rad(90));


% controller parameters
parameters.Krho = 0.5;
parameters.Kalpha = 1.5;
parameters.Kbeta = -0.6;
parameters.backwardAllowed = true;
parameters.useConstantSpeed = true;
parameters.constantSpeed = 0.1;

%% Define parameters for Dijkstra and Dynamic Window Approach
parameters.dist_threshold= 0.25; % threshold distance to goal
parameters.angle_threshold = deg2rad(10);%0.4; % threshold orientation to goal

%%
%----------------------- Initialisation of variables -------------------------------------------------------%
R = parameters.wheelRadius;

%% teleoperation program goes here


%% Bring Pioneer_p3dx to standstill
Pioneer_p3dx_setWheelSpeeds(connection, 0.0, 0.0);

if realRobot~= 1
    simulation_stop(connection);
    simulation_closeConnection(connection);
else
    
end
% msgbox('Simulation ended');
