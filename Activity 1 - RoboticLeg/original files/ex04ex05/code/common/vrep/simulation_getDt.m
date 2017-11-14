function dt=simulation_getDt(connection)
    global isoctave;
    if (isoctave)
        [err,dt]=simxGetFloatingParameter(connection.clientID,connection.vrep.sim_floatparam_simulation_time_step,connection.vrep.simx_opmode_oneshot_wait);
    else
        [err,dt]=connection.vrep.simxGetFloatingParameter(connection.clientID,connection.vrep.sim_floatparam_simulation_time_step,connection.vrep.simx_opmode_oneshot_wait)
    end
end