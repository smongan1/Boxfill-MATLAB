function boxfill( bnds, sbl, fnt )
%bnds=[bottomedge,leftedge,width,height] fnt={fontsize,fontname} sbl=symbol
%used to fill bnds
sbl=sbl(1);
if nargin==2
    tfnt='Arial';
    sfnt=14;
else
    sfnt=fnt{1};
    tfnt=fnt{2};
end

%gets the window size in pixels
wsize=get(gcf,'Position');
wsize=[wsize(3),wsize(4)];


asize=get(gca,'Position');
asize=[asize(3),asize(4)].*wsize;%gets the axis size in pixels

xlims=get(gca,'XLim');
xrng=xlims(2)-xlims(1);%gets range for x

ylims=get(gca,'YLim');
yrng=ylims(2)-ylims(1);%gets range for y

%gets pixel size and position of bar patch
pixbnds=bnds;
pixbnds(1)=(bnds(1)/yrng)*asize(1);
pixbnds(2)=(bnds(2)/xrng)*asize(2);
pixbnds(4)=(bnds(4)/yrng)*asize(2);
pixbnds(3)=(bnds(3)/xrng)*asize(1);

%gets the pixel size of the symbol used to fill
gg=uicontrol('Style', 'text');
set(gg,'FontName',tfnt);set(gg,'FontSize',sfnt);
set(gg,'String',sbl);
set(gg,'Visible','off');
set(gg,'Position',[-10000,-100000,1,1]);
ff=get(gg,'Extent');


pnts=[xrng,yrng].*ff(3:4)./asize;
snum=floor((pixbnds-ff)./ff);
snum=[snum(3),snum(4)];
xpos=(.99*bnds(3)/snum(1))*(1:snum(1))+bnds(1);
ypos=(bnds(4)/snum(2))*(1:snum(2))+bnds(2);
for ii=1:snum(1);
    for jj=1:snum(2);
        %text(bnds(1)+pnts(1)*(ii-0.75),bnds(2)+pnts(2)*(jj-0.75),sbl,'FontSize',sfnt,'FontName',tfnt)
        %if mod(ii+jj,2)==1
        text(xpos(ii)-pnts(1)*.75,ypos(jj)-pnts(2)*.75,sbl,'FontSize',sfnt,'FontName',tfnt)
        %end
    end
end
end

