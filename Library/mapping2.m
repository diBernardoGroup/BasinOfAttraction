function NS = mapping2(S,XX,YY,nn,h_CM,h_CM2,intg,B_identificatior)

for k=1:(length(S.cell))
    
b=k;
j=0;

    while((S.group(b)==0))
    
            S.group(b) = -1;
        S.index(b) = IMCELL(S.cell(b,:),XX,YY,nn,h_CM,h_CM2,intg,B_identificatior);
        
        b = S.index(b);
        j=j+1;
    end
    
   if S.group(b)==-1
        
         S.NumGroup = S.NumGroup+1;
  
        for l=0:j-2
         
               S.group(k) = S.NumGroup;  
               S.stepsize(k) = j-1-l;
               k = S.index(k);
               
        end
        
        for l=j-1:j-1
        
             S.group(k) = S.NumGroup;  
             S.stepsize(k) = 0;
             k = S.index(k);   
             
        end
    
    elseif S.group(b)>0
        
       for l=0:j-1
           
             S.group(k) = S.group(b);  
             S.stepsize(k) = S.stepsize(b) + j - l;
             k = S.index(k);  
                       
        end
            
             
   end
   
end
NS=S;
end
