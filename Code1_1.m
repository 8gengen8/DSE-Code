%Randomly generate nodes
clear,clc
m=100;
Sen_nodes=unifrnd(0,1000,2,m);
%load('Sen_nodes')
h1=2;
h2=0;
r=220;
%% Generate an adjacency matrix.
A=zeros(m);
for i=1:m-1
    for j=i+1:m
        d=sqrt(sum((Sen_nodes(:,i)-Sen_nodes(:,j)).^2));
        if d<=r;A(i,j)=1;end
    end
end
A=A+A.';
% Save data
save('A','A'),save('Sen_nodes','Sen_nodes')
%% Draw communication topology
figure(1),set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
subplot(1,2,2)
scatter(Sen_nodes(1,:),Sen_nodes(2,:),'ks','MarkerFaceColor','k') 
hold on
for i=1:m-1
    for j=i+1:m
        if A(i,j)==1
            plot([Sen_nodes(1,i) Sen_nodes(1,j)],...
                [Sen_nodes(2,i) Sen_nodes(2,j)],'b')
        end
    end
end
xlabel('$p_x$ [m]','interpreter','latex')
ylabel('$p_y$ [m]','interpreter','latex')
hold off
% Draw 3D topology
subplot(1,2,1)
scatter3(Sen_nodes(1,:),Sen_nodes(2,:),h1*ones(1,length(Sen_nodes(1,:))),'ks','MarkerFaceColor','k')
hold on
scatter3(Sen_nodes(1,1:30),Sen_nodes(2,1:30),h2*ones(1,30),'r^','MarkerFaceColor','r')
for i=1:m
    if i<31
        plot3([Sen_nodes(1,i) Sen_nodes(1,i)],[Sen_nodes(2,i) Sen_nodes(2,i)],[h1,h2],'g')
    end
    for j=i+1:m
        if A(i,j)==1
            plot3([Sen_nodes(1,i) Sen_nodes(1,j)],[Sen_nodes(2,i) Sen_nodes(2,j)],[h1,h1],'b')
        end
     end
end
xlabel('$p_x$ [m]','interpreter','latex')
ylabel('$p_y$ [m]','interpreter','latex')
zlabel('$h [\times$100m]','interpreter','latex')
hold off