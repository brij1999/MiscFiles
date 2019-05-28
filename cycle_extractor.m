%syadav@rrcat.gov.in
clc;
clear all;

mnths = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
rate = 10;
date = 20;
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
    if month==1 || month==3 || month==5 || month==7|| month==8 || month==10 || month==12
        if date>31
            date=1;
            month=month+1;
        end

    elseif month==4 || month==6 || month==9 || month==11
        if date>30
            date=1;
            month=month+1;
        end

    elseif month==2
        if mod(year,4)==0 && (mod(year,100)~=0 || mod(year,400)==0) 
            if date>29
                date=1;
                month=month+1;
            end

        elseif date>28
            date=1;
            month=month+1;
        end
    end
    if month>12
        month=1;
        year=year+1;
    end
    
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
for j=1:n
    cycle = num(Cycles(j,1):Cycles(j,2),:);
    s = size(cycle);
    inj = 0;
    rmp = 0;
    stg = 0;
    
    for i=1:s(1)-1
        if ~inj && cycle(i,3)<=550
            inj=i;
            
        elseif ~rmp && cycle(i,3)<=550 && abs(cycle(i,3)-cycle(i+1,3))>0.5
            rmp=i;
            
        elseif ~stg && cycle(i,3)>2490 && abs(cycle(i,3)-cycle(i+1,3))<0.5
            stg=i;
        end
    end
    
    figure('Name',['Cycle - ', num2str(j)],'NumberTitle','off')
    x=ones(1,100);
    y=linspace(0,1,100);
    
    subplot(2,1,1);
    plot(cycle(:,2),'r','LineWidth',2);
    title('Beam Current');
    ylabel('Current (in mA)');
    axis([0 s(1) 0 200]);
    grid on;
    hold on;
    line(inj.*x,200.*y,'Color','m','LineWidth',2);
    line(rmp.*x,200.*y,'Color','g','LineWidth',2);
    line(stg.*x,200.*y,'Color','c','LineWidth',2);
    
    subplot(2,1,2);
    plot(cycle(:,3),'b','LineWidth',2);
    title('Beam Energy');
    ylabel('Energy (in meV)');
    axis([0 s(1) 0 3000]);
    grid on;
    hold on;
    line(inj.*x,3000.*y,'Color','m','LineWidth',2);
    line(rmp.*x,3000.*y,'Color','g','LineWidth',2);
    line(stg.*x,3000.*y,'Color','c','LineWidth',2);
end



