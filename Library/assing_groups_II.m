function [NS] = assing_groups_II(NS,S,XX,YY,nn)

for i=1:length(NS.cell)-1

oldcell = NS.cell(i,:);
oldindex = NS.cell(NS.index(i),:);


xnr = min(find(oldcell(1) <= XX(1,2:nn(1)+1)));
xnr_o = min(find(oldindex(1) <= XX(1,2:nn(1)+1)));

ynr = min(find(oldcell(2) <= YY(2:nn(2)+1,1)));
ynr_o = min(find(oldindex(1) <= YY(2:nn(2)+1,1)));
    
cellnum = xnr + nn(1)*(ynr-1);
cellnum_index = xnr_o + nn(1)*(ynr_o-1);

S.group(cellnum) = NS.group(i);
S.stepsize(cellnum) = NS.stepsize(i);
S.index(cellnum) = cellnum_index ; 

end
S.NumGroup = NS.NumGroup;

NS=S;
end