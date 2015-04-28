%%init
clear;
clc;

%Variables - Risk Free Rate = 1.4%, as of Mar 31, 2015

RiskFreeRate = .014; 

%Introduction
    intro();
    
age=0;
gender=8;

%Personal Info
    [age,gender,genderName,name]=personal();

%Survey
clc;
[ riskRate, highCapPreference ] = survey();
RiskAversion = 4.0 - riskRate / 5.0;

%Adjust gender difference
if(gender~=1)
    RiskAversion = 2+sqrt((RiskAversion-2)*2);
end

%Adjust age difference
RiskAversion = RiskAversion + 0.01 * age;
    
    % The equation used to represent risk aversion in Financial Toolbox? software is
    % U = E(r) - 0.005*A*sig^2
    % U is the utility value.
    % E(r) is the expected return.
    % A is the index of investor's aversion.
    % sig is the standard deviation.
    % Typically, A=[2.0,4.0]


% Fetch ticker data from Yahoo!    
FetchDataFromYahoo;

OptimizationUtility;

DisplayResult;

DrawFrontierFigure;
DrawPieChart;
% optimization([Stock.MeanReturns], [Covariance], RiskAversion,RiskFreeRate )
DrawTrendLine(1200*Eret,1200*Ersk);
thankYou;
clc;
clear;
