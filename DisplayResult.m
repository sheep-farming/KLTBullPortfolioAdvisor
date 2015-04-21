% DisplayResult
% Set up a dataset object that contains the portfolio that maximizes the Sharpe ratio
Blotter = dataset({tickername(swgt > 0)','Name'},{100*swgt(swgt > 0),'Weight'}, 'obsnames', AssetList(swgt > 0));
fprintf('== Result =================================================\n\n AAAAAAAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA \n AA          AA         AAAA        AA         AA    AAAA \n AA   AAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA \n AA     AA   AA           AA        AA         AA      AA \n AAAAAAAAA   AAAAAAAA     AA    AAAAAA     AAAAAA      AA\n\n* P o r t f o l i o   A d v i s o r *\n\n - ');
fprintf('Portfolio with Maximum Sharpe Ratio\n\n');
disp(Blotter);