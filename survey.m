function [ RiskAversion, highCapPreference ] = survey(gender, age)
%SURVEY: Risk Aversion and Market Preference Survey
%   This function outputs user's risk rating and whether the user have
%   preference on asset liquidity.
%   rate: 1 to 10
%   
%Survey Intro
  fprintf('== Risk Survey ============================================\n');
  fprintf('\n');
  fprintf(' 88   88  88   88888888    8888888  88    88 88     88      \n');
  fprintf(' 88  88   88      88       88    88 88    88 88     88      \n');
  fprintf(' 88888    88      88       8888888  88    88 88     88      \n');
  fprintf(' 88  88   88      88       88    88 88    88 88     88      \n');
  fprintf(' 88   88  88      88       88    88 88    88 88     88      \n');
  fprintf(' 88    88 8888888 88       88888888  888888  888888 888888\n');
  fprintf('\n');
  fprintf('* P o r t f o l i o   A d v i s o r *\n');
  fprintf('\n');
  fprintf(' Please take few minutes to answer the follow questions to \n');
  fprintf('help us optimize your portfolio.\n');
  fprintf('\n');
  fprintf('\n');
  fprintf('Press any key to continue...');
  pause;
  clc;


%Survey Q1
  fprintf('== Risk Survey #1 =========================================\n');
  fprintf('\n');
  fprintf(' 1.How many years of experience do you have in investment?\n');
  fprintf('\n');
  fprintf('    A. No Experience\n');
  fprintf('    B. < 3 years\n');
  fprintf('    C. 3 - 6 years\n');
  fprintf('    D. 7 - 10 years\n');
  fprintf('    E. >10 years\n');
  fprintf('\n');
  fprintf('\n');
  Q1=input('( A - E )$ ','s');
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
  fprintf('== Risk Survey #2 =========================================\n');
  fprintf('\n');
  fprintf(' 2.How many types of investment products below are you \n');
  fprintf(' holding currently?\n');
  fprintf('\n');
  fprintf('    - Cash, deposits, certificate of deposits, capital \n');
  fprintf('     protected products\n');
  fprintf('    - Bonds, bond funds\n');
  fprintf('    - Foreign currencies, non capital protected currency \n');
  fprintf('     linked structured products\n');
  fprintf('    - Stocks, open­end funds excluding bond funds & money \n');
  fprintf('     market funds, non capital protected equity linked \n');
  fprintf('     structured products, investment­linked insurance plan,\n');
  fprintf('     commodities\n');
  fprintf('    - Options, futures, warrants\n');
  fprintf('\n');
  fprintf('\n');
  Q2=input('( 1 - 5 )# ','s');
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
  fprintf('== Risk Survey #3 =========================================\n');
  fprintf('\n');
  fprintf(' 3.In order to achieve your expected returns, which state- \n');
  fprintf('  ment best describes the degree of losses you are willing \n');
  fprintf('  to take?\n');
  fprintf('\n');
  fprintf('    A.I am willing to accept minimal amount of capital loss.\n');
  fprintf('    B.I am willing to accept moderate capital loss.\n');
  fprintf('    C.I am willing to accept high capital loss. \n');
  fprintf('\n');
  fprintf('\n');
  Q3=input('( A - C )$ ','s');
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
  fprintf('== Risk Survey #4 =========================================\n');
  fprintf('\n');
  fprintf(' 4.On the whole, which of the following best describes your\n');
  fprintf('  investment objective?\n');
  fprintf('\n');
  fprintf('    A.Capital Preservation\n');
  fprintf('    B.A Regular Steam Of Stable Income\n');
  fprintf('    C.A Combination Of Income And Capital Growth\n');
  fprintf('    D.Achieve Substantial Long Term Capital Growth\n');
  fprintf('    E.High Capital Appreciation\n');
  fprintf('\n');
  fprintf('\n');
  Q4=input('( A - E )$ ','s');
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
  fprintf('== Risk Survey #5 =========================================\n');
  fprintf('\n');
  fprintf(' 5.Which of the following portfolio is most attractive to\n');
  fprintf('  you?\n');
  fprintf('\n');
  fprintf('    A.Portfolio (a) - I am willing to accept a potential \n');
  fprintf('     loss of 3%% in exchange for 9%% potential upside.\n');
  fprintf('    B.Portfolio (b) - I am willing to accept a potential \n');
  fprintf('     loss of 10%% in exchange for 18%% potential upside.\n');
  fprintf('    C.Portfolio (c) - I am willing to accept a potential\n');
  fprintf('     loss of 15%% in exchange for 25%% potential upside.\n');
  fprintf('    D.Portfolio (d) - I am willing to accept a potential\n');
  fprintf('     loss of 20%% in exchange for 31%% potential upside.\n');
  fprintf('    E.Portfolio (e) - I am willing to accept a potential\n');
  fprintf('     loss of 27%% in exchange for 40%% potential upside.\n');
  fprintf('\n');
  fprintf('\n');
  Q5=input('( A - E )$ ','s');
  

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
  fprintf('== Risk Survey #6 =========================================\n');
  fprintf('\n');
  fprintf(' 6.Compared to others, how do you rate your willingness to \n');
  fprintf('  take financial risks?\n');
  fprintf('\n');
  fprintf('    A. Extremely low risk taker.\n');
  fprintf('    B. Low risk taker.\n');
  fprintf('    C. Average risk taker.\n');
  fprintf('    D. High risk taker.\n');
  fprintf('    E. Extremely high risk taker.\n');
  fprintf('\n');
  fprintf('\n');
  Q6=input('( A - E )$ ','s');
  
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

  fprintf('== Liquidity Preference ===================================\n');
  fprintf('\n');
  fprintf(' Generally, stocks with high market capitalization have low\n');
  fprintf('  liquidity risk and low potential return, and vice versa.\n');
  fprintf('  In order to achieve your investment objectives, which of \n');
  fprintf('  the following statement best describes your style?\n');
  fprintf('\n');
  fprintf('    A.I prefer high potential return and high liquidity\n');
  fprintf('     risks. \n');
  fprintf('    B.I prefer low liquidity risk and low potential return. \n');
  fprintf('    C.I don''t have preference on stock''s market cap.\n');
  fprintf('\n');
  MCP=input('( A - C )$ ','s');
  

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
  fprintf('== Risk Survey Result =====================================\n');
  fprintf('\n');
  fprintf('       YYY   YYY   OOOOOOO   UUU   UUU  RRRRRRR    \n');
  fprintf('        YYY YYY   OOO   OOO  UUU   UUU  RRR   RRR\n');
  fprintf('         YYYYY    OOO   OOO  UUU   UUU  RRR   RRR\n');
  fprintf('          YYY     OOO   OOO  UUU   UUU  RRRRRRRR\n');
  fprintf('          YYY     OOO   OOO  UUU   UUU  RRR   RRR\n');
  fprintf('          YYY      OOOOOOO    UUUUUUU   RRR    RRR\n');
  fprintf('\n');
  fprintf('RRRRRR    EEEEEEEEE   SSSSSS    UUU   UUU  LLL    TTTTTTTTT\n');
  fprintf('RR    RR  EEE        SS    SSS  UUU   UUU  LLL       TTT\n');
  fprintf('RR    RR  EEEEEEEEE   SSSS      UUU   UUU  LLL       TTT\n');
  fprintf('RRRRRRR   EEE            SSSS   UUU   UUU  LLL       TTT\n');
  fprintf('RR    RR  EEE        SSS    SS  UUU   UUU  LLL       TTT\n');
  fprintf('RR     RR EEEEEEEEE    SSSSSS    UUUUUUU   LLLLLLLLL TTT\n');
  fprintf('\n');
  fprintf('Your risk tolerance rating is:%.1f\n',rate);
  fprintf('\n');
  fprintf('\n');
  fprintf('Press any key to continue...');
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

