clc;
clear all;
close all;
tic 

%parameters 
Eq = [0 0]; %                  %Initial point in desired region
num_iter_user = 8;             %Number of iterations defined by user
NC_B = [2 2];                  %Refinement
cell_dim = 3;                  %Cell-size dimension
cell_it = [3 3];               %Initial cell number

%size of initial region
x_l = -cell_dim/2;
x_up = cell_dim/2;
y_l = -cell_dim/2;
y_up = cell_dim/2;

%initial width of the cells
hi = (x_up-x_l)/3; 

lhi = hi;
lhr = hi/NC_B(1);
lbct = ['Initial cell-size  ',num2str(lhi),'  Refinement cell-size   ',num2str(lhr)];
disp(lbct)
xlup_hi = [x_l x_up y_l y_up hi];

%initialization
num_iter = 0;
limits = [x_l+Eq(1) x_up+Eq(1) y_l+Eq(2) y_up+Eq(2)]; 
NC = [cell_it(1) cell_it(2)];                          
[z,XX,YY,nn,XP,YP] = cell_state_space(NC,limits,1);     
NNS = structures_cell(z,1);                             
h_CM = hi; 
h_CM2 = 2*hi;


B_identificatior = zeros(5,1);

bt = waitbar(0,'Computing Layers','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(bt,'canceling',0)

intg = 0;

while(num_iter<=num_iter_user)

if getappdata(bt,'canceling')
   break
end    

num_iter = num_iter +1;

% mapping
NS = mapping2(NNS,XX,YY,nn,h_CM,h_CM2,intg,B_identificatior);

if (num_iter <= num_iter_user)

Dav1 = reshape(NS.group(1:end-1),nn(1),nn(2));

%plotting grid 
PlotIterGridWholemesh(limits,Dav1,XX,YY,Eq,NC,1,num_iter_user,xlup_hi)

%limits update
x_l = x_l - hi;
x_up = x_up + hi;
y_l = y_l - hi;
y_up = y_up + hi;

cell_it = cell_it + [2 2];                              
NC = cell_it;                                           %cell number - update
limits = [x_l+Eq(1) x_up+Eq(1) y_l+Eq(2) y_up+Eq(2)];   %new desired region 
[z,XX,YY,nn,XP,YP] = cell_state_space(NC,limits,1);     %construction of new state space 
S = structures_cell(z,1);                               %data storage of new state space
[NNS] = assing_groups_II(NS,S,XX,YY,nn);                %clustering of tagged and untagged cells
DA_show = reshape(NNS.group(1:end-1),nn(1),nn(2));

end

waitbar(num_iter /(num_iter_user))

end

delete(bt)

PlotIterGridWholemesh(limits,NS.group(1:end-1),XX,YY,Eq,NC,2,num_iter_user,xlup_hi)

%boundary cells' detection
zend = z(1:end-1,:);                              %latest cell vectors  
Nsgroup = NS.group(1:end-1);                      %latest group number vector  
hcb = (limits(2)-limits(1))/NC(1);                %latest cells' width
[BC,coor] = boundary_cells(zend,Nsgroup,hcb);     %provides the index and coordinates of boundary cells
lbc = length(BC);
lbct = ['Boundary cells  ',num2str(lbc)];
disp(lbct)

if  BC==0 %case in which there is no boundary cells   
    NS_pru2 = NS;
    NS_pru2.group(end) = [];
    ZoomInXY(1,1,1,1,limits,2,NS_pru2)
else
    [NS_final,sink_cell,GridPLot] = Boundary_Redefinition(NC_B,NS,BC,coor,hcb,XX,YY,nn,h_CM,h_CM2);
    NS_final.cell(sink_cell,:) = [];
    NS_final.group(sink_cell)  = [];

    %plotting process
    ZoomInXY(Nsgroup,BC,NS_final.group,NC_B(1),limits,1,0)  
    hold on
    for i=1:length(GridPLot)
    plot(GridPLot(i).m(:,1:NC_B(1)+1),GridPLot(i).m(:,NC_B(1)+2:2*(NC_B(1)+1)),'-k','linewidth',0.8)
    hold on
    plot((GridPLot(i).m(:,1:NC_B(1)+1))',(GridPLot(i).m(:,NC_B(1)+2:2*(NC_B(1)+1)))','-k','linewidth',0.8)
    end
    plot(Eq(1),Eq(2),'.k','Linewidth',16,'MarkerSize',16)
    xlabel('x_1','FontSize',14)
    ylabel('x_2','FontSize',14)

    ZoomInXY(Nsgroup,BC,NS_final.group,NC_B(1),limits,1,0)
    hold on
    plot(XX,YY,'-k')
    plot(XX',YY','-k')
    xlabel('x_1','FontSize',14)
    ylabel('x_2','FontSize',14)
    plot(Eq(1),Eq(2),'.k','Linewidth',16,'MarkerSize',16)

end
