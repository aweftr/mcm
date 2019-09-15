clc
clear
d = 0.4; r = d/2; m = 3.6; h = 0.22;
F1 = 90; F2 = 80;
l = 1.7;
phi = asin(0.11/1.7); alpha = 0; omega = 0;
gamma1 = 0; gamma2 = pi / 4;
J = 1/2 * m * r^2 + 1/12 * m * h^2; % 圆环的转动惯量。
step = 1000000;
t = 0.1 / step;
alphadata = [];

% 有策略情况下
% -0.1 - 0 s 提前发力
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    theta1 = alpha1 * r / l;
    beta = r * F2 * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1)) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
% 0 - 0.1 s 正常发力
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    theta1 = alpha1 * r / l;
    theta2 = alpha2 * r / l;
    beta = (F2 * r * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1) - ...
        sin(phi + theta1) * cos(alpha) * cos(gamma1) - cos(phi + theta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + theta2) * cos(alpha) * cos(gamma2) - cos(phi + theta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end

% 0.1 - 0.2 s 反应过来停止发力
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    theta1 = alpha1 * r / l;
    theta2 = alpha2 * r / l;
    beta = (F2 * r * (- sin(phi + theta1) * cos(alpha) * cos(gamma1) - cos(phi + theta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + theta2) * cos(alpha) * cos(gamma2) - cos(phi + theta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end

% 0.2 - 1 s 正常发力
step = 0.8 / t;
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    theta1 = alpha1 * r / l;
    theta2 = alpha2 * r / l;
    beta = (F2 * r * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1) - ...
        sin(phi + theta1) * cos(alpha) * cos(gamma1) - cos(phi + theta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + theta2) * cos(alpha) * cos(gamma2) - cos(phi + theta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
x = -0.1 + (t * 100): (t * 100): 1;
plot(x, alphadata);
hold on


alpha = 0; omega = 0;
alphadata = [];
% 无策略
% -0.1 - 0 s
step = 0.1 / t;
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    theta1 = alpha1 * r / l;
    beta = r * F2 * (sin(phi - theta1) * cos(alpha) * cos(gamma1) - cos(phi - theta1) * sin(alpha1) * sin(Eta1)) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
% 0 - 1 s
step = 1 / t;
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    theta1 = alpha1 * r / l;
    theta2 = alpha2 * r / l;
    beta = (F2 * r * (- sin(phi + theta1) * cos(alpha) * cos(gamma1) - cos(phi + theta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - theta2) * cos(alpha) * cos(gamma2) - cos(phi - theta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + theta2) * cos(alpha) * cos(gamma2) - cos(phi + theta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
plot(x, alphadata);
xlabel('时间(s)');
ylabel('角度(°)');
legend('策略','无策略');