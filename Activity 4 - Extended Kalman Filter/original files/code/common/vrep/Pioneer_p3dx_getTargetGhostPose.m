function [x y gamma] = Pioneer_p3dx_getTargetGhostPose(connection)
    global isoctave;
    global realRobot;
    global ghostPose; %target pose for the real robot
    
    if ~isoctave
        if realRobot~=1

            [result,data]=connection.vrep.simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_targetGhostPose',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
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
            pose=connection.vrep.simxUnpackFloats(data);
        else
           %in real robot here 
           pose(1)= ghostPose(1);
           pose(2)= ghostPose(2);
           pose(3)= ghostPose(3);
        end
    else
        if realRobot~=1
            [result,data]=simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_targetGhostPose',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
            if (result~=connection.vrep.simx_error_noerror)
                error('simxGetStringSignal failed');
            end
            if(isempty(data))
                error('Empty data returned');
            end
            pose=simxUnpackFloats(data);
        else
           %in real robot here 
           pose(1)= ghostPose(1);
           pose(2)= ghostPose(2);
           pose(3)= ghostPose(3);            
        end
    end
	x=pose(1);
	y=pose(2);
	gamma=pose(3); % rad
end