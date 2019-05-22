clc;
clear all;

mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 1;
duration = 4;
date = 22;
month = 5;
year = 2019;
hour = 11;
minute = 19;

urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BPIDataDownloadHA','data.zip','post',...
    {'master',num2str(rate),'slave',num2str(duration),'DD1',num2str(date),'MMM1',...
    mnths(month),'YYYY1',num2str(year),'HH1',num2str(hour),'MM1',num2str(minute)});

file = unzip('data.zip');
file = cell2mat(file);

[num,txt,raw] = xlsread(file);

delete(file);
