function Pioneer_p3dx_setTargetGhostPose(connection,x,y,gamma)
    global isoctave;
    global realRobot;
    global ghostPose; %target pose for the real robot

    if ~isoctave
        if realRobot~=1
            signalValue=connection.vrep.simxPackFloats([x,y,gamma]);
            connection.vrep.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
           ghostPose= [x,y,gamma];
        end
    else
        if realRobot~=1
            signalValue=simxPackFloats([x,y,gamma]);
            simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqTargetGhostPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            ghostPose= [x,y,gamma];
        end
    end
end