function[err_l2_sor,err_max_sor]=SOR(iter_num,h)

k=1;
GS=0;
N=1/h -1;
U_ini=0.5*ones(N,N);
w=2/(1+sin(pi/N));  %relaxtion parameter

%%%% real solution
u_real=zeros(N,N);
for j=1:N
    for i=1:N
        u_real(j,i)=(i*h)^2*(1-i*h)^2*(j*h)^2*(1-j*h)^2;
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


while(k<=iter_num)
    U_end=zeros(N,N);
    for j=1:N
        for i=1:N
            if i==1
                s_l=0;
            else
                s_l=U_end(j,i-1);
            end
            if i==N
                s_r=0;
            else
                s_r=U_ini(j,i+1);
            end
            if j==1
                s_d=0;
            else
                s_d=U_end(j-1,i);
            end
            if j==N
                s_u=0;
            else
                s_u=U_ini(j+1,i);
            end

            GS=GS+((s_l+s_r+s_d+s_u)-h^2*F(j,i))/(4+100*h^2);
            U_end(j,i)=(1-w)*U_ini(j,i)+w*GS;
            GS=0;
        end
    end
    k=k+1;
    U_ini=U_end;
end

%%%% error
err=U_end-u_real;
err_max_sor=max(max(abs(err)));
err_l2_sor=sqrt((sum(sum(err.^2)))*(h^2));