load ca

if(isequal(R_B1x1, eval(subs(R_B1, [alpha beta gamma], [pi/3 pi/3 pi/3]))) &&...
        isequal(R_B1x2, eval(subs(R_B1, [alpha beta gamma], [pi/4 pi/3 pi/3]))) &&...
        isequal(R_B1x3, eval(subs(R_B1, [alpha beta gamma], [pi/6 pi/3 pi/3]))))
    disp('R_B1 is CORRECT');
else
    disp('R_B1 is INCORRECT');
end

if(isequal(R_12x1, eval(subs(R_12, [alpha beta gamma], [pi/3 pi/3 pi/3]))) &&...
        isequal(R_12x2, eval(subs(R_12, [alpha beta gamma], [pi/3 pi/4 pi/3]))) &&...
        isequal(R_12x3, eval(subs(R_12, [alpha beta gamma], [pi/3 pi/6 pi/3]))))
    disp('R_12 is CORRECT');
else
    disp('R_12 is INCORRECT');
end

if(isequal(R_23x1, eval(subs(R_23, [alpha beta gamma], [pi/3 pi/3 pi/3]))) &&...
        isequal(R_23x2, eval(subs(R_23, [alpha beta gamma], [pi/3 pi/3 pi/4]))) &&...
        isequal(R_23x3, eval(subs(R_23, [alpha beta gamma], [pi/3 pi/3 pi/6]))))
    disp('R_23 is CORRECT');
else
    disp('R_23 is INCORRECT');
end