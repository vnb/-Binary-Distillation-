%-----------------------------Draws Operating Lines---------------
% y = m*x + c
% m ==> m1, c1 ==> c, start and end of the range of x values. 
function operating_line( m1 , c1 , start , end2, range)
r = round((end2-start)/range);
A1 = zeros(1,r);
A2 = zeros(1,r);
j = 0;
for i = start : range : end2
    j = j+1;
    A1(1,j) = i ;
    A2(1,j) = m1 * i + c1 ;
end
plot(A1,A2,'red')
end