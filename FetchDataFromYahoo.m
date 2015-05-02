clc;

tickinperiod=0;

SamplePeriod='d';% y m w d
DateLength=90;

[ticker tickername]=getStockSet(highCapPreference);
% Fetch ticker data from Yahoo
for(i=1:length(ticker))
    try
        try
            data=fetch(yahoo,ticker(i),'Adj Close',now-DateLength,now,SamplePeriod);
            Stock(i).name=ticker(i);
            Stock(i).number=(ticker(i));
            Stock(i).price=flipud(data);%Now->Old => Old to Now.
            Stock(i).returns=price2ret(Stock(i).price(:,2),Stock(i).price(:,1))*22; %Daily Return Rate. convert to annual ~ returns*365
        catch %IF DON'T HAVE DATA FETCH TOOLBOX
            data=get_yahoo_stockdata2(ticker{i},now-DateLength,now,SamplePeriod,1);
            data=[datenum(data.Date) data.AdjClose];
            Stock(i).name=ticker(i);
            Stock(i).number=(ticker(i));
            Stock(i).price=data;
            Stock(i).returns=price2ret(Stock(i).price(:,2),Stock(i).price(:,1))*22; %Daily Return Rate. convert to annual ~ returns*365
      end
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


