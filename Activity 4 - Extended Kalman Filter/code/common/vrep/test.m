% Make sure to have the simulation scene mooc_exercise.ttt running in V-REP!

% simulation setup, will add the matlab paths
connection = simulation_setup();

% the robot we want to interact with
robotNb = 0;

% open the connection
connection = simulation_openConnection(connection, robotNb);

% start simulation if not already started
simulation_start(connection);

% initialize connection
[bodyDiameter wheelDiameter interWheelDist scannerPose] = Pioneer_p3dx_init(connection);
[bodyDiameter] = Pioneer_p3dx_getBodyDiameter(connection);
[wheelDiameter] = Pioneer_p3dx_getWheelDiameter(connection);
[interWheelDist] = Pioneer_p3dx_getInterWheelDistance(connection);
[scannerPose] = Pioneer_p3dx_getScannerPose(connection);

% set motor velocities in deg/sec (non-blocking function):
Pioneer_p3dx_setWheelSpeeds(connection,pi,pi/2);

% make ghost visible/invisible (non-blocking function)
Pioneer_p3dx_setGhostVisible(connection,true);

% set ghost pose (x,y,gamma), where positions are in meter, orientation in degrees (non-blocking function):
Pioneer_p3dx_setGhostPose(connection,0.5,0.5,pi/4);

% clear all map segments (non-blocking function):
Pioneer_p3dx_clearMapSegments(connection);

% Add one map segment (x0,y0,x1,y1) (non-blocking function):
Pioneer_p3dx_addMapSegment(connection,0.1,0.2,0.8,0.9);

% clear all path segments (non-blocking function):
Pioneer_p3dx_clearPathSegments(connection);

% Add one path segment (x0,y0,x1,y1) (non-blocking function):
Pioneer_p3dx_addPathSegment(connection,0.5,0.4,0.6,0.9);

% get motor velocities in deg/sec (non-blocking function):
[leftVel rightVel] = Pioneer_p3dx_getWheelSpeeds(connection);

% get motor encoders in deg (non-blocking function):
[leftEnc rightEnc] = Pioneer_p3dx_getEncoders(connection);

% get robot pose (x,y,gamma), where positions are in meter, orientation in degrees (non-blocking function):
[x y gamma] = Pioneer_p3dx_getPose(connection);

% get ghost pose (x,y,gamma), where positions are in meter, orientation in degrees (non-blocking function):
[x y gamma] = Pioneer_p3dx_getGhostPose(connection);

% get laser data (non-blocking function). X/Y coords. are in meters, and relative to the laser scanner reference frame.
[laserDataX laserDataY] = Pioneer_p3dx_getLaserData(connection);
scatter(laserDataX,laserDataY);

% Get the global map (BLOCKING function, can also be made non-blocking if needed):
img=Pioneer_p3dx_getMap(connection); % image has 512x512 values, corresponding to the 5x5 m^2 terrain
imshow(img);

% Set the goal position ghost visible
Pioneer_p3dx_setTargetGhostVisible(connection, 1);

% Get the target position
[x y gamma] = Pioneer_p3dx_getTargetGhostPose(connection);

% Enable mouse navigation
simulation_setMouseNavigation(connection,1);

% Enable mouse navigation
simulation_selectObject(connection,1);

% now enable stepped simulation mode:
simulation_setStepped(connection,true);

% and step 20 times:
for i=0:200
    simulation_triggerStep(connection);
    pause(0.1);
end

% now disable stepped simulation mode:
simulation_setStepped(connection,false);

% stop the simulation
simulation_stop(connection);

% close the connection
simulation_closeConnection(connection);