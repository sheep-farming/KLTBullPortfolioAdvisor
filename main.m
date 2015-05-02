%%initialize
clear;
clc;

%Variables - Risk Free Rate = 1.4%, as of Mar 31, 2015

    RiskFreeRate = .014; 

%Introduction
    intro();
    


%Personal Info
    [age,gender,genderName,name]=getPersonalInformation();

%Survey
clc;
[ RiskAversion, highCapPreference ] = survey(gender,age);

% Fetch ticker data from Yahoo!    
FetchDataFromYahoo;
dataPreprocessing;
OptimizationUtility;

DisplayResult;

DrawFrontierFigure;
DrawPieChart;
% optimization([Stock.MeanReturns], [Covariance], RiskAversion,RiskFreeRate )
DrawTrendLine(1200*Eret,1200*Ersk);
thankYou;
clc;
clear;
