close all;
x=linspace(0,2*pi,100); %100个点的x坐标
y=sin(x); %对应的y坐标
plot(x,sin(x),'c',x,cos(x),'g');
axis([0,6,-1.2,1.2]);
xlabel('Input Value'); %x轴注解
ylabel('Function Value'); %y轴注解
legend('y=sin(x)','y=cos(x)');
grid on;