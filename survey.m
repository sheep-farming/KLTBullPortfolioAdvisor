function [ RiskAversion, highCapPreference ] = survey(gender, age)
%SURVEY: Risk Aversion and Market Preference Survey
%   This function outputs user's risk rating and whether the user have
%   preference on asset liquidity.
%   rate: 1 to 10
%   
%Survey Intro
  fprintf('== Risk Survey ============================================\n\n 88   88  88   88888888    8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88888    88      88       8888888  88    88 88     88      \n 88  88   88      88       88    88 88    88 88     88      \n 88   88  88      88       88    88 88    88 88     88      \n 88    88 8888888 88       88888888  888888  888888 888888\n\n* P o r t f o l i o   A d v i s o r *\n\n Please take few minutes to answer the follow questions to \nhelp us optimize your portfolio.\n\n\nPress any key to continue...');
  pause;
  clc;


%Survey Q1
  Q1=input('== Risk Survey #1 =========================================\n\n 1.How many years of experience do you have in investment?\n\n    A. No Experience\n    B. < 3 years\n    C. 3 - 6 years\n    D. 7 - 10 years\n    E. >10 years\n\n\n( A - E )$ ','s');
  clc;
  switch Q1
      case {'a','A'}
          r1=0;
      case {'b','B'}
          r1=2.5;
      case {'c','C'}
          r1=5;
      case {'d','D'}
          r1=7.5;
      case {'e','E'}
          r1=10;
      otherwise
          r1=5;
  end
clc;
%Survey Q2
  Q2=input('== Risk Survey #2 =========================================\n\n 2.How many types of investment products below are you \n holding currently?\n\n    - Cash, deposits, certificate of deposits, capital \n     protected products\n    - Bonds, bond funds\n    - Foreign currencies, non capital protected currency \n     linked structured products\n    - Stocks, open­end funds excluding bond funds & money \n     market funds, non capital protected equity linked \n     structured products, investment­linked insurance plan,\n     commodities\n    - Options, futures, warrants\n\n\n( 1 - 5 )# ','s');
  clc;
  switch Q2
      case {'0'}
          r2=0;
      case {'1'}
          r2=2;
      case {'2'}
          r2=4;
      case {'3'}
          r2=6;
      case {'4'}
          r2=8;
      case {'5'}
          r2=10;
      otherwise
          r2=5;    
  end
clc;
%Survey Q3
  Q3=input('== Risk Survey #3 =========================================\n\n 3.In order to achieve your expected returns, which state- \n  ment best describes the degree of losses you are willing \n  to take?\n\n    A.I am willing to accept minimal amount of capital loss.\n    B.I am willing to accept moderate capital loss.\n    C.I am willing to accept high capital loss. \n\n\n( A - C )$ ','s');
  clc;

  switch Q3
      case {'a','A'}
          r3=0;
      case {'b','B'}
          r3=5;
      case {'c','C'}
          r3=10;
      otherwise
          r3=5;
  end
  clc;
%Survey Q4
  Q4=input('== Risk Survey #4 =========================================\n\n 4.On the whole, which of the following best describes your\n  investment objective?\n\n    A.Capital Preservation\n    B.A Regular Steam Of Stable Income\n    C.A Combination Of Income And Capital Growth\n    D.Achieve Substantial Long Term Capital Growth\n    E.High Capital Appreciation\n\n\n( A - E )$ ','s');
  clc;

  switch Q4
      case {'a','A'}
          r4=0;
      case {'b','B'}
          r4=2.5;
      case {'c','C'}
          r4=5;
      case {'d','D'}
          r4=7.5;
      case {'e','E'}
          r4=10;
      otherwise
          r4=5;
  end
  clc;
  
%Survey Q5
  Q5=input('== Risk Survey #5 =========================================\n\n 5.Which of the following portfolio is most attractive to\n  you?\n\n    A.Portfolio (a) - I am willing to accept a potential \n     loss of 3% in exchange for 9% potential upside.\n    B.Portfolio (b) - I am willing to accept a potential \n     loss of 10% in exchange for 18% potential upside.\n    C.Portfolio (c) - I am willing to accept a potential\n     loss of 15% in exchange for 25% potential upside.\n    D.Portfolio (d) - I am willing to accept a potential\n     loss of 20% in exchange for 31% potential upside.\n    E.Portfolio (e) - I am willing to accept a potential\n     loss of 27% in exchange for 40% potential upside.\n\n\n( A - E )$ ','s');
  

  switch Q5
      case {'a','A'}
          r5=0;
      case {'b','B'}
          r5=2.5;
      case {'c','C'}
          r5=5;
      case {'d','D'}
          r5=7.5;
      case {'e','E'}
          r5=10;
      otherwise
          r5=5;
  end
  
  clc;
%Survey Q6
  Q6=input('== Risk Survey #6 =========================================\n\n 6.Compared to others, how do you rate your willingness to \n  take financial risks?\n\n    A. Extremely low risk taker.\n    B. Low risk taker.\n    C. Average risk taker.\n    D. High risk taker.\n    E. Extremely high risk taker.\n\n\n( A - E )$ ','s');
  
  switch Q6
      case {'a','A'}
          r6=0;
      case {'b','B'}
          r6=2.5;
      case {'c','C'}
          r6=5;
      case {'d','D'}
          r6=7.5;
      case {'e','E'}
          r6=10;
      otherwise
          r6=5;
  end
  clc;

  rate=0.0+(r1+r2+r3+r4+r5)*0.08+r6*0.6;
  clc
  
  
  
  
  
  
% Market Cap Preference

     MCP=input('== Liquidity Preference ===================================\n\n Generally, stocks with high market capitalization have low\n  liquidity risk and low potential return, and vice versa.\n  In order to achieve your investment objectives, which of \n  the following statement best describes your style?\n\n    A.I prefer high potential return and high liquidity\n     risks. \n    B.I prefer low liquidity risk and low potential return. \n    C.I don''t have preference on stock''s market cap.\n\n( A - C )$ ','s');
  

  switch MCP
      case {'a','A'}
          highCapPreference=-1;
      case {'b','B'}
          highCapPreference=1;
      case {'c','C'}
          highCapPreference=0;
      otherwise
          highCapPreference=0;
  end
  
  clc;
  
%highCapPreference

  
  
%Survey Result
  fprintf('== Risk Survey Result =====================================\n\n       YYY   YYY   OOOOOOO   UUU   UUU  RRRRRRR    \n        YYY YYY   OOO   OOO  UUU   UUU  RRR   RRR\n         YYYYY    OOO   OOO  UUU   UUU  RRR   RRR\n          YYY     OOO   OOO  UUU   UUU  RRRRRRRR\n          YYY     OOO   OOO  UUU   UUU  RRR   RRR\n          YYY      OOOOOOO    UUUUUUU   RRR    RRR\n\nRRRRRR    EEEEEEEEE   SSSSSS    UUU   UUU  LLL    TTTTTTTTT\nRR    RR  EEE        SS    SSS  UUU   UUU  LLL       TTT\nRR    RR  EEEEEEEEE   SSSS      UUU   UUU  LLL       TTT\nRRRRRRR   EEE            SSSS   UUU   UUU  LLL       TTT\nRR    RR  EEE        SSS    SS  UUU   UUU  LLL       TTT\nRR     RR EEEEEEEEE    SSSSSS    UUUUUUU   LLLLLLLLL TTT\n\nYour risk tolerance rating is:%.1f\n\n\nPress any key to continue...',rate);
  pause;
  clc;

RiskAversion = 4.0 - rate / 5.0;

%Adjust gender difference
if(gender~=1)
    RiskAversion = 2+sqrt((RiskAversion-2)*2);
end

%Adjust age difference
RiskAversion = RiskAversion + 0.01 * age;
  
end

