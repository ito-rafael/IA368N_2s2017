load ca

if(isequal(r_BF_inBx1, eval(subs(r_BF_inB, [alpha beta gamma], q1))) &&...
        isequal(r_BF_inBx2, eval(subs(r_BF_inB, [alpha beta gamma], q2))) &&...
        isequal(r_BF_inBx3, eval(subs(r_BF_inB, [alpha beta gamma], q3))))
    disp('CORRECT');
else
    disp('INCORRECT');
end
