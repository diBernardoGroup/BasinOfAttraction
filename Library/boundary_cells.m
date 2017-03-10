function [NV_BC,cell_coor] = boundary_cells(z,Nsgroup,rr)

% This function determinane the cells on the boundary of the domain of
% attraction. The inputs are:
% z => is a cell vector
% Nsgroup is vector containing the cell's group.
% the outputs are two dimensional arrays containing the indices and
% centroids.
adj_cells=[];
ii=1;
Z=1:length(z); % size of the examined cells

for i=1:length(z)
for j=1:length(z)
  
   E = z(i,:)-z(j,:); 
   dis = norm(E,inf); 
   
   if (dis<(rr+rr/2) && (Nsgroup(i)~=Nsgroup(j)))
      adj_cells(ii,:) = [Z(i) Z(j)];
      ii=ii+1;
   end
   
end
end

TF = isempty(adj_cells);

if TF==1
    NV_BC = 0;
    cell_coor = 0;
    disp('There is no boundary basins')
    
else

    NV_BC = adj_cells;
    NV_BC = unique(NV_BC);
    cell_coor_bound=[];

    for i=1:length(NV_BC)
         cell_coor_bound =[cell_coor_bound;z(NV_BC(i),:)];
    end
    cell_coor = cell_coor_bound;
end

end