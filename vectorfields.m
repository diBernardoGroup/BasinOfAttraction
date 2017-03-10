function [F1,F2,H,dH,h,dir] = vectorfields(t,y,params,str)

%%% Relay system

%Vector field in region 1 - H(x) > 0

F1 = [-y(1)+y(2);
      3*y(2)-10];

%Vector field in region 2 - H(x) < 0

F2 = [-y(1)+y(2);
      3*y(2)+10];

%Switching Manifold

H = y(1)+y(2);

%A vector normal to the switching manifold
dH = [1,1];

%Poincare section
h = 1;

%Location directrion
dir = 1;



% %%% nonsmooth system

% Vector field in region 1 - H(x) > 0
% 
% F1 = [3*y(1)+y(2);
%     3*y(1)+0.5*y(2)-1];
% 
% Vector field in region 2 - H(x) < 0
% 
% F2 = [-y(1)+y(2);
%     -y(1)+0.5*y(2)-1]; 
% 
% Switching Manifold
% H = y(1);
% 
% A vector normal to the switching manifold
% dH = [1,0];
% 
% Poincare section
% h = 1;
% 
% Location directrion
% dir = 1;
% 


% %%% Dry friction oscillator Merillas-Galvaneto
% 
% % parameters
% m = 1;
% k = 1;
% alpha = 0.3 ;
% a = 3.6;
% beta = 0.1;
% w = 1.067;
% g = 10;
% gamma = 1.42;
% Vdr = 1;
% eta = 0.01;
% 
% %Vector field in region 1 - H(x) > 0
% 
%   F1 = [y(2);
%        (-k*y(1) + a*cos(w*t))/m - g*(alpha/(  1 + gamma*(y(2) - Vdr)) + beta + eta*(y(2) - Vdr)^2)]; 
% 
% %Vector field in region 2 - H(x) < 0
% 
%   F2 = [y(2);
%        (-k*y(1) + a*cos(w*t))/m + g*(alpha/(  1 - gamma*(y(2) - Vdr)) + beta + eta*(y(2) - Vdr)^2)];  
% 
% %Switching Manifold
% H = y(2) - 1;
% 
% %A vector normal to the switching manifold
% dH = [0,1];
% 
% %Poincare section
% h = 1;
% 
% %Location directrion
% dir = 1;


% %%% Unforced mechanical discontinuous system
% 
% % parameters
% m = 1;
% k = 1;
% c = -0.5;
% 
% %Vector field in region 1 - H(x) > 0
% 
% F1 = [y(2);
%    -(c/m)*y(2) - 1 - (k/m)*y(1)]; 
% 
% %Vector field in region 2 - H(x) < 0
% 
% F2 = [y(2);
%    -(c/m)*y(2) + 1 - (k/m)*y(1)];  
% 
% %Switching Manifold
% H = y(2);
% 
% %A vector normal to the switching manifold
% dH = [0,1];
% 
% %Poincare section
% h = 1;
% 
% %Location directrion
% dir = 1;



% %%% Unforced Disc. Mech. Syst nonlinear spring 
% 
% % parameters
% a21 = 0.1;
% a22 = -1;
% fs = 1;
% 
% %Vector field in region 1 - H(x) > 0
% 
% F1 = [y(2);
%    a22*y(2) - fs + a21*y(1) - y(1)^3 - fs]; 
% 
% %Vector field in region 2 - H(x) < 0
% 
% F2 = [y(2);
%    a22*y(2) - fs + a21*y(1) - y(1)^3 + fs]; 
% 
% %Switching Manifold
% H = y(2);
% 
% %A vector normal to the switching manifold
% dH = [0,1];
% 
% %Poincare section
% h = 1;
% 
% %Location directrion
% dir = 1;