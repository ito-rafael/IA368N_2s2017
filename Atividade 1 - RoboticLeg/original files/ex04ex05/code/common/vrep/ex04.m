% Make sure to have the simulation scene mooc_exercise.ttt running in V-REP!

% simulation setup, will add the matlab paths
connection = simulation_setup();

% the robot we want to interact with
robotNb = 0;

% open the connection
connection = simulation_openConnection(connection, robotNb);

% start simulation if not already started
simulation_start(connection);

vrep=connection.vrep;
% initialize connection
[err dt]=vrep.simxGetFloatingParameter(connection.clientID,vrep.sim_floatparam_simulation_time_step,vrep.simx_opmode_oneshot_wait);

% now enable stepped simulation mode:
simulation_setStepped(connection,true);

% given are the functions 
%   r_BF_inB(alpha,beta,gamma) and
%   J_BF_inB(alpha,beta,gamma) 
% for the foot positon respectively Jacobian

r_BF_inB = @(alpha,beta,gamma)[...
    -sin(beta + gamma) - sin(beta);...
  sin(alpha)*(cos(beta + gamma) + cos(beta) + 1) + 1;...
  -cos(alpha)*(cos(beta + gamma) + cos(beta) + 1)];
 
J_BF_inB = @(alpha,beta,gamma)[...
                                              0,             - cos(beta + gamma) - cos(beta),            -cos(beta + gamma);...
 cos(alpha)*(cos(beta + gamma) + cos(beta) + 1), -sin(alpha)*(sin(beta + gamma) + sin(beta)), -sin(beta + gamma)*sin(alpha);...
 sin(alpha)*(cos(beta + gamma) + cos(beta) + 1),  cos(alpha)*(sin(beta + gamma) + sin(beta)),  sin(beta + gamma)*cos(alpha)];
 
% write an algorithm for the inverse kinematics problem to
% find the generalized coordinates q that gives the endeffector position rGoal =
% [0.2,0.5,-2]' and store it in qGoal
q0 = pi/180*([0,-30,60])';
updatePos(vrep,connection.clientID,q0)
pause(0.5)

rGoal = [0.2,0.5,-2]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% enter here your algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

qGoal = ...;

updatePos(vrep,connection.clientID,qGoal)
valid

% now disable stepped simulation mode:
simulation_setStepped(connection,false);


pause(5)

% stop the simulation
simulation_stop(connection);

% close the connection
simulation_closeConnection(connection);