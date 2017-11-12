% Make sure to have the simulation scene mooc_exercise.ttt running in V-REP!
clear all;

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
[err dt]=simxGetFloatingParameter(connection.clientID,vrep.sim_floatparam_simulation_time_step,vrep.simx_opmode_oneshot_wait);

% now enable stepped simulation mode:
simulation_setStepped(connection,true);

% given are the functions
%   r_BF_inB(alpha,beta,gamma) and
%   J_BF_inB(alpha,beta,gamma)
% for the foot positon respectively Jacobian

r_BF_inB = @(alpha, beta, gamma)[...
    -sin(beta + gamma) - sin(beta);...
  sin(alpha)*(cos(beta + gamma) + cos(beta) + 1) + 1;...
  -cos(alpha)*(cos(beta + gamma) + cos(beta) + 1)];

J_BF_inB = @(alpha, beta, gamma)[...
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
q_previous = q0;
i = 1;
error_loop = 1;
while (error_loop > 1e-8)
    % start from a known solution (forward kinematics)
    r_current = r_BF_inB(q_previous(1), q_previous(2), q_previous(3));
    % calculate error
    error_loop = norm(rGoal - r_current);
    error = rGoal - r_current;
    % invert the Jacobian
    J_inv = pinv(J_BF_inB(q_previous(1),q_previous(2),q_previous(3)));
    % update generalized coordinates
    q_update = q_previous + (J_inv * error);
    q_previous = q_update;
    % check validation
    qGoal = q_update;
    i = i + 1;
end
%disp "number of iterations = ", disp(i);
fprintf('number of iterations = %d\n', i);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

updatePos(vrep,connection.clientID,qGoal)
valid

% now disable stepped simulation mode:
simulation_setStepped(connection,false);
pause(5)
% stop the simulation
simulation_stop(connection);
% close the connection
simulation_closeConnection(connection);
