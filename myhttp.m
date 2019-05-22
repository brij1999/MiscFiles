clc;
clear all;

rate = '10';
duration = '4';
date = '20';
month = 'May';
year = '2019';
hour = '09';
minute = '00';
urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BPIDataDownloadHA','data.zip','post',...
    {'master',rate,'slave',duration,'DD1',date,'MMM1',month,'YYYY1',year,'HH1',hour,'MM1',minute});
file = unzip('data.zip');
file = cell2mat(file);

[num,txt,raw] = xlsread(file);

delete(file);