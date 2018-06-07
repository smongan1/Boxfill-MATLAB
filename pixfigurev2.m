function [ figout ] = pixfigure( fgsz,fig )
sx=size(fig,2);
sy=size(fig,1);
msx=max(sx,3);
msy=max(sy,3);
fy=max(ceil(fgsz(1)/msy),1);
fx=max(ceil(fgsz(2)/msx),1);
figout=zeros(2*msy*fy,2*msx*fx);
sz=size(figout);
topr=fig(1,:);
botr=fig(end,:);
idd=find(topr<240,1,'last');
spc=length(topr)-idd+find(botr<240,1,'first');
cnt=0;
xrows=zeros(msy,size(figout,2));
while(cnt*sx<(1.8*fgsz(2)))
    xrows(1:sy,(1+cnt*msx):(cnt*msx+sx))=fig;
    cnt=cnt+1;
end
cnt=0;
ms=size(figout,2)/spc;
while(cnt*msy<0.9*sz(1))
    xid=cnt*msy+(1:msy);
    yid=spc*mod(cnt,ms)+(1:(size(figout,2)-spc*ms));
    figout(xid,yid)=xrows(:,1:(size(figout,2)-spc*ms));
    cnt=cnt+1;
end
bnds=[1,ceil(sz(1)*.9),1,ceil(sz(2)*.9)];
figout=figout(bnds(1):bnds(2),bnds(3):bnds(4));
fgsz=ceil(fgsz);
figout=figout(1:fgsz(1),spc*ms+2:fgsz(2)+spc*ms+1);
figout(:,end)=0;
figout(:,1)=0;
figout(1,:)=0;
figout(end,:)=0;
end
