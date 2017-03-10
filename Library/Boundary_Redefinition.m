function [NS_final,sink_cell,GridPLot] = Boundary_Redefinition(NC_B,NS,BC,coor,hcb,XX,YY,nn,h_CM,h_CM2) 

intg=1;

nveccells_total_cells = NS.cell(1:end,:);  
nveccells_total_group = NS.group(1:end);
nveccells_total_stepsize = NS.stepsize(1:end);
nveccells_total_index = NS.index(1:end);

sink_cell = length(nveccells_total_cells);

B_identificatior = zeros(length(NS.group(1:end)),1);


for i=1:length(BC)


limits_Extra = [coor(i,1)-(hcb/2) coor(i,1)+(hcb/2) coor(i,2)-(hcb/2) coor(i,2)+(hcb/2)];

[z_E,XX_E,YY_E,nn_E,XP_E,YP_E] = cell_state_space(NC_B,limits_Extra,0);


VFXXYY(i).m = [XX_E YY_E];        
S_E(i) = structures_cell(z_E,0);      

%clustering data boundary cells
nveccells = S_E(i).cell;    
nvecgroup = S_E(i).group;
nvecstepsize = S_E(i).stepsize;
nvecindex = S_E(i).index;

nveccells_total_cells = [nveccells_total_cells;nveccells];
nveccells_total_group = [nveccells_total_group;nvecgroup];
nveccells_total_stepsize = [nveccells_total_stepsize;nvecstepsize];
nveccells_total_index = [nveccells_total_index;nvecindex];

%boundary identificator
B_identificatior = [B_identificatior;zeros(length(nvecgroup),1)];
B_identificatior(BC(i))=1;

end

Final_S = struct('cell',nveccells_total_cells,'group',nveccells_total_group, 'stepsize',nveccells_total_stepsize,'index',nveccells_total_index,'NumGroup',NS.NumGroup);
tic 
NS_final = mapping2(Final_S,XX,YY,nn,h_CM,h_CM2,intg,B_identificatior); 
toc
GridPLot = VFXXYY;

end