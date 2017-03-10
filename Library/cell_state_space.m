function [z,XX,YY,nn,XP,YP] = cell_state_space(NC,limits,op)

% functions that creates the cell state space
% the inputs are the number of cell NC and the limits of the interest
% region
% example -> limits = [-2 2 -3 3] ;
%            NC = [3 3];               
%            z = [-1 2;-2 3;...];  
% The output is the cell vector z, and some information about the 
% partition of the state space.
% Note that the last element of the cells vector is the sink cell
% op==1 sink cell (adds sink cell to the output vector)


Xmin = [limits(1) limits(3)]; 
Xmax = [limits(2) limits(4)];
nn=[NC(1) NC(2)];
    
xx=linspace(Xmin(1),Xmax(1),nn(1)+1);
yy=linspace(Xmin(2),Xmax(2),nn(2)+1);


%Mesh the state space:

[XX,YY]=meshgrid(xx,yy);

%To calculate the midpoints of each cell (initial conditions):

XP = (   XX(1:nn(2),1:nn(1))     +     XX(1:nn(2),2:nn(1)+1)    )/2;
YP = (   YY(1:nn(2),1:nn(1))     +     YY(2:nn(2)+1,1:nn(1))    )/2;


XpT = XP';
Xp=XpT(:);
YpT = YP';
Yp=YpT(:);

z=[Xp Yp];

if op==1;
z=[z;[-(Xmax(1)+15.1) -(Xmax(1)+15.1)]]; 
end

end