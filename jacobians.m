function [J1,J2,d2H] = jacobians(t,y,params,str)

%Jacobian in region S1 (H(x) > 0)
J1 = [-1 1;0 3];

%Jacobian in region S2 (H(x) < 0)
J2 = J1;

% grad(grad(H)) A vector normal to the discontinuity surface
d2H = zeros(size(J1));



% % %%% nonsmooth system
% 
% % Parameters multiple crossing
% 
% % % 
% %Jacobian in region S1 (H(x) > 0)
% 
% J1 = [3, 1;
%     3, 1/2];
% 
% %Jacobian in region S2 (H(x) < 0)
% 
% J2 = [-1, 1;
%     -1, 1/2];
% 
% % grad(grad(H)) A vector normal to the discontinuity surface
% 
% d2H = zeros(size(J1));



% %%% Dry friction oscillator Merillas-Galvaneto
% 
% % parameters
% 
% alpha = 0.3;
% g = 10;
% gamma = 1.42;
% Vdr = 1;
% eta = 0.01;
% 
% %Jacobian in region S1 (H(x) > 0)
% 
% J1 = [0,1;
%     -1,g*gamma*alpha/(1+gamma*(y(2)-Vdr))^2 - 2*g*eta*(y(2)-Vdr)];
% 
% %Jacobian in region S2 (H(x) < 0)
% 
% J2 = [0,1;
%     -1,g*gamma*alpha/(1-gamma*(y(2)-Vdr))^2 + 2*g*eta*(y(2)-Vdr)];
% 
% % grad(grad(H)) A vector normal to the discontinuity surface
% 
% d2H = zeros(size(J1));



% %%% Unforced mechanical discontinuous system
% 
% % parameters
% c = -0.5;
% 
% %Jacobian in region S1 (H(x) > 0)
% 
% J1 = [0,1;
%     -1,-c];
% 
% %Jacobian in region S2 (H(x) < 0)
% 
% J2 = [0,1;
%     -1,-c];
% 
% % grad(grad(H)) A vector normal to the discontinuity surface
% 
% d2H = zeros(size(J1));


% %%% Unforced Disc. Mech. Syst nonlinear spring 
% 
% % parameters
% a21 = 0.1;
% a22 = -1;
% 
% %Jacobian in region S1 (H(x) > 0)
% 
% J1 = [0,1;
%     a21-3*y(1)^2,a22];
% 
% %Jacobian in region S2 (H(x) < 0)
% 
% J2 = J1;
% 
% % grad(grad(H)) A vector normal to the discontinuity surface
% 
% d2H = zeros(size(J1));

