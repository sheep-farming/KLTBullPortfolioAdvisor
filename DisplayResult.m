% DisplayResult
% Set up a dataset object that contains the portfolio that maximizes the Sharpe ratio
Blotter = dataset({tickername(RiskyWts > 0)','Name'},{100*RiskyWts(RiskyWts > 0)','Weight'}, 'obsnames', AssetList(RiskyWts > 0)');
fprintf('== Result =================================================\n\n AAAAAAAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA \n AA          AA         AAAA        AA         AA    AAAA \n AA   AAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA \n AA     AA   AA           AA        AA         AA      AA \n AAAAAAAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA\n\n* P o r t f o l i o   A d v i s o r *\n\n - ');
try
fprintf('Dear %s,\n\n',strcat(genderName,name));
catch
end
fprintf('Given your selected industry, we have designed a Portfolio\n with Maximum Utility for you\n\n');
disp(Blotter);
fprintf('\n - With Annualized Expected\n');
fprintf('\n    Return\t\t%.2f%%',sret*1200);
fprintf('\n    Risk(Std Dev)\t%.2f\n\n',srsk*12);
fprintf('\nPress enter to view the detail');
pause;



%Ersk=OverallRisk;
%Eret=OverallReturn;
