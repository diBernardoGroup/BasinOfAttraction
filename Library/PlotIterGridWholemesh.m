function PlotIterGridWholemesh(limits,Dav1,XX,YY,Eq,NC,opt,num_iter_user,xlup_hi)

x_l = (xlup_hi(1) + Eq(1)) - num_iter_user*xlup_hi(5);
x_up = (xlup_hi(2) + Eq(1)) + num_iter_user*xlup_hi(5);
y_l = (xlup_hi(3) + Eq(2)) - num_iter_user*xlup_hi(5);
y_up = (xlup_hi(4) + Eq(2)) + num_iter_user*xlup_hi(5);
limitsw = [x_l x_up y_l y_up];
%
switch opt
    
    case 1

    figure('color',[1 1 1])
    hh1=(limits(2)-limits(1))/NC(1); 
    hh1=hh1/2;
    hh2=(limits(4)-limits(3))/NC(2);
    hh2=hh2/2;

    span1=[limits(1)+hh1 limits(2)-hh1];
    span2=[limits(3)+hh2 limits(4)-hh2];

    RMvor=rot90(Dav1);
    RMvor=flipud(RMvor);

    %plot DA
    imagesc(span1,span2,RMvor)
    set(gca,'YDir','normal')
    hold on
    plot(XX,YY,'-k','Linewidth',0.8)
    plot(XX',YY','-k','Linewidth',0.8)
    plot(Eq(1),Eq(2),'.k','Linewidth',16,'MarkerSize',16)
    xlabel('x_1','FontSize',16)
    ylabel('x_2','FontSize',16)
    axis(limitsw)
    mymap = [1 0 1;0 0.7 0.9];
    colormap(mymap)


    case 2
        
    Dav1=reshape(Dav1,NC(1),NC(2));  
    figure('color',[1 1 1])
    hh1=(limits(2)-limits(1))/NC(1);
    hh1=hh1/2;
    hh2=(limits(4)-limits(3))/NC(2);
    hh2=hh2/2;
    span1=[limits(1)+hh1 limits(2)-hh1];
    span2=[limits(3)+hh2 limits(4)-hh2];
    RMvor=rot90(Dav1);
    RMvor=flipud(RMvor);
    imagesc(span1,span2,RMvor)
    set(gca,'YDir','normal')
    hold on
    plot(XX,YY,'-k')
    plot(XX',YY','-k')
    plot(Eq(1),Eq(2),'.k','Linewidth',16,'MarkerSize',16)
    xlabel('x_1','FontSize',14)
    ylabel('x_2','FontSize',14)
    mymap = [1 0 1;0 0.7 0.9];
    colormap(mymap)

end


end