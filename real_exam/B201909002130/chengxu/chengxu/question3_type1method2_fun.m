function [alphadata] = question3_type1method2_fun(F1)
% 计算不同的 F1 对之后的转动角度造成的影响。
d = 0.4; r = d/2; m = 3.6; h = 0.22; F2 = 80;
l = 1.7;
phi = asin(0.11/1.7); alpha = 0; omega = 0;
gamma1 = 0; gamma2 = pi / 4;
J = 1/2 * m * r^2 + 1/12 * m * h^2; %圆环的转动惯量。
step = 1000000;
t = 1 / step; % 0.1 秒的步长。
alphadata = [];

% -0.1 - 0 s 先发力 80 N
step = 0.1 / t;
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    beta1 = alpha1 * r / l;
    beta = r * F2 * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1)) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
% 0 - 0.1 s 一起发力 80 N
for i=1:step
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    beta1 = alpha1 * r / l;
    beta2 = alpha2 * r / l;
    beta = (F2 * r * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1) - ...
        sin(phi + beta1) * cos(alpha) * cos(gamma1) - cos(phi + beta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end
% 0.1 - 0.2 s 对面发力增大
for i=1:step
%     if mod(i,10) == 0
%         fprintf('%d\n', i/10);
%     end
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    beta1 = alpha1 * r / l;
    beta2 = alpha2 * r / l;
    beta = (r *(F2 * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1)) - ...
        F1 * (sin(phi + beta1) * cos(alpha) * cos(gamma1) + cos(phi + beta1) * sin(alpha1) * sin(Eta1))) + ...
        2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end

% 0.2 - 1 s 恢复正常
step = 0.8 / t;
for i=1:step
%     if mod(i,10) == 0
%         fprintf('%d\n', i/10);
%     end
    alpha1 = asin(sin(alpha) * cos(gamma1));
    alpha2 = asin(sin(alpha) * cos(gamma2));
    Eta1 = acos(sin(gamma1) / cos(alpha1));
    Eta2 = acos(sin(gamma2) / cos(alpha2));
    beta1 = alpha1 * r / l;
    beta2 = alpha2 * r / l;
    beta = (F2 * r * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1) - ...
        sin(phi + beta1) * cos(alpha) * cos(gamma1) - cos(phi + beta1) * sin(alpha1) * sin(Eta1)) + ...
        2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
        sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
    alpha = alpha + omega * t + 1/2 * beta * t^2;
    omega = omega + beta * t;
    if mod(i,100) == 0
        alphadata = [alphadata, rad2deg(alpha)];
    end
end