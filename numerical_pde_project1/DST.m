function[err_l2_dst,err_max_dst]=DST(h)

N=1/h - 1;

%%%% real solution
u_real=zeros(N,N);
for j=1:N
    for i=1:N
        u_real(j,i)=(i*h)^2*(1-i*h)^2*(j*h)^2*(1-j*h)^2;
    end
end

%%%% eigenvalue
lam2=zeros(N,N);
for j=1:N
    for i=1:N
        lam2(j,i)=2*(cos(i*h*pi)+cos(j*h*pi)-2)/h^2 - 100;
    end
end

%%%% value of f
F=zeros(N,N);
for j=1:N
    for i=1:N
        x=i*h;
        y=j*h;
        F(j,i)=(12*x^2-12*x+2)*(y^2)*(1-y)^2+(12*y^2-12*y+2)*(x^2)*(1-x)^2-100*(x^2)*(y^2)*(1-x)^2*(1-y)^2;
    end
end

u=real(idst2(dst2(F)./lam2));

%%%% error
err=u-u_real;
err_max_dst=max(max(abs(err)));
err_l2_dst=sqrt((sum(sum(err.^2)))*(h^2));