 %Binary Distillation 
P = 760 ; %mmHg
%Antoine Constants
A1 = 6.87987 ; B1 = 1196.76 ; C1 = 219.161 ;
A2 = 6.95087 ; B2 =	1342.31	; C2 = 219.187 ;
% Vapor Liquid Equilibrium Curve & polyfit equation representing the equilibrium curve 
l = VLE(A1, B1, C1, A2, B2, C2, P) ;
A = zeros(1,10) ;
j = 0 ;
for i = 0 : 0.1 : 1
    j = j + 1 ;
    A(1,j) = i ;
end
hold on
plot(A,A,'green')
% Enter the molar composition of feed, distillate & bottooms product
xF = 0.440 ;
xD = 0.974 ;
xB = 0.0235 ;
% Reflux ratio of top product
R = 3.5 ;
axis([0 1 0 1]) 
% Feed conditions
% R is reflux
% F = D + B
% F*xF = D*xD+B*xB
% F = Feed ; D = Distillate ; B = Bottoms ; V = Vapor Out ; L = Liquid flow rate ; mol/h
syms x
%Equation for the VLE ===> l(1,1)*x^4+l(1,2)*x^3+l(1,3)*x^2+l(1,4)*x+l(1,5)

B = zeros(1,2) ;
    B(1,1) = xF ;
    B(1,2) = xD ;
    B(1,3) = xB ;
    plot([B(1,1),B(1,1)],[A(1,1),B(1,1)],'yellow')
    plot([B(1,2),B(1,2)],[A(1,1),B(1,2)],'yellow')
    plot([B(1,3),B(1,3)],[A(1,1),B(1,3)],'yellow')
     grid on
%----------------------------------------------------------------------------------
%Boiler Line

R = 3.5 ;
% q is the fraction of liquid in the feed 
q = 0.8 ;
% a is the point of intersection of feed line and operating line 
a = intersection(R/(R+1),-q/(1-q),xD/(R+1),xF/(1-q)) ;

b = R/(R+1)*a+xD/(R+1);
hold on
% Condensate operating line
operating_line( R/(R+1) , xD/(R+1) , a , xD, 0.00001);
hold on
% Feed Line Operating line
operating_line(-q/(1-q),xF/(1-q),a,xF,0.00001);
hold on 
% Reboiler Operating line
m1 = (xB - b)/(xB - a);
c1 = b - m1*a ;
operating_line(m1,c1,xB,a,0.0001);
line1(1,1) = m1 ;
line1(1,2) = c1 ;
line2(1,1) = R/(R+1) ;
line2(1,2) = xD/(R+1) ;
syms x
% VLE Equation
 p1 = l(1,1)*x^4+l(1,2)*x^3+l(1,3)*x^2+l(1,4)*x+l(1,5);
hold on
xlabel(' x ');
ylabel(' y ');
hold on
text(xD,0,'xD');
text(xF,0,'xF');
text(xB,0,'xB');
hold on         
% To generate the number of stages use this function
% Actual Number of stages => Acstages
Acstages = 9 ;
steps(xD,xF,xB,l(1,1),l(1,2),l(1,3),l(1,4),l(1,5),line2(1,1),line2(1,2),line1(1,1),line1(1,2),Acstages)
% Output for the murphree efficiency