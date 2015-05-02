%%initialize
	clear;
	clc;

%Variables - Risk Free Rate = 1.4%, as of Mar 31, 2015

    RiskFreeRate = .014; 

%Introduction
    intro();

% Personal Info
    [age,gender,genderName,name]=getPersonalInformation();
    clc;

% Survey
	[ RiskAversion, highCapPreference ] = survey(gender,age);

% Fetch ticker data from Yahoo!    
	FetchDataFromYahoo;

% Data Pre-Process
	dataPreprocessing;

% Optimization
	OptimizationUtility;

% Display Results
	DisplayResult;

% Visualization
	DrawFrontierFigure;
	DrawPieChart;
	DrawTrendLine(1200*Eret,1200*Ersk);

% Final Stage
	thankYou;
	clc;
	clear;
