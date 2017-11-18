function Pioneer_p3dx_setPose(connection,x,y,gamma)
% set a new pose of the inertial frame in reference to the old inertial frame(equivalent to an absolute setPose i.e. PUT(/motion/pose) )
    global isoctave;
    global realRobot;
    global poseStr;

    if ~isoctave
        if realRobot~=1

            signalValue=connection.vrep.simxPackFloats([x,y,gamma]);
            connection.vrep.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            http_put([connection poseStr],struct ('x',x*1000,'y',y*1000,'th',rad2deg(gamma)));
        end
    else
        if realRobot~=1

            signalValue=simxPackFloats([x,y,gamma]);
            simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqPose',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            http_put([connection poseStr],struct ('x',x*1000,'y',y*1000,'th',rad2deg(gamma)));
        end
    end
end