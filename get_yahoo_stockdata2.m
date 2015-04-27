function stock = get_yahoo_stockdata2(ticker,d1,d2,freq,quiet)
% This function is used to retrieve historical stock data from Yahoo Finance.
% I was using the the 'hist_stock_data.m' by Josiah Renfree (January 25, 2008)
% from the Matlab File Exchange and it worked great but I noticed that it
% stopped working for the Dow Jones Industrial Average Index (^DJI). It turns
% out that due to some stupid licensing BS, Yahoo was not permitted to
% give that data out in the .csv form that 'hist_stock_data.m' relied on.
% As I still wanted access to ^DJI, I hacked together this function to read the
% data not from .csv but by parsing the html from displayed tables. Yahoo was
% still showing the data in this format.
%
% This function will work with any valid Yahoo listed stock symbol, but will be
% slower than 'hist_stock_data.m' because it has to do more work to extract the
% data, including potentially reading dozens of pages to get it all. It goes to
% the first page, extracts the table data and reads the link for the next page
% of data and continues on till it gets it all.
%
% Special thanks to Josiah Renfree for 'hist_stock_data.m' some of which this
% function is based on.
%
% Captain Awesome, July 2012
%
% INPUTS:
%
% ticker  <-- char string. Yahoo ticker symbol for desired security.
%
% d1      <-- start date for data. Can be a matlab datenumber or a date string.
%             Default = one year ago from today
%
% d2      <-- end date for data. Can be a matlab datenumber or a date string.
%             Default = today
%
% freq    <-- data frequency 'd' (daily), 'w' (weekly), or 'm' (monthly).
%             Default = 'd'
%
% quiet   <-- true or false. If true, then progress messages are disabled.
%             Default = false
%
% OUTPUT:
%
% stock  <-- matlab data structure with output data.
%
% e.g. stock =
%         Ticker: 'AAPL'
%           Name: 'Apple Inc.'
%     DataSource: 'Yahoo Finance'
%     DataUpdate: '14-Jul-2012 19:00:09'   <-- Last updated
%      DataError: ''                       <-- if errors, message will appear
%           Freq: 'd'
%           Date: {41x1 cell}              <-- dates in '01-JAN-2011' format
%           DNum: [41x1 double]
%           Open: [41x1 double]
%           High: [41x1 double]
%            Low: [41x1 double]
%          Close: [41x1 double]
%        AdjOpen: [41x1 double]
%        AdjHigh: [41x1 double]
%         AdjLow: [41x1 double]
%       AdjClose: [41x1 double]
%         Volume: [41x1 double]
%
% Examples:
%
%  Get data for the past year.
%  stock = get_yahoo_stockdata2('goog');
%
%  Get data from 01-Mar-2008 to now.
%  stock = get_yahoo_stockdata2('goog','01-Mar-2008');
%
%  Get data for the past 5 years.
%  stock = get_yahoo_stockdata2('goog',floor(now)-5*365,floor(now));
%
%  Get data for specific date range, but weekly instead of daily
%  stock = get_yahoo_stockdata2('goog','01-Jan-2009','01-Apr-2010','w');
%
%  Get the last week's data but disable messages
%  stock = get_yahoo_stockdata2('goog',floor(now)-7,floor(now),'d',true);
%
%

% Set Defaults
if nargin==1;
  d2=floor(now);
  d1=d2-365;
  freq='d';
  quiet=false;
elseif nargin==2
  d2=floor(now);
  freq='d';
  quiet=false;
elseif nargin==3
  freq='d';
  quiet=false;
elseif nargin==4
  quiet=false;
end

ticker=upper(ticker);
freq=lower(freq);

if ischar(d1)
  d1=datenum(d1);
end
if ischar(d2)
  d2=datenum(d2);
end

if freq~='d' && freq~='w' && freq~='m'
  error(['freq must be ''d'',''w'', or ''m''. Input was freq = ',freq]);
end

stock.Ticker = ticker;
stock.Name = '';
stock.DataSource = 'Yahoo Finance';
stock.DataUpdate = datestr(now,0);
stock.DataError = '';
stock.Freq = freq;

if isempty(ticker)
  stock.DataError=['stock data download failed: ',ticker];
  return
end

startvec=datevec(d1);
start_date=[sprintf('%02d',startvec(3)),sprintf('%02d',startvec(2)),...
  sprintf('%02d',startvec(1))];

endvec=datevec(d2);
end_date=[sprintf('%02d',endvec(3)),sprintf('%02d',endvec(2)),...
  sprintf('%02d',endvec(1))];

% split up beginning date into day, month, and year.  the month is
% subracted is subtracted by 1 since that is the format that yahoo! uses
bd = start_date(1:2);       % beginning day
bm = sprintf('%02d',str2double(start_date(3:4))-1); % beginning month
by = start_date(5:8);       % beginning year

% split up ending date into day, month, and year.  the month is subracted
% by 1 since that is the format that yahoo! uses
ed = end_date(1:2);         % ending day
em = sprintf('%02d',str2double(end_date(3:4))-1);   % ending month
ey = end_date(5:8);         % ending year

if sum(isnan(str2double([bd bm by ed em ey])))
  error('input dates causing errors')
end

% Website address for first page of stock data
site=strcat('http://finance.yahoo.com/q/hp?s=',...
  ticker,'&a=',bm,'&b=',bd,'&c=',by,'&d=',em,'&e=',ed,'&f=',...
  ey,'&g=',freq);

% After the first page is read, this variable will hold the address to the next
% page of data.
nexturl='first';

pagecnt=0;  % Page counter for display purpose.

if ~quiet
  disp(['Downloaded ',ticker,' stock date for ',datestr(d1),' to ',datestr(d2)]);
end

% Loop until there is no more nexturl to parse.
while(1)
  
  if ~strcmpi(nexturl,'first')
    site=nexturl;
  end
  
  pagecnt=pagecnt+1;
  
  if ~quiet
    disp(['Downloading data from page ',int2str(pagecnt)]);
    disp(site);
  end
  
  [temp, status] = urlread(site);
  
  if ~status
    warning(['stock data download failed: ',ticker]);
    stock.DataError=['stock data download failed (',datestr(now,0),'): ',ticker];
    return
  end
  
  % The page's html data is given as one big long string. This turns
  % it into a cellstr array, one cell for each line.
  c=textscan(temp,'%s','delimiter',sprintf('\n'));
  c=c{1};
  
  % The cellstr array is then parsed in a seperate function (given below).
  [newstock,nexturl]=parse_yahoo_html(c,quiet);
  
  % Check for errors
  stock.DataError=newstock.DataError;
  if ~isempty(stock.DataError)
    warning(stock.DataError);
    return
  end
  
  if ~quiet
    disp(['Page contained data from ',char(newstock.Date(1)),' to ',char(newstock.Date(end))]);
  end
  
  % Assign data to stock structure
  if ~isfield(stock,'DNum')
    % This part is for the first page of data
    if ~strcmpi(ticker,newstock.Ticker)
      error('ticker mismatch');
    end
    stock.Name=newstock.Name;
    stock.Date=newstock.Date;
    stock.DNum=newstock.DNum;
    stock.Open=newstock.Open;
    stock.High=newstock.High;
    stock.Low=newstock.Low;
    stock.Close=newstock.Close;
    stock.AdjOpen=[];
    stock.AdjHigh=[];
    stock.AdjLow=[];
    stock.AdjClose=newstock.AdjClose;
    stock.Volume=newstock.Volume;
  else
    % This part is for all subsequent pages.
    if ~strcmpi(stock.Name,newstock.Name)
      error('name mismatch');
    end
    stock.Date=[stock.Date; newstock.Date];
    stock.DNum=[stock.DNum; newstock.DNum];
    stock.Open=[stock.Open; newstock.Open];
    stock.High=[stock.High; newstock.High];
    stock.Low=[stock.Low; newstock.Low];
    stock.Close=[stock.Close; newstock.Close];
    stock.Volume=[stock.Volume; newstock.Volume];
    stock.AdjClose=[stock.AdjClose; newstock.AdjClose];
  end
  
  % If no more pages to read, nexturl is returned empty.
  if isempty(nexturl)
    break
  end
  
end

% Data is given in reverse chronological, this part puts it in proper
% chronological order. Oldest to newest.
if stock.DNum(1)>stock.DNum(end)
  stock.Date=flipud(stock.Date);
  stock.DNum=flipud(stock.DNum);
  stock.Open=flipud(stock.Open);
  stock.High=flipud(stock.High);
  stock.Low=flipud(stock.Low);
  stock.Close=flipud(stock.Close);
  stock.Volume=flipud(stock.Volume);
  stock.AdjClose=flipud(stock.AdjClose);
end

% Adjusted Close provides the closing price for the requested day, week, or
% month, adjusted for all applicable splits and dividend distributions. Data is
% adjusted using appropriate split and dividend multipliers, adhering to Center
% for Research in Security Prices (CRSP) standards. Split multipliers are
% determined by the split ratio. For instance, in a 2 for 1 split, the
% pre-split data is multiplied by 0.5. Dividend multipliers are calculated
% based on dividend as a percentage of price, primarily to avoid negative
% historical pricing. For example, when a $0.08 cash dividend is distributed
% on Feb 19 (ex-date), and the Feb 18 closing price was 24.96, the pre-dividend
% data is multiplied by (1-0.08/24.96) = 0.9968. Below is a detailed example of
% adjusted close calculations.
%
% Example: Adjusted Close Calculations
%
%     2/13/03 Close = 46.99
%     2/14/03 Close = 48.30
%     2/18/03 Split = 2:1
%     2/18/03 Close = 24.96
%     2/19/03 Cash Dividend = 0.08 (ex-date)
%     2/19/03 Close = 24.53
%
%     Split Multiplier = 0.5
%     Dividend Multiplier = 1 € (0.08/24.96) = 0.9968
%
%     2/13/03 Adj. Close = 0.5 * 0.9968 * 46.99 = 23.42
%     2/14/03 Adj. Close = 0.5 * 0.9968 * 48.30 = 24.07
%     2/18/03 Adj. Close = 0.9968 * 24.96 = 24.88
%     2/19/03 Adj. Close = 24.53

% This part uses adjusted close to also get adjusted open,low,and high prices.
adjuster=(stock.AdjClose)./stock.Close;
stock.AdjOpen=stock.Open.*adjuster;
stock.AdjHigh=stock.High.*adjuster;
stock.AdjLow=stock.Low.*adjuster;

if ~quiet
  disp('Download complete.');
end

% This function checks for data issues.
stock=clean_stockData(stock,quiet);

if ~quiet
  disp(['Download Complete for ',ticker]);
  disp(['Data Range: ',char(stock.Date(1)),' to ',char(stock.Date(end))]);
end

return


%% Parse function ==============================================================
function [stock,nexturl]=parse_yahoo_html(c,quiet)

clear stock
nexturl='';
stock.DataError='';

% Look for title line ----------------------------------------------------------
%<html><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"><title>^DJI Historical Prices | Dow Jones Industrial Average Stock - Yahoo! Finance</title><link rel="stylesheet" type="text/css" href="http://l.yimg.com/a/i/us/fi/yfs/css/yf_streaming_1.4.css"><script type="text/javascript" src="http://us.js2.yimg.com/us.js.yimg.com/i/us/fi/scripts/gnavb_200702051500.js"></script><script type="text/javascript" src="http://l.yimg.com/a/i/us/fi/03rd/yg_csstare_nobgcolor.js"></script><link rel="stylesheet" href="http://l.yimg.com/bm/lib/fi/common/p/d/static/css/2.0.207868/2.0.0/mini/yfi_yfnc_legacy.css" type="text/css"><link rel="stylesheet" href="http://l.yimg.com/zz/combo?kx/ucs/uh/css/287/yunivhead-min.css&amp;kx/ucs/uh/css/221/logo-min.css&amp;kx/ucs/notif_v2/css/145/notifications_v2-min.css&amp;kx/ucs/mailcount/css/37/mail_preview-min.css&amp;kx/ucs/search/css/190/search_all-min.css&amp;kx/ucs/search/css/190/search_buttons-min.css&amp;bm/lib/fi/common/p/d/static/css/2.0.207868/2.0.0/mini/yfi_yoda_legacy_lego_concat.css" type="text/css"><style>

% Won't use arrayfun here as it should be in the top couple of lines.
chk=false;
for i=1:10
  str=char(c(i));
  g=strfind(str,'Historical Prices');
  if isempty(g),continue; end
  chk=true;
  break;
end

if ~chk
  disp('Key title string in html not found.');
  warning('stock data download failed');
  stock.DataError=['stock data download failed (',datestr(now,0),')'];
  return
end
clear g chk

% Parse this string
k=strfind(str,'<title>');
str=str(k+7:end);
k=strfind(str,'</title>');
str=str(1:k-1);
k=strfind(str,'|');
ticker=str(1:k-1);
ticker=strtrim(regexprep(ticker,'Historical Prices',''));
name=str(k+1:end);
name=regexprep(name,'- Yahoo! Finance','');
name=strtrim(regexprep(name,' Stock',''));
clear str k
stock.Ticker=ticker;
stock.Name=name;


% Now try and parse table data-------------------------------------------------
% Data table exists in a single html code line. This part looks for a key string
% to locate that line in the cellstr array.
IndexC = strfind(c, 'yfnc_tabledata1');
id = find(not(cellfun('isempty', IndexC)));
clear IndexC;

if isempty(id) || length(id)>1
  disp('Key table string in html not found.');
  warning('stock data download failed');
  stock.DataError=['stock data download failed (',datestr(now,0),')'];
  return
end

% All of the data in the data exists in a single long line. Each block of
% information is between < and >. This part seperates out each block.
str=char(c(id));
f=textscan(str,'%s','delimiter','<>');
f=f{1};

% The desired data appears before a block with a '/td' in it.
% This part locates these.
k=find(strcmpi(f,'/td')==1);
h=f(k-1);

% Now h should be a cellstr with the following repeating pattern:
%     'Apr 16, 2012'   <-- Date
%     '12,850.88'      <-- Open
%     '12,986.77'      <-- High
%     '12,850.80'      <-- Low
%     '12,921.41'      <-- Close
%     '1,209,900'      <-- Volume
%     '12,921.41'      <-- AdjClose

% So the length of each should be evenly divisable by 7 or there is a problem.
n = length(h);
if rem(n,7)
  disp('Table Parsing resulting in wrong element count,');
  warning('stock data download failed');
  stock.DataError=['stock data download failed (',datestr(now,0),')'];
  return
end

% Assign data to stock structure
stock.DNum=datenum(h(1:7:n));
stock.Date=cellstr(datestr(stock.DNum));
stock.Open=str2double(h(2:7:n));
stock.High=str2double(h(3:7:n));
stock.Low=str2double(h(4:7:n));
stock.Close=str2double(h(5:7:n));
stock.Volume=str2double(h(6:7:n));
stock.AdjClose=str2double(h(7:7:n));

% When I was testing this function I noticed that on the first page of results,
% the top two dates were the same.
%
% Date	Open	High	Low	Close	Volume	Adj Close*
% Jul 13, 2012	12,587.73	12,784.43	12,587.73	12,775.80	99,893,600	12,777.09
% Jul 13, 2012	12,573.73	12,784.73	12,573.04	12,777.09	1,210,800	12,777.09
% Jul 12, 2012	12,602.71	12,630.64	12,492.25	12,573.27	1,427,600	12,573.27
%
% This appeared for all quote.s Wasn't sure if it was because of the weekend, a
% one-time error or something consistent. It only happened on the first page of
% result when the last search day was today. So this next part will look for
% that and if its there, discard the top row of data.
if length(stock.DNum)>1
  if stock.DNum(1)==stock.DNum(2)
    if ~quiet
      warning(['Stock data found for duplicate days (',char(stock.Date(1)),...
        '). Removing first instance.']);
    end
    stock.DNum=stock.DNum(2:end);
    stock.Date=stock.Date(2:end);
    stock.Open=stock.Open(2:end);
    stock.High=stock.High(2:end);
    stock.Low=stock.Low(2:end);
    stock.Close=stock.Close(2:end);
    stock.Volume=stock.Volume(2:end);
    stock.AdjClose=stock.AdjClose(2:end);
  end
end

% Check vector lengths (should all be the same).
n=length(stock.DNum);
if length(stock.Date)~=n || length(stock.Open)~=n || length(stock.High)~=n ...
    || length(stock.Low)~=n || length(stock.Close)~=n || length(stock.Volume)~=n ...
    || length(stock.AdjClose)~=n
  error('Stock data problem.');
end

% Get URL for next page of data -----------------------------------------------
% In the web page at the bottom of the table is a link to the next page. This
% part finds it and extracts the address. If it can't find it, then there are no
% more pages of data and nexturl is returned empty.

%<a rel="next" href="/q/hp?s=%5EDJI&amp;a=00&amp;b=2&amp;c=1800&amp;d=06&amp;e=14&amp;f=2012&amp;g=d&amp;z=66&amp;y=66">Next</a> |
c=c(id+1:end);
IndexC = strfind(c, 'rel="next"');
id = find(not(cellfun('isempty', IndexC)));
clear IndexC;

if isempty(id)
  return
end

str=char(c(id));
str=regexprep(str,'<a rel="next" href=','');
k=strfind(str,'"');
str=str(2:k(end)-1);
str=regexprep(str,'amp;','');
str=regexprep(str,'\%5E','^');

nexturl=['http://finance.yahoo.com',str];

return

%% Clean Function ==============================================================
function outstock=clean_stockData(instock,quiet)
% Function to clean up know errors in some stock data. For instance in the
% S&P TSX index there are often dropout of zeros in some of the prices. This
% function will remove those data points

if ~quiet
  disp(['Checking ',instock.Ticker,' for bad data.']);
end

outstock=instock;

allf={'Date','DNum','Open','High','Low','Close',...
  'AdjOpen','AdjHigh','AdjLow','AdjClose','Volume'};

chkf={'DNum','Open','High','Low','Close',...
  'AdjOpen','AdjHigh','AdjLow','AdjClose'};

n1=length(instock.DNum);

for i=1:length(chkf)
  eval(['p=outstock.',char(chkf(i)),';']);
  id=find(p~=0);
  for j=1:length(allf)
    eval(['outstock.',char(allf(j)),'=outstock.',char(allf(j)),'(id);']);
  end
  clear id p
end

for i=1:length(chkf)
  eval(['p=outstock.',char(chkf(i)),';']);
  id=~isnan(p);
  for j=1:length(allf)
    eval(['outstock.',char(allf(j)),'=outstock.',char(allf(j)),'(id);']);
  end
  clear id p
end

dt=diff(outstock.DNum);
idt=find(dt<=0);
if ~isempty(idt)
  error('Duplicate or wrong order dates found.');
end

n2=length(outstock.DNum);

if ~quiet
  if n2==n1
    disp('No bad data was found.');
  else
    disp([n2s(n2-n1),' bad data points were removed.']);
  end
end

return








