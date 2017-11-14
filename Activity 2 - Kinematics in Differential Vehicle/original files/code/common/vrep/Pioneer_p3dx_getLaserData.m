function [laserDataX laserDataY] = Pioneer_p3dx_getLaserData(connection, dataType)
%dataType== nil or  'local_poses' : returns laserDataX laserDataY in ref to
%the laser frame
%dataType== 'global_poses' : returns laserDataX laserDataY in ref to the
%global frame
%dataType== 'distance_poses' : returns distance and [0]

    global isoctave;
    global realRobot;
    global laserStr;
    global laserIndex;
    
    if nargin < 2 
        dataType = 'local_poses'
    end
    
    
    
%     function distances=laserToDistance(laserData) %compute here the distance from the laserData OR get the distance in a stream from the laser script
%         
%         laserDataX=laserData(1:2:end-1);
%         laserDataY=laserData(2:2:end);
%     end
    function simFormat() %send the result with the simulator format
        if strcmp(dataType,'distances')
            laserDataX=laserData;
            laserDataY=zeros(1,length(laserData));
        else
            laserDataX=laserData(1:2:end-1);
            laserDataY=laserData(2:2:end);
        end
    end

    function realFormat() %send the result with the real robot format
        if strcmp(dataType,'distances')
            laserDataX=laserData ./1000;
            laserDataY=zeros(1,length(laserData));
        else
            x=zeros(1,(length(laserData)));
            y=zeros(1,(length(laserData)));
            for i=1: length(laserData)
                x(i)=laserData{i}.x;
                y(i)=laserData{i}.y;
            end
            laserDataX=x ./1000;
            laserDataY=y ./1000;
        end
    end
        


    if ~isoctave
        if realRobot~=1
            if strcmp(dataType,'local_poses')
                [result,data]=connection.vrep.simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_laserData',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
                if (result~=connection.vrep.simx_error_noerror)
                    err = MException('VREP:RemoteApiError', ...
                                    'simxGetStringSignal failed');
                    throw(err);
                end
                laserData=connection.vrep.simxUnpackFloats(data);

            elseif strcmp(dataType,'global_poses')
                %'global_poses'
            elseif strcmp(dataType,'distances')
                %'distances'
                [result,data]=connection.vrep.simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_laserData_distances',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
                if (result~=connection.vrep.simx_error_noerror)
                    err = MException('VREP:RemoteApiError', ...
                                    'simxGetStringSignal failed');
                    throw(err);
                end
                laserData=connection.vrep.simxUnpackFloats(data);
            else
                %'error!'
            end
            simFormat();
        else
            %get from restthru
            if strcmp(dataType,'local_poses')
                laserData = http_get([connection laserStr laserIndex '/local_poses']);

                %'local_poses'
            elseif strcmp(dataType,'global_poses')
                %'global_poses'
            elseif strcmp(dataType,'distances')
                %'distances'
                laserData = http_get([connection laserStr laserIndex '/distances']);

            else
                %'error!'   
            end  
            realFormat();
        end
    else
        if realRobot~=1
            if strcmp(dataType,'local_poses')
                [result,data]=simxGetStringSignal(connection.clientID,strcat('Pioneer_p3dx_laserData',num2str(connection.robotNb)),connection.vrep.simx_opmode_buffer);
                if (result~=connection.vrep.simx_error_noerror)
                    error('simxGetStringSignal failed');
                end
                laserData=simxUnpackFloats(data);
            elseif strcmp(dataType,'global_poses')
                'global_poses'
            elseif strcmp(dataType,'distances')
                'distances'
            else
                'error!'   
            end        
            simFormat()
        else
            %get from restthru
            realFormat();
        end
    end

end