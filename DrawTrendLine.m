function DrawTrendLine( expret,stddev )
%DrawTrendLine Summary of this function goes here
%   Detailed explanation goes here

hiret=expret+stddev;
loret=expret-stddev;

now=years(0);
endpoint=years(1);

plot([now,endpoint],[0,hiret],'g->',[now,endpoint],[0,expret],'b->',[now,endpoint],[0,loret],'r->','LineWidth',2,'MarkerSize',5)
hold on

title('Possibility Distribution');

labels = {'84.1% Possible Lower','Expected Return','84.1% Possible Higher'};
legend(labels,'Location','north','Orientation','vertical','FontSize',12);
ylabel('% Expected Annualized Rate');
pause
close
end

