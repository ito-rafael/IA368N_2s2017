rBF_valid = r_BF_inB(qGoal(1), qGoal(2), qGoal(3));
error_valid = norm(rBF_valid-rGoal);
if(error_valid < 1E-8)
    disp('CORRECT');
else
    disp('INCORRECT');
end