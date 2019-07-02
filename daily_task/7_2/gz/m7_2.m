close all;
x=linspace(0,2*pi,100); %100�����x����
y=sin(x); %��Ӧ��y����
plot(x,sin(x),'c',x,cos(x),'g');
axis([0,6,-1.2,1.2]);
xlabel('Input Value'); %x��ע��
ylabel('Function Value'); %y��ע��
legend('y=sin(x)','y=cos(x)');
grid on;