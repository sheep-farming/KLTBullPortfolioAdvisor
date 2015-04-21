function checkYahoo
for(i=1:length(ticker))
    data=fetch(yahoo,ticker(i),'Adj Close',now-DateLength,now,SamplePeriod);
    Stock(i).name=ticker(i);
    Stock(i).number=(ticker(i));
    Stock(i).price=flipud(data);%Now->Old => Old to Now.
    Stock(i).returns=price2ret(Stock(i).price(:,2),Stock(i).price(:,1))*30; %Daily Return Rate. convert to annual ~ returns*365
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
    

end