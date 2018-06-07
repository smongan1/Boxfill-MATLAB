function boxfillv5( bnds, sbl, fnt )
%bnds=[bottomedge,leftedge,width,height] fnt={fontsize,fontname} sbl=symbol
%used to fill bnds
cf=gcf;
af=gca;
ap=get(af,'Position');
if nargin==2
    tfnt='Arial';
    sfnt=14;
else
    sfnt=fnt{1};
    tfnt=fnt{2};
end


%gets the window size in pixels
wsize=get(cf,'Position');
wsize=[wsize(3),wsize(4)];


asize=get(af,'Position');
asize=[asize(3),asize(4)].*wsize;%gets the axis size in pixels

xlims=get(af,'XLim');
xrng=xlims(2)-xlims(1);%gets range for x

ylims=get(af,'YLim');
yrng=ylims(2)-ylims(1);%gets range for y

%gets pixel size and position of bar patch
pixbnds=bnds;
pixbnds(1)=(bnds(1)/yrng)*asize(1);
pixbnds(2)=(bnds(2)/xrng)*asize(2);
pixbnds(4)=(bnds(4)/yrng)*asize(2);
pixbnds(3)=(bnds(3)/xrng)*asize(1);

%gets the pixel size of the symbol used to fill
if ischar(sbl)
    imff=letgr(sbl,fnt);
else
    imff=sbl;
    if size(imff,3)==3
        imff=0.2989*imff(:,:,1) + 0.5870*imff(:,:,2) + 0.1140*imff(:,:,3);
    end
end
figout=pxfg(pixbnds(3:4),imff);
ex=[bnds(1)/xrng+ap(1),bnds(2)/yrng+ap(2),(bnds(3)/xrng)*ap(3),(bnds(4)/yrng)*ap(4)];
figure(cf)
image([bnds(1),bnds(1)+bnds(3)],[bnds(2),bnds(2)+bnds(4)],figout');
colormap gray
end

function [ figout ] = pxfg( fgsz,fig )
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
if isempty(spc)
    spc=0;
end
cnt=0;
xrows=zeros(msy,size(figout,2));
while(cnt*sx<(1.8*fgsz(2)))
    xrows(1:sy,(1+cnt*msx):(cnt*msx+sx))=fig;
    cnt=cnt+1;
end
cnt=0;
while(cnt*msy<0.9*sz(1))
    xid=cnt*msy+(1:msy);
    yid=spc*mod(cnt,2)+(1:(size(figout,2)-spc));
    figout(xid,yid)=xrows(:,1:(size(figout,2)-spc));
    cnt=cnt+1;
end
bnds=[1,ceil(sz(1)*.9),1,ceil(sz(2)*.9)];
figout=figout(bnds(1):bnds(2),bnds(3):bnds(4));
fgsz=ceil(fgsz);
figout=figout(1:fgsz(1),(spc+2):(fgsz(2)+spc+1));
figout(:,(end-1):end)=0;
figout(:,1:2)=0;
figout(1:2,:)=0;
figout(end-1:end,:)=0;
end

function [ imff ] = letgr(sbl,fnt)
if nargin==1
    tfnt='Arial';
    sfnt=14;
else
    sfnt=fnt{1};
    tfnt=fnt{2};
end
cf=gcf;
SS=get(cf,'Position');
figure(99)
text(1,1,sbl,'FontSize',sfnt,'FontName',tfnt);
axis([0,2,0,2]);
set(gcf,'Position',SS);
F=getframe(gcf);
clf(99)
close(99)
[XX,dum]=frame2im(F);
XX=0.2989*XX(:,:,1) + 0.5870*XX(:,:,2) + 0.1140*XX(:,:,3);
w=size(XX,1)/2;
h=size(XX,2)/2;
scdf=100;
imff=XX(w-scdf:w+scdf,h-scdf/2:(h+scdf+scdf/2));
[idxr,idxc]=find(imff<240);
if (max(idxr)-min(idxr))>5
    outr=min(idxr)+1:max(idxr)-1;
else
    outr=min(idxr):max(idxr);
end
if (max(idxc)-min(idxc))>5
    outc=min(idxc)+1:max(idxc)-1;
else
    outc=min(idxc):max(idxc);
end
imff=imff(outr,outc);
end