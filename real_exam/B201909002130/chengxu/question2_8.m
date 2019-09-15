clc
clear
d = 0.4; r = d/2; m = 3.6; h = 0.22;
F1 = 90; F2 = 80;
l = 1.7;
phi = asin(0.11/1.7); alpha = 0; omega = 0;
gamma1 = 3 * pi / 8; gamma2 = pi / 8;
J = 1/2 * m * r^2 + 1/12 * m * h^2; %圆环的转动惯量。
step = 1000000;
t = 0.1 / step; % 0.1 秒的步长。

for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    theta1 = alpha1 * r / l;
     % 转动方程求此时的角加速度。
    beta = 2 * r * F2 * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1)) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
end
fprintf('0.1s前的鼓面倾角：%g°\n', rad2deg(alpha));

for i=1:step
%     if mod(i,10) == 0
%         fprintf('%d\n', i/10);
%     end
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    theta1 = alpha1 * r / l;
    theta2 = alpha2 * r / l;
     % 转动方程求此时的角加速度。
    beta = (r * (F2 * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1)) - ...
        F1 * (sin(phi + theta1) * cos(alpha) * cos(gamma1) + cos(phi + theta1) * sin(alpha1) * sin(Eta1))) + ...
        F2 * r * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1) - ...
        sin(phi + theta1) * cos(alpha) * cos(gamma1) - cos(phi + theta1) * sin(alpha1) * sin(Eta1)) + ...
        r * (F1 * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2)) - ...
        F2 * (sin(phi + theta2) * cos(alpha) * cos(gamma2) + cos(phi + theta2) * sin(alpha2) * sin(Eta2))) + ...
        F2 * r * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + theta2) * cos(alpha) * cos(gamma2) - cos(phi + theta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
end
fprintf('鼓面倾角：%g°\n', rad2deg(alpha));