%% V-REP Simulation Exercise 3: Line Extraction and EKF

% In order to run the simulation:
%   - Start V-Rep
%   - Load the scene matlab/common/vrep/Exercise4.ttt
%   - Hit the run button in V-REP
%   - Start this script

%% Parameters setup
%% define that we will use the real P3DX and/or the simulated one
global realRobot ; 
realRobot=0;

%global ghostPose;
%ghostPose=[0,0,0];

global laserStr;
laserStr = '/perception/laser/';

global laserIndex;
laserIndex='0';

global optionStr;
optionStr= '?range=-100:100:20'; %  example optionStr= '?range=-90:90:3'

global poseStr;
poseStr = '/motion/pose';   

global vel2Str;
vel2Str = '/motion/vel2';   

global stopStr;
stopStr = '/motion/stop';

global parameters;

% try

%% Initialize connection with V-Rep
connection = simulation_setup();
connection = simulation_openConnection(connection, 0);
simulation_start(connection);
[bodyDiameter wheelDiameter interWheelDist scannerPose] = Pioneer_p3dx_init(connection);
Pioneer_p3dx_setGhostVisible(connection, 1);

params.MIN_SEG_LENGTH = 0.01;
params.LINE_POINT_DIST_THRESHOLD = 0.005;
params.MIN_POINTS_PER_SEGMENT = 20;

img = Pioneer_p3dx_getMap(connection);
M = generateMap(img);
g = sqrt(1);
l = Pioneer_p3dx_getInterWheelDistance(connection);
d = Pioneer_p3dx_getWheelDiameter(connection);
P = diag([ 0.01; 0.01; 0.01]);

k = 0.9;
x = zeros(3,1);
[x(1), x(2), x(3)] = Pioneer_p3dx_getPose(connection);

simStep = 50e-3;    % simulation step duration in seconds
laserRate = .5;     % laser rate in Hz, no intermediate propagations with the motion model will be performed

laserRate = simStep;

simulation_setStepped(connection, true);

u = [0;0];
v = [0;0];


Pioneer_p3dx_setWheelSpeeds(connection, 0.9, 1.0);

for i = 1:400
    
    for l = 1:round(laserRate/simStep)
        simulation_triggerStep(connection);
    end
    
    [v(1), v(2)] = Pioneer_p3dx_getWheelSpeeds(connection);
    dt = 50e-3*round(laserRate/simStep);
    u = (v + abs(v).* (k * randn(size(u)))) * dt * d/2;
    
    % extract lines
    [laserX, laserY] = Pioneer_p3dx_getLaserData(connection);
    theta = atan2(laserY, laserX);
    rho = laserX./cos(theta);
    inRangeIdx = find(rho < 4.9);
    theta  = theta(inRangeIdx);
    rho  = rho(inRangeIdx);
    
    [x, P] = incrementalLocalization(x, P, u, [theta; rho], M, params, k, g, l);
    
    % plot pose estimate in vrep
    Pioneer_p3dx_setGhostPose(connection, x(1), x(2), x(3));
    
end
simulation_stop(connection);
simulation_closeConnection(connection);

% catch exception
%     simulation_closeConnection(connection);
%     rethrow(exception);
% end
