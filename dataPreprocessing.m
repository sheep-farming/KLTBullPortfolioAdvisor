    i=1;

    while(i<=length(Stock))
        if(length(Stock(i).price)<tickinperiod)
            Stock(i)=[];
            ticker(i)=[];
            tickername(i)=[];
            i=i-1; 
        end
        i=i+1;
    end

for(i=1:length(ticker))
    Stock(i).MeanReturns=mean(Stock(i).returns);
    Stock(i).Variance=var(Stock(i).returns);
    Stock(i).StdDev=std(Stock(i).returns);

end
    Covariance=cov([Stock.returns]);
    Correlation=corrcoef([Stock.returns]);
clc;
