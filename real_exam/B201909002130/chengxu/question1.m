clc
clear
syms n h step F1 F2 v00 v11 v01 v02 h11 n
% e Ϊ��������ײ�Ļָ�ϵ����
e = 0.74; m0 = 3.6; m1 = 0.27; g = 9.8; d = 0.4; r = d / 2;
% h_min Ϊ��������Ҫ����ĵ���С����40cm��
h_min = 0.4;
n = input('Please input the number of students:');
h = input('Please input the height of the hand:');
% h0 Ϊ�ľ������ľ��롣
h0 = 0.11;
% alpha ������֮��ĽǶȡ�
alpha = 360/n;
% ����
lx = sqrt(0.6^2 / (2 * (1 - cos(alpha)))) - r;
ly = h - h0;
l = sqrt(lx^2 + ly^2);

phi = asin(ly / l);
% a1 Ϊ������ʱ��ļ��ٶȣ� a2 Ϊ���½��ڶ��εļ��ٶ�
a1 = (n * F1 * sin(phi) - m0 * g)/m0;
a2 = (n * F2 * sin(phi) - m0 * g)/m0;

equ1 = m0 * v00 - m1 * v11 == m0 * v01 + m1 * v11;
equ2 = (v11 - v01) / (v00 + v11) == e;
equ3 = a1 * v11 == g * v00;
equ4 = v11/g == (v02 + v01)/g + v02/a2;
equ5 = v11^2/g + v00^2/a1 == 0.8;
equ6 = v11^2/g + (v02^2 - v01^2)/g + v02^2/a2 == 0.8;
equ = [equ1, equ2, equ3, equ4, equ5, equ6];
[F1, F2, v00, v01, v02, v11] = solve(equ, [F1, F2, v00, v01, v02, v11]);
fprintf('ʩ�ӵ���F1Ϊ��%.5f\nʩ�ӵ���F2Ϊ��%.5f\n���ӳ���Ϊ��%g\n',F1(2), F2(2), l);