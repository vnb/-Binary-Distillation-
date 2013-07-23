%Vapor Liquid Equilibrium Data. Select the Antoine Constants for your
%binary mixture from :
%http://www.eng.auburn.edu/users/drmills/mans486/Diffusion%20Tube/Antoine_coefficient_table.PDF
function p = VLE(A1,B1,C1,A2,B2,C2,P)


%A1 = 6.87987 ; B1 = 1196.76 ; C1 = 219.161 ; %Benzene
%A2 = 6.95087 ;	B2 = 1342.31 ; C2 =	219.187 ; %Toluene
% 
% T = Temperature (Celcius) ; P =  Pressure (mm Hg)
syms T1 T2
%P = 760 ; %mmHg 
T1 = round(eval(solve(A1 - B1/(T1+C1)-log10(P),T1))) ;
T2 = round(eval(solve(A2 - B2/(T2+C2)-log10(P),T2))) ;
t = double((T2-T1)/0.5) ;
% Vapor Liquid Equilibrium Curve
x = zeros(1,t) ;
y = zeros(1,t) ;
i = 0 ;
for T = T1 : 0.5 : T2
    i = i+1;
    x(1,i) = (1 - 10^(A2-B2/(T+C2))/P )/(10^(A1-B1/(T+C1))/P - 10^(A2-B2/(T+C2))/P) ;
    y(1,i) =  x(1,i)*10^(A1-B1/(T+C1))/P ;
   % xi = vpa(solve((1- K1 * xi)/(1-xi)-P/P2sat,xi))
end
p = polyfit(x,y,4);
plot(x,y)
% Operating Line

axis([0 1 0 1])

