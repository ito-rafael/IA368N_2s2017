function Pioneer_p3dx_setGhostVisible(connection,visible)
	global isoctave;
    if ~isoctave
        connection.vrep.simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqGhostVisibility',num2str(connection.robotNb)),visible,connection.vrep.simx_opmode_oneshot);
    else
        simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqGhostVisibility',num2str(connection.robotNb)),visible,connection.vrep.simx_opmode_oneshot);
    end
end