% Moving target trajectory
clear,clc
root_path = split(mfilename('fullpath'),'SubCode2');
%Set:lambda=0.05;hbar=2.5;psi=3;
s=importdata('root_path\SubCode3\ParaLambda\TECS_s1_2.mat');
X_1avest=s.X_avest;X_1real=s.X_real;t=s.t;rc_1av=s.rc_av;rg_1av=s.rg_av;
K=size(X_1avest{1}{1},2);
K1=size(X_1avest,1);m=size(X_1avest{1},1);
X_est=zeros(4,K);
for i=1:K1
    temp=zeros(4,K);
    for j=1:m
        temp=temp+X_1avest{i}{j};
    end
    X_est=X_est+temp/m;
end
X_est=X_est/K1;
%% Plot
t1=1:4:length(t);
figure(1),set(gcf,'unit','centimeters','Position',[10,2,15,15*1.2])
plot(400+X_est(1,t1),400+X_est(3,t1),'b--+','LineWidth',1.2)
hold on
plot(400+X_1real(1,t1),400+X_1real(3,t1),'-ro','LineWidth',1.2,'MarkerSize',8)
grid on
hold off
ax=xlabel('px[m]');ay=ylabel('py[m]');
set([ax,ay],struct('FontName',{'Times New Roman'},'FontSize',{12},'LineWidth',1,'Interpreter','Latex'));
set(gca,'Position',[0.1,0.08,0.87,0.91],'FontName','Times New Roman','FontSize',12,'LineWidth',1.2);