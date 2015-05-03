function [age, genderCode,genderName,name]=getPersonalInformation()
%PERSONAL Summary of this function goes here
%   Detailed explanation goes here

%Default Value
age=0;
gender=8;

%Age
  fprintf('== Age ====================================================\n');
  fprintf('\n');
  fprintf('* P o r t f o l i o   A d v i s o r *\n');
  fprintf('\n');
  fprintf(' - Would you mind telling me your age?\n');
  fprintf('\n');
  age=input('# ');
  clc;

%Gender
  fprintf('== Gender =================================================\n');
  fprintf('\n');
  fprintf('* P o r t f o l i o   A d v i s o r *\n');
  fprintf('\n');
  fprintf(' - How can I call you?\n');
  fprintf('\n');
  fprintf('    1. Mr.\n');
  fprintf('    8. Ms.\n');
  fprintf('    9. Miss.\n');
  fprintf('    0. Mrs.\n');
  fprintf('\n');
  fprintf('Kindly enter 1, 8, 9 or 0.\n');
  fprintf('\n');
  genderCode=input('# ');
  gender='1';
      genderName='Mr.';

  if genderCode<5 
    gender='1';
    else
    gender='8';
   end
   if genderCode==1
    genderName='Mr.';
   end
   if genderCode==8
    genderName='Ms.';
   end
   if genderCode==9
    genderName='Miss.';
   end
   if genderCode==0
    genderName='Mrs.';
   end
  clc;

%Name
  fprintf('== Gender =================================================\n');
  fprintf('\n');
  fprintf('* P o r t f o l i o   A d v i s o r *\n');
  fprintf('\n');
  fprintf(' - How can I call you?\n');
  fprintf('    ');
  name=input(strcat(genderName,' '),'s');
  clc;

end

