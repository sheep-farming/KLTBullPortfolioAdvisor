% DisplayResult
% Set up a dataset object that contains the portfolio that maximizes the Sharpe ratio
Blotter = dataset({tickername(RiskyWts > 0)','Name'},{round(100*RiskyWts(RiskyWts > 0),2)','Weight'}, 'obsnames', AssetList(RiskyWts > 0)');
fprintf('== Result =================================================\n\n 88   88  88   88888888    8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88888    88      88       8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88   88  88      88       88    88 88    88 88     88      \n 88    88 8888888 88       88888888  888888  888888 888888\n\n* P o r t f o l i o   A d v i s o r *\n\n - ');
try
fprintf('Dear %s,\n\n',strcat(genderName,name));
catch
end
fprintf(' Given your selected industries, Kowloon Tong Bull has designed\n a Portfolio with Maximum Utility for you:\n\n');
fprintf(' We suggest that <strong>%d%%</strong> of your wealth should be invested in the\n Hong Kong stock market:\n\n', round(RiskyFraction*100));
disp(Blotter);
fprintf('\n while <strong>%d%%</strong> should be kept in the risk-less investments\n(bank deposits or government bonds).\n\n', 100-round(RiskyFraction*100));
fprintf('\n Under our suggestion, the performance of your OVERALL\n is as followed:(in annualized term)\n');
fprintf('\n    RETURN\t\t%.2f%%',Eret*1200);
fprintf('\n    RISK(Std Dev)\t%.2f\n\n',Ersk*12);
fprintf('\nPress enter to view detailed portfolio analysis');
pause;



%Ersk=OverallRisk;
%Eret=OverallReturn;
