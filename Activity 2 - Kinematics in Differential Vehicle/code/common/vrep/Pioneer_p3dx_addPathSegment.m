function Pioneer_p3dx_addPathSegment(connection,x0,y0,x1,y1)
    global isoctave;
    if ~isoctave
        signalValue=connection.vrep.simxPackFloats([x0,y0,x1,y1]);
        connection.vrep.simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqAddPathSeg',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
    else
        signalValue=simxPackFloats([x0,y0,x1,y1]);
        simxSetStringSignal(connection.clientID,strcat('Pioneer_p3dx_reqAddPathSeg',num2str(connection.robotNb)),signalValue,connection.vrep.simx_opmode_oneshot);
    end
end