function Pioneer_p3dx_setWheelSpeeds(connection,leftInRadPerSec,rightInRadPerSec)
    global realRobot;
    global vel2Str;
    global isoctave;
    global parameters;

    if ~isoctave
        if realRobot~=1

            signalValue=connection.vrep.simxPackFloats([leftInRadPerSec,rightInRadPerSec]);
            connection.vrep.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqVelocities',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            
            
            http_put([connection vel2Str], struct ('right',(rightInRadPerSec*parameters.wheelRadius*1000), 'left', (leftInRadPerSec*parameters.wheelRadius*1000))) ;
            
        end
    else
        if realRobot~=1
            signalValue=simxPackFloats([leftInRadPerSec,rightInRadPerSec]);
            simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqVelocities',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
        else
            http_put([connection vel2Str], struct ('right',(rightInRadPerSec*parameters.wheelRadius*1000), 'left', (leftInRadPerSec*parameters.wheelRadius*1000))) ;
        end
    end
end