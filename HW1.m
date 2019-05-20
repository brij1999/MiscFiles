clc;
clear all;

a = xlsread('input1.xlsx');
b = xlsread('input2.xlsx');

A = sym(a);
B = sym(b);

if(det(A)==0)
    disp('Matrix A is Singular');
elseif(det(B)==0)
    disp('Matrix B is Singular');
else
    C = A/B;
    disp(C);
end