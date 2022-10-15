tic



iter_num=1000;
h=[2^(-4),2^(-5),2^(-6),2^(-7),2^(-8)];
err_l2_dst=zeros(1,5);  
err_max_dst=zeros(1,5);
err_l2_sor=zeros(1,5);  
err_max_sor=zeros(1,5);

for i=1:5
    [err_l2_dst(i),err_max_dst(i)]=DST(h(i));
    [err_l2_sor(i),err_max_sor(i)]=SOR(iter_num,h(i));
end

%%% slope
a=polyfit(log(h),log(err_l2_dst),1);
b=polyfit(log(h),log(err_max_dst),1);
c=polyfit(log(h),log(err_l2_sor),1);
d=polyfit(log(h),log(err_max_sor),1);

slope_l2_dst=a(1);
slope_max_dst=b(1);
slope_l2_sor=c(1);
slope_max_sor=d(1);

%%% dst2 plot

subplot(2,2,1)
loglog(h,err_l2_dst,'o','MarkerFaceColor',[0 0.447 0.741])
hold on
loglog(h,err_l2_dst)
title('loglog-DST2')
xlabel('h')
ylabel('L^2 norm error')
txt=['slope is ' num2str(slope_l2_dst)];
subtitle(txt)

subplot(2,2,2)
loglog(h,err_max_dst,'o','MarkerFaceColor',[0 0.447 0.741])
hold on
loglog(h,err_max_dst)
title('loglog-DST2')
xlabel('h')
ylabel('max norm error')
txt=['slope is ',num2str(slope_max_dst)];
subtitle(txt)

%%% SOR plot

subplot(2,2,3)
loglog(h,err_l2_sor,'o','MarkerFaceColor',[0 0.447 0.741])
hold on
loglog(h,err_l2_sor)
title('loglog-SOR')
xlabel('h')
ylabel('L^2 norm error')
txt=['slope is ' num2str(slope_l2_sor)];
subtitle(txt)

subplot(2,2,4)
loglog(h,err_max_sor,'o','MarkerFaceColor',[0 0.447 0.741])
hold on
loglog(h,err_max_sor)
title('loglog-SOR')
xlabel('h')
ylabel('max norm error')
txt=['slope is ' num2str(slope_max_sor)];
subtitle(txt)



toc