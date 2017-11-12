function ret=updateVels(vrep,clientID,dq)
vels=vrep.simxPackFloats(dq');
[err]=vrep.simxSetStringSignal(clientID,'vels',vels, vrep.simx_opmode_oneshot);
vrep.simxSynchronousTrigger(clientID);
end