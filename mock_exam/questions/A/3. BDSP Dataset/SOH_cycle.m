load B0005.mat
icycle = B0005.cycle;
size_of_icycle = size(icycle, 2);
SOH = [];
cycle_times_SOH = [];
cycle = 0;
Is_a_cycle = false;
for i = 1:size_of_icycle
    if Is_a_cycle == false
        if strcmp(icycle(i).type, 'charge')
            Is_a_cycle = true;
        end
    end 
    if Is_a_cycle
        if strcmp(icycle(i).type, 'discharge')
            cycle = cycle + 1;
            Is_a_cycle = false;
        end
    end
    if strcmp(icycle(i).type,'discharge')
        cur_SOH = icycle(i).data.Capacity / 2; %1.8911
        if cur_SOH < 0.7
            break
        end
        SOH = [SOH, cur_SOH];
        cycle_times_SOH = [cycle_times_SOH, cycle];
    end
end
plot(cycle_times_SOH, SOH);
fit_SOH_cycle = polyfit(cycle_times_SOH, SOH, 3);
hold on 
plot(cycle_times_SOH, polyval(fit_SOH_cycle, cycle_times_SOH), 'r--');
hold off
        