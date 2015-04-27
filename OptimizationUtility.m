% Optimization Function

cret=(RiskFreeRate+1)^(1/12)-1; %Cash return
crsk=0; % cash risk=risk free
AssetList=[Stock.name];
p = Portfolio('AssetList', AssetList, 'RiskFreeRate', cret);
p = setAssetMoments(p, [Stock.MeanReturns], [Covariance]);

ExpReturn = [Stock.MeanReturns]; 

ExpCovariance  = [Covariance];
               
NumPorts = 20;

[PortRisk, PortReturn, PortWts] = portopt(ExpReturn,... 
ExpCovariance, NumPorts);

RisklessRate  =  0.01;
BorrowRate    =  0.08;

%portalloc (PortRisk, PortReturn, PortWts, RisklessRate, BorrowRate, RiskAversion);

[RiskyRisk, RiskyReturn, RiskyWts, RiskyFraction, OverallRisk, OverallReturn] = portalloc (PortRisk, PortReturn, PortWts,RisklessRate, BorrowRate, RiskAversion);

srsk=RiskyRisk;
sret=RiskyReturn;
prsk=PortRisk;
pret=PortReturn;
Ersk=OverallRisk;
Eret=OverallReturn;

