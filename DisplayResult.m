% DisplayResult
% Set up a dataset object that contains the portfolio that maximizes the Sharpe ratio
Blotter = dataset({tickername(RiskyWts > 0)','Name'},{round(100*RiskyWts(RiskyWts > 0),2)','Weight'}, 'obsnames', AssetList(RiskyWts > 0)');
fprintf('== Result =================================================\n\n 88   88  88   88888888    8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88888    88      88       8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88   88  88      88       88    88 88    88 88     88      \n 88    88 8888888 88       88888888  888888  888888 888888\n\n* P o r t f o l i o   A d v i s o r *\n\n - ');
try
fprintf('Dear %s,\n\n',strcat(genderName,name));
catch
end
fprintf(' Given your selected industry, we have designed a Portfolio\n  with Maximum Utility for you\n\n');
fprintf(' <strong>%d%%</strong> of your cash should be in the stock market:\n\n', round(RiskyFraction*100));
disp(Blotter);
fprintf('\n <strong>%d%%</strong> of your cash should be kept in bank\n\n', 100-round(RiskyFraction*100));
fprintf('\n - With Overall Annualized Expected\n');
fprintf('\n    Return\t\t%.2f%%',Eret*1200);
fprintf('\n    Risk(Std Dev)\t%.2f\n\n',Ersk*12);
fprintf('\nPress enter to view the detail');
pause;



%Ersk=OverallRisk;
%Eret=OverallReturn;
