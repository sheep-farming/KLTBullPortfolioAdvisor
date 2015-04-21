
ticker=struct('number',0,'name','','sector','');
[tno,tnm,tsc]  = ImportTickerFromCSV('HKEquity.csv',1, 1033);

for(i=1:1033)
    ticker(i).number=tno(i);ticker(i).name=tnm(i);ticker(i).sector=tsc(i);
end
clc;

% ticker(1:1033).number/name/sector
secCount=1;
secName(1)=ticker(1).sector;
secNum(1)=0;
clc;


SelectedTickerNo=[];

for(i=1:1033)
            SelectedTickerNo(length(SelectedTickerNo)+1)=ticker(i).number;
            tickername(length(SelectedTickerNo))=ticker(i).name;
    
end

SelectedTickerName=cell(length(SelectedTickerNo),1);

% Get Stock Name in Selected Industries.

for(i=1:length(SelectedTickerNo))
    SelectedTickerName(i)={strcat(num2str(SelectedTickerNo(i)),'.HK')};
    for(j=length(SelectedTickerName{i})+1:7)
        SelectedTickerName(i)=strcat('0',SelectedTickerName(i));
    end
    
    
end
    result=SelectedTickerName;
   p=[]; 
tickinperiod=0;
for(i=1:length(SelectedTickerName))
    try
    data=fetch(yahoo,SelectedTickerName(i),'Adj Close',now-5,now,'d');
 
    Stock(i).price=data;%Now->Old => Old to Now.
   
            %Progress Bar
            fetchProgress=(180*i/(1.0*length(ticker)));
            clc;
            fprintf('\nDownloading data from Yahoo!...\n\n\n  ');
            for(j=1:180)
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
        p=[p,SelectedTickerName(i)]
    end
    
end
