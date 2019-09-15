clc
clear
d = 0.4; r = d/2; m = 3.6; h = 0.22;
F1 = 80; F2 = 80;
mu1 = 0; mu2 = 80;
% 根据 3 sigma 法则求出使发力时间大部分在[-0.2, 0.2]，力度大部分在 80 +- 10% 情况下的正态分布参数。
sigma1 = (0.2 - mu1) / 2.58; sigma2 = 80 * 0.1 / 2.58;

L = 2;
phi = asin(0.11/L); alpha = 0; omega = 0;
gamma1 = 0; gamma2 = pi / 4;
J = 1/2 * m * r^2 + 1/12 * m * h^2; %圆环的转动惯量。
step = 1000000;
t = 1 / step;
alphadata = [];

hold on
% 10 次随机
for j = 1:10
    alphadata = 0;
    random_t = normrnd(mu1, sigma1);
    random_F1 = normrnd(mu2, sigma2);
    % 早发力
    if random_t < 0
        step = abs(random_t) / t;
        for i=1:step
            alpha1 = asin(sin(alpha) * cos(gamma1));
            Eta1 = acos(sin(gamma1) / cos(alpha1));
            beta1 = alpha1 * r / L;
            beta = r * random_F1 * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1)) / J;
            alpha = alpha + omega * t + 1/2 * beta * t^2;
            omega = omega + beta * t;
            if mod(i,100) == 0
                alphadata = [alphadata, rad2deg(alpha)];
            end
        end
        step = 1 / t;
        for i=1:step
            alpha1 = asin(sin(alpha) * cos(gamma1));
            alpha2 = asin(sin(alpha) * cos(gamma2));
            Eta1 = acos(sin(gamma1) / cos(alpha1));
            Eta2 = acos(sin(gamma2) / cos(alpha2));
            beta1 = alpha1 * r / L;
            beta2 = alpha2 * r / L;
            beta = (r * (random_F1 * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1)) - ...
                F2 * (sin(phi + beta1) * cos(alpha) * cos(gamma1) + cos(phi + beta1) * sin(alpha1) * sin(Eta1))) + ...
                2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
                sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
            alpha = alpha + omega * t + 1/2 * beta * t^2;
            omega = omega + beta * t;
            if mod(i,100) == 0
                alphadata = [alphadata, rad2deg(alpha)];
            end
        end
        % 晚发力
    else if random_t > 0
            step = random_t / t;
            for i=1:step
                alpha1 = asin(sin(alpha) * cos(gamma1));
                alpha2 = asin(sin(alpha) * cos(gamma2));
                Eta1 = acos(sin(gamma1) / cos(alpha1));
                Eta2 = acos(sin(gamma2) / cos(alpha2));
                beta1 = alpha1 * r / L;
                beta2 = alpha2 * r / L;
                beta = (r * (- F2 * (sin(phi + beta1) * cos(alpha) * cos(gamma1) + cos(phi + beta1) * sin(alpha1) * sin(Eta1))) + ...
                    2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
                    sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
                alpha = alpha + omega * t + 1/2 * beta * t^2;
                omega = omega + beta * t;
                if mod(i,100) == 0
                    alphadata = [alphadata, rad2deg(alpha)];
                end
            end
            step = 1 / t;
            for i=1:step
                alpha1 = asin(sin(alpha) * cos(gamma1));
                alpha2 = asin(sin(alpha) * cos(gamma2));
                Eta1 = acos(sin(gamma1) / cos(alpha1));
                Eta2 = acos(sin(gamma2) / cos(alpha2));
                beta1 = alpha1 * r / L;
                beta2 = alpha2 * r / L;
                beta = (r * (random_F1 * (sin(phi - beta1) * cos(alpha) * cos(gamma1) - cos(phi - beta1) * sin(alpha1) * sin(Eta1)) - ...
                    F2 * (sin(phi + beta1) * cos(alpha) * cos(gamma1) + cos(phi + beta1) * sin(alpha1) * sin(Eta1))) + ...
                    2 * F2 * r * (sin(phi - beta2) * cos(alpha) * cos(gamma2) - cos(phi - beta2) * sin(alpha2) * sin(Eta2) - ...
                    sin(phi + beta2) * cos(alpha) * cos(gamma2) - cos(phi + beta2) * sin(alpha2) * sin(Eta2))) / J;
                alpha = alpha + omega * t + 1/2 * beta * t^2;
                omega = omega + beta * t;
                if mod(i,100) == 0
                    alphadata = [alphadata, rad2deg(alpha)];
                end
            end
        end
    end
    plot(alphadata);
end
xlabel('时间(10^{-6}s)');
ylabel('角度(°)');