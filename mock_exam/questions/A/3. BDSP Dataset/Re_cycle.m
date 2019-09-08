load B0005.mat
icycle = B0005.cycle;
size_of_cycle = size(icycle, 2);
Re_resistance = [];
Rct_resistance = [];
cycle_times_Re = [];

cycle = 0;
Is_a_cycle = false;
for i = 1:size_of_cycle
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
    
    if strcmp(icycle(i).type,'impedance')
        Re_resistance = [Re_resistance, icycle(i).data.Re];
        Rct_resistance = [Rct_resistance, icycle(i).data.Rct];
        cycle_times_Re = [cycle_times_Re, cycle];
    end
end
plot(cycle_times_Re, Re_resistance,cycle_times_Re, Rct_resistance);
