function [xctrs,yctrs,countdata] = plotheatmap(ax,xdata,ydata,xedges,yedges,cmap)
%C.R. Densmore 10OCT2021
% plotheatmap bins and plots data as a 2D histogram (on a 2D graph, where
% color corresponds to the number of points in each 2D bin). Outliers
% (points whose bins have few enough elements to not appear on the plot,
% dependent on the color map and range) are scattered over the color
% contours.
% plotheatmap(ax,xdata,ydata,xedges,yedges,cmap)
% ax: axes to plot into (e.g. ax = gca)
% xdata,ydata: data whose quantity is being plotted
% xedges,yedges: edges for the bins used in the 2D histogram
% cmap: colormap to use (e.g. cmap = jet(100);)

%sanitizing user input
xdata = xdata(:);
ydata = ydata(:);
xedges = sort(xedges(:));
yedges = sort(yedges(:));

isheld = ishold(ax);
hold(ax,'on');

%setting up quantity map
xctrs = xedges(1:end-1) + (xedges(2:end) - xedges(1:end-1))./2;
yctrs = yedges(1:end-1) + (yedges(2:end) - yedges(1:end-1))./2;
nX = length(xctrs);
nY = length(yctrs);
countdata = zeros(nX,nY);

for i = 1:nX
    for j = 1:nY
        isinbin = xdata >= xedges(i) & xdata < xedges(i+1) ...
            & ydata >= yedges(j) & ydata <= yedges(j+1);
        countdata(i,j) = sum(isinbin);
    end
end

pcolor(ax,xctrs,yctrs,countdata')
shading(ax,'interp')
colormap(ax,cmap)

critval = ceil(ax.CLim(2)/size(cmap,1));
[r,c] = find(countdata <= critval & countdata > 0);
isinbin = [];
for i = 1:length(r)
    isinbin = [isinbin; find(xdata >= xedges(r(i)) & xdata < xedges(r(i)+1) ...
            & ydata >= yedges(c(i)) & ydata <= yedges(c(i)+1))];      
end
scatter(ax,xdata(isinbin),ydata(isinbin),5,'k','filled')

if ~isheld
    hold(ax,'off')
end