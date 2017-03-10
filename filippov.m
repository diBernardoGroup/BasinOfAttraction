function [tvect,yvect,te,ye,ie,se] = filippov(vfields,jacobians,pfunction,solver,tspan,y0,params,C,inopts,h_CM,h_CM2,INTG,XX,YY,nn,Bident)
                                         
global vy0 hcm hcm2 intg
hcm = h_CM;
hcm2 = h_CM2;
vy0 = y0;
intg = INTG;

t1 = tspan(end);
t0 = tspan(1);

[state,dir] = findstate(vfields,jacobians,t0,y0,params);
         
options = odeset(inopts,'Events',@fevents);

yvect = [];tvect = [];
te = []; ye = []; ie = []; se = [];
stopit = 0;

while ~stopit

    [t,y,TE,YE,IE] = feval(solver,@filippovfunc,tspan,y0,options,vfields,jacobians,params,C,state,dir);
    
    y0 = y(end,:);
    
    yvect = [yvect;y];
    tvect = [tvect;t];
    te = [te;TE];
    ye = [ye;YE];

    if length(tspan) == 2
        tspan =[t(end),t1];   %linea originale
    else
        tspan = [t(end),tspan(tspan>t(end))];    
    end
    
    if ~isempty(IE) & (t(end)~=t1)
        for k = 1:length(IE)
            ie = [ie;IE(k)];
            if IE(k) == 4
                if ~isempty(pfunction)
                    y0 = feval(pfunction,t,y0,params);                
                end
            else
                switch 1
                    case state(3)
                        switch IE(k)
                            case {2,3}
                                state(IE(k)-1) = -state(IE(k)-1);
                                state(3) = -state(3);
                                state(4) = -state(4);
                                state(5) = -state(5);    
                                dir([1,IE(k)]) = -[1,dir(IE(k))];
                            case 5,
                            
                            otherwise
                                disp('Error, there is something wrong with the event in filippov')
                        end
                    case state(4)
                        switch IE(k)
                            case 1,
                               state(1)=-state(1);
                               state(2)=-state(2);                           
                               dir(IE(k)) = -dir(IE(k));
                            case {2,3}
                                state(4) = -state(4);
                                state(5) = -state(5);    
                                dir(IE(k)) = -dir(IE(k));
                            case 5,
                            
                            otherwise
                                disp('Error, there is something wrong with the event in filippov')
                        end
                    case state(5)
                        switch IE(k)
                            case 1,
                               state(1)=-1;
                               state(2)=-1;
                               state(3)=-state(3);
                               dir(IE(k)) = -dir(IE(k));
                            case {2,3}
                                state(4) = -state(4);
                                state(5) = -state(5);    
                                dir(IE(k)) = -dir(IE(k));
                            case 5,
                                
                           otherwise
                                disp('Error, there is something wrong with the event in filippov')
                        end
                    otherwise
                        disp('Error, There is something wrong with the state vector in filippov')        
                end
            end
            se = [se;state];                
        end
    elseif ~isempty(IE)
       stopit =1;
       ie = [ie;IE];
       se = [se;state];
    else
       stopit =1;    
    end
    
   %complilation 
   
   if intg==0
    
   if sum(find(ie==5))~=0
      stopit =1; 
   end
   
   else
      
   condition= ( y0(1) < XX(1,1) ) | ( y0(1) > XX(1,nn(1)+1) ) | ( y0(2) < YY(1,1) ) | ( y0(2) > YY(nn(2)+1,1) );
  
    if condition 
       cellnum=(nn(1)^2 +1); 
    else
       xnr = min(find(y0(1) <= XX(1,2:nn(1)+1)));
       ynr = min(find(y0(2) <= YY(2:nn(2)+1,1)));
       cellnum = xnr + nn(1)*(ynr-1);
  
    end

    Cond_bc = Bident(cellnum);
   
    if (sum(find(IE==5))~=0) 

          if (Cond_bc==0)
              stopit =1;  
          else
              hcm2 = hcm2+0.5;
          end

    elseif (sum(IE)~=0)

          if (Cond_bc==0)
              stopit =1;  
          end
    end
   
   
   end
   
   
end 


end
%-------------------- findstate ------------------------

function [state,dir] = findstate(vfields,jacobians,t0,y0,params);

state = -1*ones(1,5);

[F1,F2,H,dH,h1,hdir] = feval(vfields,t0,y0,params,'');

dHF1 = dH*F1;
dHF2 = dH*F2;

dir = [-sign(H),-sign(dHF1),-sign(dHF2)];

if H > 0    
    state(1) = -state(1);
elseif H < 0
    state(2) = -state(2);
elseif sign(dHF1)*sign(dHF2) < 0
    state(3) = -state(3);
else
    if sign(dHF1) > 0
        state(1) = -state(1);
    else
        state(2) = -state(2);
    end
end

if sign(dHF1)*sign(dHF2) > 0
    state(4) = -state(4);
elseif sign(dHF1)*sign(dHF2) < 0
    state(5) = -state(5);    
else
    if isempty(jacobians)
        state(4) = -state(4);
    else
        [J1,J2,d2H] = feval(jacobians,t0,y0,params,'');
        if dHF1 == 0
            HxF1x_F1Hxx = dH*J1 + F1'*d2H;
            sig = sign(HxF1x_F1Hxx*F1)*sign(dHF2);
            dir(2) = -sign(HxF1x_F1Hxx*F1);
        elseif dHF2 == 0
            HxF2x_F2Hxx = dH*J2 + F2'*d2H;
            sig = sign(HxF2x_F2Hxx*F2)*sign(dHF1);
            dir(3) = -sign(HxF2x_F2Hxx*F2);
        else
            disp('ERROR: Something is wrong in filippov:findstate')
            sig = 1;
        end
        
        if sig < 0
            state(5) = -state(5);
        else
            state(4) = -state(4);
        end
    end
end
end

%-------------------- filippovfunc ------------------------

function dy = filippovfunc(t,y,vfields,jacobians,params,C,state,dir);

dy=zeros(length(y),1);

[F1,F2,H,dH,h1,hdir] = feval(vfields,t,y,params,'');

switch 1
    case state(1)
        % Vector field in region 1        
        F = F1;
    case state(2)
        % Vector field in region 2        
        F = F2;
    case state(3)
        % Vector field on sliding region
        
        Fa   = 0.5*F1;
        Fb   = 0.5*F2;
        dHF1 = dH*F1;
        dHF2 = dH*F2;
        Hu   = -((dHF1+dHF2)/(dHF2-dHF1));
        F    = (Fa + Fb) + Hu*(Fb - Fa)- C*H*dH';       
    otherwise
        disp('Error, there is something wrong with the state vector in filippov:filippovfunc')
end

dy = F;
end

%-------------------- filippovevents ------------------------

function [value,isterminal,direction] = fevents(t,y,vfields,jacobians,params,C,state,dir)
global vy0 hcm hcm2 intg

E = vy0'-y;

if intg==1
bnorm = norm(E,inf)-(hcm/2 + 1.2);
else
bnorm = norm(E,inf) - hcm2 ;    
end    
    
[F1,F2,H,dH,h,hdir] = feval(vfields,t,y,params,'');

dHF1 = dH*F1;
dHF2 = dH*F2;
value = [H,dHF1,dHF2,h,bnorm];
direction = [dir,hdir,0];    

switch 1
    case {state(1),state(2)}
        direction(1) = -state(1);
    case state(3)
        value(1) = 1;
        
        if isempty(jacobians)
            value      = [value,1];
            direction = [direction,0];
        else
            [J1,J2,d2H] = feval(jacobians,t,y,params,'');
            
            dHF1_p_dHF2 = dHF1+dHF2;
            dHF2_dHF1   = dHF2-dHF1;

            Hu   = -((dHF1_p_dHF2)/(dHF2_dHF1));
            
            F2_F1 = F2-F1;
            F2_F1_2 = 0.5*F2_F1;
            F1_p_F2 = F1+F2;
            F1_p_F2_2 = 0.5*F1_p_F2;

            J2_J1 = J2-J1;
            J2_J1_2 = 0.5*J2_J1;
            J1_p_J2 = J1+J2;
            J1_p_J2_2 = 0.5*J1_p_J2;
        
            dHu  = -(((F1_p_F2')*d2H+dH*(J1_p_J2))*(dHF2_dHF1)-((F2_F1')*d2H + dH*(J2_J1))*(dHF1_p_dHF2))/(dHF2_dHF1^2);
            F    = (F1_p_F2_2) + (F2_F1_2)*Hu - C*H*dH';

            dHuF = dHu*F;
            value = [value,dHuF];
            direction  = [direction,0];
            
        end
        
    otherwise
        disp('ERROR: Wrong event in filippov:fevents')
end

isterminal = [1,1,1,1,1];
end


