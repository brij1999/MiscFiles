clc;
clear all;

rate = 10;
duration = 4;
date = 20;
month = 'May';
year = 2019;
hour = 09;
minute = 00;
urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BPIDataDownloadHA','data.zip','post',...
    {'master',num2str(rate),'slave',num2str(duration),'DD1',num2str(date),'MMM1',month,'YYYY1',num2str(year),'HH1',num2str(hour),'MM1',num2str(minute)});
file = unzip('data.zip');
file = cell2mat(file);

[num,txt,raw] = xlsread(file);

delete(file);
