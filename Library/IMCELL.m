function [cellnum] = IMCELL(xy,XX,YY,nn,h_CM,h_CM2,intg,Bident)

% ODE solver
solver = 'ode45';
opts = odeset('InitialStep',1e-7,'RelTol',1e-5,'AbsTol',[1e-5 1e-5],'MaxStep',0.1);

% Name of the file with the two vectorfields
vfields = 'vectorfields';

% Name of the file with the two Jacobianss
jacobians = 'jacobians';

% Integration time
T = 2;
tspan = [0 T];

% Filippov parameters
Cp = 1;
params = []; 


   
[t1,y1,te1,ye1,ie1,se1] = filippov(vfields,jacobians,[],solver,tspan,xy,params,Cp,opts,h_CM,h_CM2,intg,XX,YY,nn,Bident);

Xsolend = y1(end,:);
xy = Xsolend;

condition= ( xy(1) < XX(1,1) ) | ( xy(1) > XX(1,nn(1)+1) ) | ( xy(2) < YY(1,1) ) | ( xy(2) > YY(nn(2)+1,1) );

if condition 
   
    cellnum=(nn(1)^2 +1);

else
    
    xnr=min(find(xy(1) <= XX(1,2:nn(1)+1)));
    ynr=min(find(xy(2) <= YY(2:nn(2)+1,1)));
    
    cellnum= xnr + nn(1)*(ynr-1);
end

end