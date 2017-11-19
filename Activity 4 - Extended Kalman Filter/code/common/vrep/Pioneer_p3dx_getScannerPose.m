function [scannerPose] = Pioneer_p3dx_getScannerPose(connection)
    global realRobot;

    global isoctave;
    
    if ~isoctave
        if realRobot~=1
            [result,data]=connection.vrep.simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_laserScannerPose',num2str(connection.robotNb)),connection.vrep.simx_opmode_oneshot_wait);
            if (result~=connection.vrep.simx_error_noerror)
                err = MException('VREP:RemoteApiError', ...
                    'simxGetStringSignal failed');
                throw(err);
            end
            if(isempty(data))
                err = MException('VREP:RemoteApiError', ...
                    'Empty data returned');
                throw(err);
            end
            scannerPose=connection.vrep.simxUnpackFloats(data)
        else
            scannerPose=[ 0.0445   0.0000    0.0000];
        end
    else
        if realRobot~=1
            [result,data]=simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_laserScannerPose',num2str(connection.robotNb)),connection.vrep.simx_opmode_oneshot_wait);
            if (result~=connection.vrep.simx_error_noerror)
                error('simxGetStringSignal failed');
            end
            if(isempty(data))
                error('empty data returned');
            end
            scannerPose=simxUnpackFloats(data);
        else
            scannerPose=[ 0.0445   0.0000    0.0000];
        end
end