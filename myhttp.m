clc;
clear all;

mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 1;
duration = 4;
date = 22;
month = 5;
year = 2019;

hr = 0;
nrow = 1;

while hr<24
    pause(1);
    
    urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BPIDataDownloadHA','received.zip','post',...
    {'master',num2str(rate),'slave',num2str(duration),'DD1',num2str(date),'MMM1',...
    mnths(month),'YYYY1',num2str(year),'HH1',num2str(hr),'MM1','00'});
    
    file = unzip('received.zip');
    file = cell2mat(file);
    [num,txt,raw] = xlsread(file);
    delete(file);
    nextr = ['A' num2str(nrow)];
    xlswrite('data.xlsx', raw, 1, nextr);
    
    
    s = size(raw);
    nrow = nrow + s(1);
    hr = hr + duration;
end
