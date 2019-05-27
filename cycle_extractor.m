
clc;
clear all;

mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 10;
date = 22;
month = 5;
year = 2019;

nrow = 1;
prev=0;
n=1;
Cycles(n,1) = 1;

while n<10
    urlwrite('http://srs2.cat.ernet.in:8100/servlet/Indus2BeamInfoDataDownloadHA','received.zip','post',...
        {'sample_rate',num2str(rate),'DD1',num2str(date),'MMM1',mnths(month),'YYYY1',num2str(year)});

    file = unzip('received.zip');
    file = cell2mat(file);
    [num,txt,raw] = xlsread(file);
    delete(file);
    
    date=date+1;
    
    num = num((num(:,2)>1),:);
    nextr = ['A' num2str(nrow)];
    xlswrite('data.xlsx', num, 1, nextr);
    s = size(num);
    s = s(1);
    nrow = nrow + s;
    
    i=2;
    while i<s
        while i<s && (num(i,3) - num(i+1,3))<1000 
           i=i+1;
        end

        if i>=s
            break;
        end

        Cycles(n,2)=prev+i;
        n=n+1;
        i=i+1;
        Cycles(n,1)=prev+i;
    end
    Cycles(n,2)=prev+i;
    prev=prev+s;
end

[num,txt,raw] = xlsread('data.xlsx');
%----------------: Repeat for Each cycle :--------------------
for i=1:n
    cycle = num(Cycles(i,1):Cycles(i,2),:)
    s = size(cycle);
    figure;
    subplot(2,1,1);
    plot(cycle(:,2),'r','LineWidth',2);
    title('Beam Current');
    ylabel('Current (in mA)');
    axis([0 s(1) 0 200]);
    grid on;

    subplot(2,1,2);
    plot(cycle(:,3),'b','LineWidth',2);
    title('Beam Energy');
    ylabel('Energy (in meV)');
    axis([0 s(1) 0 3000]);
    grid on;
end

