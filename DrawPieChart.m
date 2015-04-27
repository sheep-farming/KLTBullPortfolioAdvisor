tNumber=AssetList(RiskyWts > 0)';
tName=tickername(RiskyWts > 0)';
weights=100*RiskyWts(RiskyWts > 0);


x=[weights];
figure;
h = pie3(x,1+zeros(1,length(x)),tNumber);
labels = tName;
legend(labels,'Location','eastoutside','Orientation','vertical')

pause;
close