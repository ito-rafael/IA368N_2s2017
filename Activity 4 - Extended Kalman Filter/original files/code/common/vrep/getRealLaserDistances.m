%% V-REP Simulation Exercise 3: Kinematic Control
% Tests the implemented control algorithm within a V-Rep simulation.

% In order to run the simulation:
%   - Start V-Rep
%   - Load the scene matlab/common/vrep/mooc_exercise.ttt
%   - Hit the run button
%   - Start this script


clear;
close all; 
%% Parameters setup

%% define that we will use the real P3DX and/or the simulated one
global realRobot ; 
realRobot=1;

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
%% initialization
 connection = simulation_setup();

if realRobot==1
    % http_init will add the necessary paths 
    http_init('SID_7755');

    % Declaration of variables
    %connection = 'http://10.1.3.130:4950';  %use this address if you are
    %connected locally to the robot in the REALabs wifi network
    connection = 'http://143.106.148.171:9090/resource/RobotFEEC2';
   
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
    connection = simulation_openConnection(connection, 0);
    simulation_start(connection);

    %% Get static data from V-Rep
    Pioneer_p3dx_init(connection);
%     parameters.wheelDiameter = Pioneer_p3dx_getWheelDiameter(connection);
%     parameters.wheelRadius = parameters.wheelDiameter/2.0;
%     parameters.interWheelDistance = Pioneer_p3dx_getInterWheelDistance(connection);
%     parameters.scannerPoseWrtPioneer_p3dx = Pioneer_p3dx_getScannerPose(connection);
%     Pioneer_p3dx_setTargetGhostVisible(connection, 1);

end

pause(1)


%% reading laser
%%%PUT YOUR CODE HERE
for i=1:100
    dist  = Pioneer_p3dx_getLaserData(connection,'distances');
    measure(i)=dist(floor(length(dist)/2));
end

stairs(measure)

% if realRobot~= 1
%     simulation_stop(connection);
%     simulation_closeConnection(connection);
% else
%     
% end
% msgbox('Simulation ended');
