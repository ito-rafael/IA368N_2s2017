load ca

if(isequal(round(r_BF_inBx1.*10000)./10000,round(double(subs(r_BF_inB, [alpha beta gamma], q1)).*10000)./10000) &&...
        isequal(round(r_BF_inBx2.*10000)./10000,round(double(subs(r_BF_inB, [alpha beta gamma], q2)).*10000)./10000) &&...
        isequal(round(r_BF_inBx3.*10000)./10000,round(double(subs(r_BF_inB, [alpha beta gamma], q3)).*10000)./10000))
    disp('CORRECT');
else
    disp('INCORRECT');
end
