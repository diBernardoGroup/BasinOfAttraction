function S = structures_cell(z,op)

dim = length(z);
g=zeros(dim,1); 
c=[];
ss=[];
Ng=0; 

S.cell = z;
S.group = g;
S.stepsize = ss;
S.index = c;
S.NumGroup = Ng;

if op==1
S.group(dim) = 1;
S.stepsize(dim) = 0;
S.index(dim) = dim;
S.NumGroup = 1;   
end


end