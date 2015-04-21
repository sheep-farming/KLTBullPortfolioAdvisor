%                            _ooOoo_
%                           o8888888o
%                           88" . "88
%                           (| -_- |)
%                            O\ = /O
%                        ____/`---'\____
%                      .   ' \\| |// `.
%                       / \\||| : |||// \
%                     / _||||| -:- |||||- \
%                       | | \\\ - / | |
%                     | \_| ''\---/'' | |
%                      \ .-\__ `-` ___/-. /
%                   ___`. .' /--.--\ `. . __
%                ."" '< `.___\_<|>_/___.' >'"".
%               | | : `- \`.;`\ _ /`;.`/ - ` : | |
%                 \ \ `-. \_ __\ /__ _/ .-` / /
%         ======`-.____`-.___\_____/___.-`____.-'======
%                            `=---='
%
%         .............................................
%              Mr. Buddha blesses    I have no bug
%
%
%  Created by Du Pupu on 12/4/15.
%  Copyright (c) 2015 Zou Luoyi. All rights reserved.
%

function [result,tickername]=getStockSet()

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
for(i=1:1033)
    
    if(strcmp(ticker(i).sector,secName(secCount))~=1)
        secCount=secCount+1;
        secName(secCount)=ticker(i).sector;
        secNum(secCount)=0;
    end
        secNum(secCount)=secNum(secCount)+1;
end
clc;

Number=[1:secCount]';
SectorName=secName';
StockCount=secNum';
sector=table(Number,SectorName,StockCount);


fin=0;
SelectedSectorNumber=[];

% Select Sector Number
while (fin==0)
disp(sector);
display(SelectedSectorNumber);
i=input('Enter the sector number(1-41) to select it, or press enter if finished. > ','s')
clc;
if(str2double(i)>=0)
    if(str2double(i)<=41)
        SelectedSectorNumber(length(SelectedSectorNumber)+1)=str2num(i);
    else
        fin=1;
    end
else
    fin=1;
end
    
clc;
end

SelectedSectorNumber=unique(SelectedSectorNumber);

SelectedTickerNo=[];


tickername={''};
%string TickerName;





for(i=1:1033)
    for(j=1:length(SelectedSectorNumber))
        if (strcmp(ticker(i).sector,SectorName(SelectedSectorNumber(j))))
            SelectedTickerNo(length(SelectedTickerNo)+1)=ticker(i).number;
            tickername(length(SelectedTickerNo))=ticker(i).name;
        end
    end
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
    
end

