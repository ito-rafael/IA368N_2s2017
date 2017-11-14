function ret=updateVels(vrep,clientID,dq)
vels=simxPackFloats(dq');
[err]=simxSetStringSignal(clientID,'vels',vels, vrep.simx_opmode_oneshot);
simxSynchronousTrigger(clientID);
end
