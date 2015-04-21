%%init
clear;
clc;
RiskFreeRate = .014; %1.4, as of Mar 31, 2015

%Introduction
    intro();

%Personal Info
    personal();

%Survey
rate=0.0;
clc;
rate=survey();
RiskAversion=2.0+rate/5.0;
    
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

DrawFigure;

DisplayResult;

% optimization([Stock.MeanReturns], [Covariance], RiskAversion,RiskFreeRate )


pause;