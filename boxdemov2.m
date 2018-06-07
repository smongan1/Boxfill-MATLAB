%DEMO
warning('off','all')
close all
clear all
symbols=['M0}+^*%k7~'];
figure(1)
for ii=1:10
    SS=get(0,'ScreenSize');
    set(gcf,'Position',SS);
    xlims=[ii,ii+1,ii+1,ii];
    ylims=[0,0,ii,ii];
    patch(xlims,ylims,'w');
    axis([0,11,0,11])
    ftn='Arial';
    fts=30;
    hold on
    boxfillv5([ii,0,1,ii],symbols(ii),{fts,ftn})
end
warning('on','all')
hold off