% example_use
%example of plotheatmap

clearvars
close all
clc

%% generating data

dx = 0.1;
xpoints = 0:dx:10;
ypoints = 0.5.*xpoints.^2; %general function to plot
multiplier = 100; 
yrange = 1.*xpoints;

c = 0;
% x_values = NaN.*ones(length(xpoints).*multiplier,1); %preallocating
% y_values = x_values;
for i = 1:length(xpoints)
    for m = 1:multiplier
        c = c + 1;
        x_values(c) = xpoints(i) + dx.*rand(1);
        y_values(c) = ypoints(i) + yrange(i).*(randn(1)-0.5);
    end
end



%% example: plotting a 2D histogram with plotheatmap

%creating bins
xedges = linspace(floor(min(x_values)),ceil(max(x_values)),200);
yedges = linspace(floor(min(y_values)),ceil(max(y_values)),300);

%making figure
figure();
ax = gca;

%creating colormap
cmap = jet(100);

%applying plotheatmap
plotheatmap(ax,x_values,y_values,xedges,yedges,cmap);

%formatting
hold on
plot(xpoints,ypoints,'color','w') %overlaying function line
xlim([0,5])
ylim([-5,20])
yc = colorbar;
ylabel(yc,'Quantity')



