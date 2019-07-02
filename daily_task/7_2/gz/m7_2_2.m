x=linspace(-2, 2, 25); % 在x轴上取25点  

y=linspace(-2, 2, 25); % 在y轴上取25点  

[xx,yy]=meshgrid(x, y); % xx和yy都是21x21的矩阵  

zz=xx.*exp(-xx.^2-yy.^2); % 计算函数值，zz也是21x21的矩阵  

mesh(xx, yy, zz); % 画出立体网状图  