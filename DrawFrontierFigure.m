%DrawFigure
clf;
plot([crsk,srsk]*1200,[cret,sret]*1200,'g',prsk*1200,pret*1200,'b',srsk*1200,sret*1200,'xr',Ersk*1200,Eret*1200,'+k','LineWidth',2,'MarkerSize',10);
xlabel('% Standard Deviation of Returns (Annualized)');
ylabel('% Mean of Returns (Annualized)');
grid on
print -dpng CapitalAllocation

pause
close