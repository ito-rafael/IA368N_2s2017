clear all; close all;
disp('Program started');
vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
vrep.simxFinish(-1); % just in case, close all opened connections
clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);



if (clientID>-1)
    
    %getting handles
    [err,kinHandle]=vrep.simxGetObjectHandle(clientID,'kinect_depth',vrep.simx_opmode_oneshot_wait);
    [err,camHandle]=vrep.simxGetObjectHandle(clientID,'kinect_rgb',vrep.simx_opmode_oneshot_wait);
    
    [err,leftMotor]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',vrep.simx_opmode_oneshot_wait);
    [err,rightMotor]=vrep.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',vrep.simx_opmode_oneshot_wait);
    
    %testing to update the speed to 10 deg/sec for leftMotor
    vrep.simxSetJointTargetVelocity(clientID,leftMotor,0*pi/180,vrep.simx_opmode_oneshot)
    
    %taking a picture and showing it
    % before that copy/paste the lab in the scene
    [err,res,imgRGB]=vrep.simxGetVisionSensorImage2(clientID,camHandle,0,vrep.simx_opmode_oneshot_wait);
    imshow(imgRGB)
    
    [err,res,imgDepth]=vrep.simxGetVisionSensorDepthBuffer2(clientID,kinHandle,vrep.simx_opmode_oneshot_wait);
    imshow(imgDepth)
    
    
    %get a laser reading: put a fastHokuyo over the kinect first UNDER
    %myROBOT
    % in the script fastHokuyo, uncomment lines 120 and 121
    [err,signalValue]=vrep.simxGetStringSignal(clientID,'measuredDataAtThisTime',vrep.simx_opmode_oneshot_wait);
    lrf=vrep.simxUnpackFloats(signalValue);
    
    %let s also take a picture of what the kinect sees with the rgb cam
    [err,res,imgRGB]=vrep.simxGetVisionSensorImage2(clientID,camHandle,0,vrep.simx_opmode_oneshot_wait);
    image=double(imgRGB)./255;
    
    imshow(image)
    
%     figure;
%     hold on;
%     axis('equal');
%     fig=scatter3(lrf(1:3:size(lrf,2)),lrf(2:3:size(lrf,2)),lrf(3:3:size(lrf,2)),100);
%     view(0,90);
%     
%     getKinectParameters;
%     pointcloud=[];
%     getPointCloud;
% 
%     
%     figure;
%     hold on;
%     scatter3(pointcloud(:,1),pointcloud(:,2),-pointcloud(:,3),10,pointcloud(:,3)/3.2,'filled')
%    
%     figure;
%     hold on;
%     displayPointCloud;

    % init teleop
    vl=0;   % left velocity rad/s
    vr=0;   % right velocity rad/s
    vel=0;  % linear velocity rad/sec
    omega=0;% angular velocity rad/sec
    L=0.20; % distance between wheels m
    R=0.05; % wheel radius m
    
    while 1 %main loop
        
        K = getkeywaitchar(1);
        if strcmpi(K , 'n') %reduce angular velocity by 10 deg/s i.e. turn "lefter"
            omega=omega-(10*pi/180.);
        end
        if strcmpi(K , 'b') %increase angular velocity by 10 deg/s i.e. turn "righter"
            omega=omega+(10*pi/180.);
        end
        
        if strcmpi(K , 'e') %increase linear velocity by 0.1 m/s
            vel=vel+(0.1 /( R*2*pi));
        end       
        
        if strcmpi(K , 'd') %reduce linear velocity by 0.1 m/s
            vel=vel-(0.1 /( R*2*pi));
        end
        
        if strcmpi(K , ' ') %stop
            vrep.simxSetJointTargetVelocity(clientID,leftMotor,0,vrep.simx_opmode_oneshot);
            vrep.simxSetJointTargetVelocity(clientID,rightMotor,0,vrep.simx_opmode_oneshot);
            omega=0;
            vel=0;
        end
        if strcmpi(K , 'q') % stop and quit
            omega=0;
            vel=0;
            vrep.simxSetJointTargetVelocity(clientID,leftMotor,0,vrep.simx_opmode_oneshot);
            vrep.simxSetJointTargetVelocity(clientID,rightMotor,0,vrep.simx_opmode_oneshot);
            break;
        end
        
        %update velocities
        vl = vel - (L/2*omega)/(R);
        vr = vel + (L/2*omega)/(R);
        vrep.simxSetJointTargetVelocity(clientID,leftMotor,vl,vrep.simx_opmode_oneshot);
        vrep.simxSetJointTargetVelocity(clientID,rightMotor,vr,vrep.simx_opmode_oneshot);
        
        toto=[vel omega vl vr]
    end
    
    
    
    
    
else
    disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!

