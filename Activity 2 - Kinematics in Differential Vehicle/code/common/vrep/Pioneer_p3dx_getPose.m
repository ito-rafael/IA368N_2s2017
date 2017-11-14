function [x y gamma] = Pioneer_p3dx_getPose(connection)
    global isoctave;
    global realRobot;
    global poseStr;

    
    if ~isoctave
        if realRobot~=1

            [result,data]=connection.vrep.simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_pose',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
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
            p3pose = http_get([connection poseStr]);
            pose(1)= p3pose.x/1000;
            pose(2)= p3pose.y/1000;
            pose(3)= deg2rad(p3pose.th);
        end
    else
        if realRobot~=1
            [result,data]=simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_pose',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
            if (result~=connection.vrep.simx_error_noerror)
                error('simxGetStringSignal failed');
            end
            if(isempty(data))
                error('Empty data returned');
            end
            pose=simxUnpackFloats(data);
        else
            p3pose = http_get([connection poseStr]);
            pose(1)= p3pose.x/1000;
            pose(2)= p3pose.y/1000;
            pose(3)= deg2rad(p3pose.th);
        end
    end
    
	x=pose(1);
	y=pose(2);
	gamma=pose(3); % rad
end