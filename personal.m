function personal()
%PERSONAL Summary of this function goes here
%   Detailed explanation goes here
%Age
  age=input('== Age ====================================================\n\n* P o r t f o l i o   A d v i s o r *\n\n - Would you mind telling me your age?\n\n# ');
  clc;

%Gender
  genderCode=input('== Gender =================================================\n\n* P o r t f o l i o   A d v i s o r *\n\n - How can I call you?\n\n    1. Mr.\n    8. Ms.\n    9. Miss.\n    0. Mrs.\n\nKindly enter 1, 8, 9 or 0.\n\n# ');
  if genderCode<5 
    gender='1';
    else
    gender='0';
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
  fprintf('== Gender =================================================\n\n* P o r t f o l i o   A d v i s o r *\n\n - How can I call you?\n    ');
  name=input(strcat(genderName,' '),'s');
  clc;

end

