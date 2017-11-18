function Pioneer_p3dx_setDeltaPose(connection,x,y,gamma)
% set a new pose of the inertial frame in reference to the robot's frame(equivalent to a relative setPose i.e. POST /motion/pose)
    global isoctave;
    global realRobot;
    global poseStr;

    if ~isoctave
        if realRobot~=1
            signalValue=connection.vrep.simxPackFloats([x,y,gamma]);
            connection.vrep.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqDeltaPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            http_post([connection poseStr],struct ('x',x*1000,'y',y*1000,'th',rad2deg(gamma)));
        end
    else
        if realRobot~=1
            signalValue=simxPackFloats([x,y,gamma]);
            simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqDeltaPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            http_post([connection poseStr],struct ('x',x*1000,'y',y*1000,'th',rad2deg(gamma)));
        end
    end
end