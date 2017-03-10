function ZoomInXY(M1,BC,mp2,subd,limits,opt,NS)

switch opt
    
    case 1
        
     mp=M1;
     ncf=(length(M1)^0.5);
     mp=reshape(mp,ncf,ncf);

     dce = subd^2 -1;
     ii=1;

        for k=length(M1)+1:subd*subd:length(mp2)

            mpr = mp2(k:k+dce);
            mpr = reshape(mpr,subd,subd);
            Mat(ii).m = mpr;
            ii=ii+1;

        end

        [d1,d2]=size(Mat(1).m); 
        r = rand(size(mp))*1e-3; 
        M = mp+r;                 

        RM = kron(M,ones(d1,d2));

        for jj=1:length(BC)
            RM(find(RM==M(BC(jj)))) = Mat(jj).m;  
        end

        RM=rot90(RM);
        RM=flipud(RM);

        figure('color',[1 1 1])
        hh1=(limits(2)-limits(1))/length(RM);
        hh1=hh1/2;
        hh2=(limits(4)-limits(3))/length(RM);
        hh2=hh2/2;
        span1=[limits(1)+hh1 limits(2)-hh1];
        span2=[limits(3)+hh2 limits(4)-hh2];
        imagesc(span1,span2,RM)
        set(gca,'YDir','normal')
        
        mymap = [1 0 1;0 0.7 0.9];
        colormap(mymap)

    case 2
     
end
end