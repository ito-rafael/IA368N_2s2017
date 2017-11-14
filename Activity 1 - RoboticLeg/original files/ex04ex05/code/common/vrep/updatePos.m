function ret=updatePos(vrep,clientID,qGoal)
pos=vrep.simxPackFloats(qGoal');
[err]=vrep.simxSetStringSignal(clientID,'pos',pos, vrep.simx_opmode_oneshot_wait);
vrep.simxSynchronousTrigger(clientID);
end