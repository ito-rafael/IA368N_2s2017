function Pioneer_p3dx_clearMapSegments(connection)
    global isoctave;
    if ~isoctave
        connection.vrep.simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqClearMapSeg',num2str(connection.robotNb)),0,connection.vrep.simx_opmode_oneshot);
    else
       simxSetIntegerSignal(connection.clientID,strcat('Pioneer_p3dx_reqClearMapSeg',num2str(connection.robotNb)),0,connection.vrep.simx_opmode_oneshot); 
    end
end