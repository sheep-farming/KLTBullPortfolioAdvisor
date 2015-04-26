clc;

tickinperiod=0;

SamplePeriod='d';% y m w d
DateLength=30;

[ticker tickername]=getStockSet(highCapPreference);
% Fetch ticker data from Yahoo
for(i=1:length(ticker))
    try
    data=fetch(yahoo,ticker(i),'Adj Close',now-DateLength,now,SamplePeriod);
    Stock(i).name=ticker(i);
    Stock(i).number=(ticker(i));
    Stock(i).price=flipud(data);%Now->Old => Old to Now.
    Stock(i).returns=price2ret(Stock(i).price(:,2),Stock(i).price(:,1))*30.25; %Daily Return Rate. convert to annual ~ returns*365
            %Progress Bar
            fetchProgress=(60*i/(1.0*length(ticker)));
            clc;
            fprintf('\nDownloading data from Yahoo!...\n\n\n  ');
            for(j=1:60)
                if(j<=fetchProgress)
                    fprintf('>');
                else
                    fprintf('-');
                end
            end
    
    if(length(Stock(i).price)>tickinperiod)
        tickinperiod=length(Stock(i).price);
    end
    
    catch
        
    end

end

% exclude the ticker that has stopped trading during the sample period.


    i=1;

    while(i<=length(Stock))
        if(length(Stock(i).price)<tickinperiod)
            Stock(i)=[];
            ticker(i)=[];
            tickername(i)=[];
            i=i-1; %DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
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

