tNumber=AssetList(swgt > 0)';
tName=tickername(swgt > 0)';
weights=100*swgt(swgt > 0);


x=[weights];
figure;
h = pie3(x,1+zeros(1,length(x)),tNumber);
labels = tName;
legend(labels,'Location','eastoutside','Orientation','vertical')

pause;