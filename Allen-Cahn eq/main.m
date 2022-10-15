clear;
N=256;
h=2*pi/N;
deltat=0.01;
epsilon=0.1;
beta=2/epsilon;
T=6;

% eigenvalues
[X,Y]=meshgrid(h:h:N*h);
lam2 = 1+beta*deltat-epsilon*deltat*2*(cos(X)+cos(Y)-2)/h^2;

% initial value of u
uin=0.05*(2*rand(N,N)-1);
aver=sum(sum(uin))/N^2;
uin=uin-aver;
u=uin;

% energy and u
subplot(2,3,1);
imagesc(u);
title('T=0');
axis off;

Energy=zeros(1,T/deltat+1);
Energy(1)=energy(h,N,epsilon,u);

for i=1:T/deltat
    % use fft2 to obtain the numerical solution of u
    F=(1+beta*deltat).*u + deltat/epsilon.*(u-u.^3);
    u=real(ifft2(fft2(F)./lam2));
    % energy
    Energy(i+1)=energy(h,N,epsilon,u);
    
    % plot
    if i*deltat == 0.4 
        subplot(2,3,2);
        imagesc(u);
        title('T=0.4');
        axis off;
    end
    if i*deltat == 1 
        subplot(2,3,3);
        imagesc(u);
        title('T=1');
        axis off;
    end
    if i*deltat == 2 
        subplot(2,3,4);
        imagesc(u);
        title('T=2');
        axis off;
    end
    if i*deltat == 6
        subplot(2,3,5);
        imagesc(u);
        title('T=6');
        axis off;
    end
end
 
% plot
subplot(2,3,6);
plot(Energy)
title('Energy evolution')
ylabel('Energy');
xlabel('T')
xticks((0:100:600))
xticklabels({'0','1','2','3','4','5','6'});