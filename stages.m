
%----------------------------stages-------------------------
% xD ==> Distillate molar concentration, fline
function steps(xD,xF,xB,a,b,c,d,e,f,g,h,i,Acstages)
syms x
lll = 1 ;
l = a*x^4+b*x^3+c*x^2+d*x+e ;
l1 = f*x+g ;
l3 = h*x+i ;
steps = 1 ;
y = xD ;
if y > xF
    l2 = l1 ;
else 
    l2 = l3 ;
end
    while y > xB 
      if y > xF
    l2 = l1 ;
else 
    l2 = l3 ;
      end
        if mod(steps,2) == 0
            P(1,1) = P(1,2) ;
            P(1,2) = P(1,1) ;
            Q(1,1) = subs(l,x,y) ;
            Q(1,2) = subs(l2,P(1,1));
            plot(P,Q)
            
            y = P(1,2) ;
        steps = steps+1 ;
        else
            
            lll = lll+1 ;
            %s2 = subs(l2,x,y) ;
        P(1,1) = y ;
        Q(1,1) = subs(l2,x,P(1,1));
        great = eval(solve(l - Q(1,1),x)) ;
        P(1,2) = subs(great(3)); 
        Q(1,2) = Q(1,1);
        plot(P,Q)
        y = P(1,2) ;
        steps = steps+1;
        end
        
        
        
        
        
    end
  disp(Acstages/(steps/2-2))   
end