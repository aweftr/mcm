load B0007.mat
icycle_7 = B0007.cycle;
size_of_icycle_7 = size(icycle_7, 2);
% SOH����
SOH_7 = [];
% �迹����
Re_resistance_7 = [];
Rct_resistance_7 = [];
SOH_R = [];
% ʵ��ѭ����������
cycle_7 = 0;
Is_a_cycle_7 = false;

for i = 1:size_of_icycle_7
    % �ж�ѭ������
    if Is_a_cycle_7 == false
        if strcmp(icycle_7(i).type, 'charge')
            Is_a_cycle_7 = true;
        end
    end 
    if Is_a_cycle_7
        if strcmp(icycle_7(i).type, 'discharge')
            cycle_7 = cycle_7 + 1;
            Is_a_cycle_7 = false;
        end
    end
    % SOHֵ��ѭ������
    if strcmp(icycle_7(i).type,'discharge')
        if strcmp(icycle_7(i+1).type, 'impedance')
            cur_SOH = icycle_7(i).data.Capacity / 2;
            if cur_SOH < 0.7
                break
            end
            cur_R = icycle_7(i+1).data.Re + icycle_7(i+1).data.Rct;
            SOH_R = [SOH_R;[cur_SOH, cur_R]];
        end
    end
end
plot(SOH_R(:,2), SOH_R(:,1));
fit_SOH_R = polyfit(SOH_R(:,2), SOH_R(:,1), 4);


% Ԥ��50%��B0005�����ݼ�
load B0005.mat
icycle_5 = B0005.cycle;
size_of_icycle_5 = size(icycle_5, 2);
% ʵ��ѭ����������
cycle_5 = 0;
Is_a_cycle_5 = false;

for i = 1:size_of_icycle_5
    % �ж�ѭ������
    if Is_a_cycle_5 == false
        if strcmp(icycle_5(i).type, 'charge')
            Is_a_cycle_5 = true;
        end
    end 
    if Is_a_cycle_5
        if strcmp(icycle_5(i).type, 'discharge')
            cycle_5 = cycle_5 + 1;
            Is_a_cycle_5 = false;
        end
    end
    
    % ��Чѭ������
    if strcmp(icycle_5(i).type,'discharge')
        cur_SOH = icycle_5(i).data.Capacity / 2;
        if cur_SOH < 0.7
            break
        end
    end
end

Is_a_cycle_5 = false;
cycle_5_half = 0;
SOH = [];
for i = 1:size_of_icycle_5
    % �ж�ѭ������
    if Is_a_cycle_5 == false
        if strcmp(icycle_5(i).type, 'charge')
            Is_a_cycle_5 = true;
        end
    end 
    if Is_a_cycle_5
        if strcmp(icycle_5(i).type, 'discharge')
            cycle_5_half = cycle_5_half + 1;
            Is_a_cycle_5 = false;
        end
    end
    if cycle_5_half < cycle_5 / 2
        if strcmp(icycle_5(i).type, 'discharge')
            if strcmp(icycle_5(i+1).type, 'impedance')
                cur_R = icycle_5(i+1).data.Re + icycle_5(i+1).data.Rct;
                est_SOH = polyval(fit_SOH_R, cur_R);
                real_SOH = icycle_5(i).data.Capacity / 2;
                SOH = [SOH;[est_SOH, real_SOH]];
            end
        end
    end
end
size_of_SOH = size(SOH,1);
x = 1:size_of_SOH;
plot(x, SOH(:,1), x, SOH(:,2));

ee = sqrt(sum((SOH(:,1) - SOH(:,2)).^2) / size(SOH,1))




% R_resistance_7 = Re_resistance_7 + Rct_resistance_7;
% plot(cycle_times_SOH_7, SOH_7);
% xlabel('ѭ���������Σ�');
% ylabel('���7��SOH');
% title('���7��SOH��ѭ�������Ĺ�ϵ����')
% fit_SOH_cycle_7 = polyfit(cycle_times_SOH_7, SOH_7, 4);
% 
% % hold on 
% % plot(cycle_times_Re_7, R_resistance_7);
% cycle_times_Re_7_rec = cycle_times_Re_7(38:end);
% R_resistance_7_rec = R_resistance_7(38:end);
% % plot(cycle_times_Re_7_rec, R_resistance_7_rec);
% % xlabel('ѭ���������Σ�');
% % ylabel('������裨����');
% % title('���7��������ѭ�������ı仯����');
% % hold off
% 
% fit_R_cycle_7 = polyfit(cycle_times_Re_7_rec, R_resistance_7_rec, 3);
% % plot(cycle_times_Re_7_rec, R_resistance_7_rec, cycle_times_Re_7_rec, polyval(fit_R_cycle_7, cycle_times_Re_7_rec));
% % legend('����ʵ������','�����������');
% % xlabel('ѭ���������Σ�');
% % ylabel('������裨����');
% % title('���7��������ѭ�������仯���������');
% 
% y_SOH_7 = [];
% x_R_7 = [];
% for i = cycle_times_Re_7_rec(1): cycle_times_SOH_7(end)
%     cur_y_SOH = polyval(fit_SOH_cycle_7, i);
%     y_SOH_7 = [y_SOH_7, cur_y_SOH];
%     cur_x_R = polyval(fit_R_cycle_7, i);
%     x_R_7 = [x_R_7, cur_x_R];
% end
% plot(x_R_7, y_SOH_7);
% xlabel('������裨����');
% ylabel('SOH');
% title('�ߺŵ��SOHֵ����������������');
% fit_SOH_R = polyfit(x_R_7, y_SOH_7,3);
% 
% % Ԥ��50%��B0005�����ݼ�
% load B0005.mat
% icycle_5 = B0005.cycle;
% size_of_icycle_5 = size(icycle_5, 2);
% % ʵ��ѭ����������
% cycle_5 = 0;
% Is_a_cycle_5 = false;
% 
% for i = 1:size_of_icycle_5
%     % �ж�ѭ������
%     if Is_a_cycle_5 == false
%         if strcmp(icycle_5(i).type, 'charge')
%             Is_a_cycle_5 = true;
%         end
%     end 
%     if Is_a_cycle_5
%         if strcmp(icycle_5(i).type, 'discharge')
%             cycle_5 = cycle_5 + 1;
%             Is_a_cycle_5 = false;
%         end
%     end
%     
%     % ��Чѭ������
%     if strcmp(icycle_5(i).type,'discharge')
%         cur_SOH = icycle_5(i).data.Capacity / 2;
%         if cur_SOH < 0.7
%             break
%         end
%     end
% end
% 
% Is_a_cycle_5 = false;
% cycle_5_half = 0;
% SOH = [];
% for i = 1:size_of_icycle_5
%     % �ж�ѭ������
%     if Is_a_cycle_5 == false
%         if strcmp(icycle_5(i).type, 'charge')
%             Is_a_cycle_5 = true;
%         end
%     end 
%     if Is_a_cycle_5
%         if strcmp(icycle_5(i).type, 'discharge')
%             cycle_5_half = cycle_5_half + 1;
%             Is_a_cycle_5 = false;
%         end
%     end
%     if cycle_5_half < cycle_5 / 2
%         if strcmp(icycle_5(i).type, 'discharge')
%             if strcmp(icycle_5(i+1).type, 'impedance')
%                 cur_R = icycle_5(i+1).data.Re + icycle_5(i+1).data.Rct;
%                 est_SOH = polyval(fit_SOH_R, cur_R);
%                 real_SOH = icycle_5(i).data.Capacity / 2;
%                 SOH = [SOH;[est_SOH, real_SOH]];
%             end
%         end
%     end
% end
% size_of_SOH = size(SOH,1);
% x = 1:size_of_SOH;
% % plot(x, SOH(:,1), x, SOH(:,2));
% 
% ee = sqrt(sum((SOH(:,1) - SOH(:,2)).^2) / size(SOH,1))
