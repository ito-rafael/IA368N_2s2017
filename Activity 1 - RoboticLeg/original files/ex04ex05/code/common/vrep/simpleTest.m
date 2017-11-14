% Copyright 2006-2017 Coppelia Robotics GmbH. All rights reserved. 
% marc@coppeliarobotics.com
% www.coppeliarobotics.com
% 
% -------------------------------------------------------------------
% THIS FILE IS DISTRIBUTED "AS IS", WITHOUT ANY EXPRESS OR IMPLIED
% WARRANTY. THE USER WILL USE IT AT HIS/HER OWN RISK. THE ORIGINAL
% AUTHORS AND COPPELIA ROBOTICS GMBH WILL NOT BE LIABLE FOR DATA LOSS,
% DAMAGES, LOSS OF PROFITS OR ANY OTHER KIND OF LOSS WHILE USING OR
% MISUSING THIS SOFTWARE.
% 
% You are free to use/modify/distribute this file for whatever purpose!
% -------------------------------------------------------------------
%
% This file was automatically created for V-REP release V3.4.0 rev. 1 on April 5th 2017

% Make sure to have the server side running in V-REP: 
% in a child script of a V-REP scene, add following command
% to be executed just once, at simulation start:
%
% simExtRemoteApiStart(19999)
%
% then start simulation, and run this program.
%
% IMPORTANT: for each successful call to simxStart, there
% should be a corresponding call to simxFinish at the end!

function simpleTest()
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

    
            % Now try to retrieve data in a blocking fashion (i.e. a service call):
        [res,objs]=vrep.simxGetObjects(connection.clientID,vrep.sim_handle_all,vrep.simx_opmode_blocking);
        if (res==vrep.simx_return_ok)
            fprintf('Number of objects in the scene: %d\n',length(objs));
        else
            fprintf('Remote API function call returned with error code: %d\n',res);
        end
            
        pause(2);
    
        % Now retrieve streaming data (i.e. in a non-blocking fashion):
        t=clock;
        startTime=t(6);
        currentTime=t(6);
        vrep.simxGetIntegerParameter(connection.clientID,vrep.sim_intparam_mouse_x,vrep.simx_opmode_streaming); % Initialize streaming
        while (currentTime-startTime < 5)   
            [returnCode,data]=vrep.simxGetIntegerParameter(connection.clientID,vrep.sim_intparam_mouse_x,vrep.simx_opmode_buffer); % Try to retrieve the streamed data
            if (returnCode==vrep.simx_return_ok) % After initialization of streaming, it will take a few ms before the first value arrives, so check the return code
                fprintf('Mouse position x: %d\n',data); % Mouse position x is actualized when the cursor is over V-REP's window
            end
            t=clock;
            currentTime=t(6);
        end
            
        % Now send some data to V-REP in a non-blocking fashion:
        vrep.simxAddStatusbarMessage(connection.clientID,'Hello V-REP!',vrep.simx_opmode_oneshot);
    
    
    % stop the simulation
    simulation_stop(connection);

    % close the connection
    simulation_closeConnection(connection);
end
