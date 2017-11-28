function test_shapiro_wilk(a, alpha)
    for i=1:length(a(1,:))
        H = swtest(a(:,i), alpha);
        if (H == 0)
            fprintf('i=%d: OK!\n', i);
        else
            fprintf('i=%d: DIDN''T PASS!\n', i);
        end
    end
end
