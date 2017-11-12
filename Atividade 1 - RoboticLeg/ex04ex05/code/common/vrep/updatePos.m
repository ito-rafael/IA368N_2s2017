function ret=updatePos(vrep,clientID,qGoal)
pos=simxPackFloats(qGoal');
[err]=simxSetStringSignal(clientID,'pos',pos, vrep.simx_opmode_oneshot_wait);
simxSynchronousTrigger(clientID);
end
