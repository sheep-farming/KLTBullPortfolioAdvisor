% Optimization
clc
cret=RiskFreeRate/12; % cash return
crsk=0; % cash risk
AssetList=[Stock.name];
p = Portfolio('AssetList', AssetList, 'RiskFreeRate', cret);
p = setAssetMoments(p, [Stock.MeanReturns], [Covariance]);

p = setInitPort(p, 1/p.NumAssets);
[ersk, eret] = estimatePortMoments(p, p.InitPort);


p = estimateAssetMoments(p,[Stock.returns]);%,[Covariance],length(ticker));
p = setDefaultConstraints(p);
pwgt = estimateFrontier(p, 20);
[prsk, pret] = estimatePortMoments(p, pwgt);

%p = setInitPort(p, 0);

swgt = estimateMaxSharpeRatio(p);
[srsk, sret] = estimatePortMoments(p, swgt);
% Plot efficient frontier with portfolio that attains maximum Sharpe ratio
%sret=er-0.005*A*sig^2

Eret=sret+0.005*RiskAversion*srsk^2;
Ersk=srsk+(Eret-sret)*srsk/(sret);