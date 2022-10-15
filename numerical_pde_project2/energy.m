function[E]=energy(h,N,epsilon,u)

e2=zeros(N,N);
for j=1:N
    for i=1:N
        if i==1
            u_left=u(j,N);
        else
            u_left=u(j,i-1);
        end
        if i==N
            u_right=u(j,1);
        else
            u_right=u(j,i+1);
        end

        if j==1
            u_down=u(N,i);
        else
            u_down=u(j-1,i);
        end
        if j==N
            u_up=u(1,i);
        else
            u_up=u(j+1,i);
        end

        e2(j,i)=(u_left+u_right+u_down+u_up-4*u(j,i))*u(j,i);
    end
end

%%% energy
E=sum(sum((u.^2-1).^2/(4*epsilon)*h*h - epsilon/2*u.*e2));