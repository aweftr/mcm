x=linspace(-2, 2, 25); % ��x����ȡ25��  

y=linspace(-2, 2, 25); % ��y����ȡ25��  

[xx,yy]=meshgrid(x, y); % xx��yy����21x21�ľ���  

zz=xx.*exp(-xx.^2-yy.^2); % ���㺯��ֵ��zzҲ��21x21�ľ���  

mesh(xx, yy, zz); % ����������״ͼ  