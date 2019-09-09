load B0005.mat
cycle = B0005.cycle;
size_of_cycle = size(cycle, 2);
hold on
for i = 1:size_of_cycle
    if strcmp(cycle(i).type, 'charge')
        charge_cycle = cycle(i);
        if charge_cycle.data.Voltage_measured(1) >= 5
            disp(i)
        end
        size_of_Time = size(charge_cycle.data.Time);
        if size_of_Time(2) > 50
            plot(charge_cycle.data.Time(1:50), charge_cycle.data.Voltage_measured(1:50));
%             plot(charge_cycle.data.Time, charge_cycle.data.Voltage_measured);
        else
            plot(charge_cycle.data.Time, charge_cycle.data.Voltage_measured);
        end
    end
end
hold off
    