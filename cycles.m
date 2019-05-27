
clc;
clear all;

%{
mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 4;
date = 22;
month = 5;
year = 2019;

hr = 0;
nrow = 1;

urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BeamInfoDataDownloadHA','data2.zip','post',...
    {'sample_rate',num2str(rate),'DD1',num2str(date),'MMM1',mnths(month),'YYYY1',num2str(year)});

file = unzip('data2.zip');
file = cell2mat(file);

[num,txt,raw] = xlsread(file);

delete(file); 
%}
[num,txt,raw] = xlsread('asd.csv');
s = size(num);

subplot(2,1,1);
plot(num(:,1),'r','LineWidth',2);
title('Beam Current');
ylabel('Current (in mA)');
axis([0 s(1) 0 200]);
grid on;

subplot(2,1,2);
plot(num(:,2),'b','LineWidth',2);
title('Beam Energy');
ylabel('Energy (in meV)');
axis([0 s(1) 0 3000]);
grid on;

X = find(num(:,1)>1);
s = size(X);

i=2;
n=1;
Cycles(n,1) = X(1);
while i<s(1)
    while i<s(1) && (num(X(i),2) - num(X(i+1),2))<1000 
       i=i+1;
    end
    
    if i>=s(1)
        break;
    end
    
    Cycles(n,2)=X(i);
    n=n+1;
    i=i+1;
    Cycles(n,1)=X(i);
end
Cycles(n,2)=X(i);







