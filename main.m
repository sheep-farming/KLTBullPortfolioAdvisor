%%init
clear;
clc;

%Variables - Risk Free Rate = 1.4%, as of Mar 31, 2015

RiskFreeRate = .014; 

%Introduction
    intro();

%Personal Info
    [age,gender]=personal();

%Survey
clc;
[riskRate,highCapPreference] =survey();
RiskAversion=2.0+riskRate/5.0;
    
    % The equation used to represent risk aversion in Financial Toolbox? software is
    % U = E(r) - 0.005*A*sig^2
    % U is the utility value.
    % E(r) is the expected return.
    % A is the index of investor's aversion.
    % sig is the standard deviation.
    % Typically, A=[2.0,4.0]


% Fetch ticker data from Yahoo!    
FetchDataFromYahoo;

Optimization;

DisplayResult;

DrawFrontierFigure;
hold off
DrawPieChart
% optimization([Stock.MeanReturns], [Covariance], RiskAversion,RiskFreeRate )
DrawTrendLine(1200*sret,1200*srsk);
thankYou;
