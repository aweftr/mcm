clc
clear
d = 0.4; r = d/2; m = 3.6; h = 0.22; g = 9.8; L = 2;
phi = asin(0.11/L); F1 = 80; F2 = 80;
F = F1 * 10;
az = (F * sin(phi) - m * g) / m;
lambada = deg2rad(0.5) * r / L;

syms t1 t2
equ1 = -g * t1 * t2 + 1/2 * az * t2^2 == 1/2 * g * t1^2;
equ2 = t1 + t2 == 2 * sqrt(1.2 / g);
[t1, t2] = solve([equ1, equ2], [t1, t2]);
fprintf('下降时间：%g\n减速与上升时间：%g\n', t1(2), t2(2));

gammai = [deg2rad(12), deg2rad(24), deg2rad(48), deg2rad(60), deg2rad(84)];
J = 1/2 * m * r^2 + 1/12 * m * h^2; % 圆环的转动惯量。
step = 10000;
t = double(t2(2) / 2 / step);

alphai = zeros(1,5);
Etai = zeros(1,5);
betai = zeros(1,5);
while 1
    alpha = deg2rad(-0.5);
    omega = 0;
    alphadata = [];
    for i = 1 : step
        for j = 1 : 5
            alphai(j) = - asin(sin(alpha) * cos(gammai(j)));
            Etai(j) = acos(sin(gammai(j)) / cos(alphai(j)));
            betai(j) = alphai(j) * r / L;
        end
        temp = F1 * r * sin(Etai(1)) * sin(alphai(1)) * (cos(phi + lambada - betai(1)) + cos(phi - lambada + betai(1)));
        for j = 2 : 5
            temp = temp + F2 * r * sin(Etai(j)) * sin(alphai(j)) * (cos(phi + lambada - betai(j)) + cos(phi - lambada + betai(j)));
        end
        beta = temp / J;
        alpha = alpha + omega * t + 1/2 * beta * t^2;
        omega = omega + beta * t;
        alphadata = [alphadata, rad2deg(alpha)];
    end
    if abs(rad2deg(alpha) - 0.5) <= 0.5 * 0.001
        break
    else
        F1 = F1 - 0.001; % 这里的运算符号为加或者减，根据具体情况定。在这里是减。
        F2 = (F - F1 * 2) / 8;
    end
end
fprintf('F1：%g\nF2：%g\n', F1, F2);
fprintf('alpha：%g\n', rad2deg(alpha));