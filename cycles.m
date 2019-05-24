
clc;
clear all;

mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 4;
date = 22;
month = 5;
year = 2019;

hr = 0;
nrow = 1;
%{
urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BeamInfoDataDownloadHA','data2.zip','post',...
    {'sample_rate',num2str(rate),'DD1',num2str(date),'MMM1',mnths(month),'YYYY1',num2str(year)});

file = unzip('data2.zip');
file = cell2mat(file);

[num,txt,raw] = xlsread(file);

delete(file); 
%}
[num,txt,raw] = xlsread('asd.csv');
subplot(2,1,1);
plot(num(:,2),'r','LineWidth',2);
title('Beam Current');
ylabel('Current (in mA)');
axis([0 2.5*10^4 0 200]);
grid on;

subplot(2,1,2);
plot(num(:,3),'b','LineWidth',2);
title('Beam Energy');
ylabel('Energy (in meV)');
axis([0 2.5*10^4 0 3000]);
grid on;

X = find(num(:,2)>1);
s = size(X);

i=1;
n=0;
Wstart = [];

while i<s(1)
    n=n+1;
    i=i+1;
    Wstart(n)=X(i);

    while i<s(1) && (num(X(i),3) - num(X(i+1),3))<1500 
       i=i+1;
    end
end







