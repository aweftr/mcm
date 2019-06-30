x=[1 2 3 4 5 6 7 8 9];
y=[9 7 6 3 -1 2 5 7 20];
P=polyfit(x,y,3);
xi=0:.2:10;
yi=polyval(P,xi);
plot(xi,yi,x,y,'r*');