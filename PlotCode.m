clear,clc
load('test_data.mat')
mu=[0.01 0.1 0.5 1 1.5 2.5];
s1_1=load('TECS_s1_1.mat').s1;
[rmse1,armse1]=func1(X_real_mc,s1_1.X_est_mc);
[r1,rc1,rg1,r_av1,rc_av1,rg_av1]=func2(s1_1.c_mc,s1_1.g_mc,1);
s1_2=load('TECS_s1_2.mat').s1;
[rmse2,armse2]=func1(X_real_mc,s1_2.X_est_mc);
[r2,rc2,rg2,r_av2,rc_av2,rg_av2]=func2(s1_2.c_mc,s1_2.g_mc,1);
s1_3=load('TECS_s1_3.mat').s1;
[rmse3,armse3]=func1(X_real_mc,s1_3.X_est_mc);
[r3,rc3,rg3,r_av3,rc_av3,rg_av3]=func2(s1_3.c_mc,s1_3.g_mc,1);
s1_4=load('TECS_s1_4.mat').s1;
[rmse4,armse4]=func1(X_real_mc,s1_4.X_est_mc);
[r4,rc4,rg4,r_av4,rc_av4,rg_av4]=func2(s1_4.c_mc,s1_4.g_mc,1);
s1_5=load('TECS_s1_5.mat').s1;
[rmse5,armse5]=func1(X_real_mc,s1_5.X_est_mc);
[r5,rc5,rg5,r_av5,rc_av5,rg_av5]=func2(s1_5.c_mc,s1_5.g_mc,1);
s1_6=load('TECS_s1_6.mat').s1;
[rmse6,armse6]=func1(X_real_mc,s1_6.X_est_mc);
[r6,rc6,rg6,r_av6,rc_av6,rg_av6]=func2(s1_6.c_mc,s1_6.g_mc,1);
disp('数据加载和计算完毕！')
disp([mean(rmse1(101:end)) mean(rmse2(101:end)) mean(rmse3(101:end)) mean(rmse4(101:end)) mean(rmse5(101:end)) mean(rmse6(101:end))])
%% 1.RMSE figure
curve_colors = [0.12 0.47 0.71;0.20 0.73 0.81;0.55 0.71 0.40;
    0.80 0.40 0.80;0.95 0.60 0.30;0.40 0.30 0.65];
line_specs = {'-',  'o', 6;'--', 's', 6;'-.',  '^', 6;
    ':', 'd', 6;'--', '^', 6;'-.', '+', 6};
figure(1);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.6])
subplot(211)
rmse=[rmse1; rmse2; rmse3; rmse4; rmse5;rmse6];
hold on
for i = 1:size(rmse,1)
    plot(t, rmse(i,:), 'Color', curve_colors(i,:), 'LineStyle', line_specs{i,1}, ...
        'MarkerSize', line_specs{i,3},'MarkerFaceColor', 'white', ...
        'LineWidth', 1.2);
end
hold off
ax=xlabel('time:s');ay=ylabel('RMSE:m');
al=legend(['$\mu=0.01, \bar{r}$=',num2str(100*r_av1),'\%'],...
          ['$\mu=0.1, \bar{r}$=',num2str(100*r_av2),'\%'],...
          ['$\mu=0.5, \bar{r}$=',num2str(100*r_av3),'\%'],...
          ['$\mu=1, \bar{r}$=',num2str(100*r_av4),'\%'],...
          ['$mu=1.5,  \bar{r}$=',num2str(100*r_av5),'\%'],...
          ['$\mu=2.5,  \bar{r}$=',num2str(100*r_av6),'\%'],'NumColumns', 2,'Location', 'best');
set([ax,ay,al],struct('FontName',{'Times New Roman'},'FontSize',{12},'LineWidth',1,'Interpreter','Latex'));
box on;set(gca, 'LineWidth', 1);
%Communication plot
curve_colors = [0.00 0.45 0.74;0.85 0.33 0.10;0.47 0.67 0.19;
    0.70 0.20 0.60;0.90 0.75 0.00;0.80 0.00 0.20];
subplot(212)
r=[r1; r2; r3; r4; r5; r6];
hold on
for i = 1:size(r,1)
    plot(t(1:end-1), r(i,:), 'Color', curve_colors(i,:), 'LineStyle', line_specs{i,1}, ...
        'MarkerSize', line_specs{i,3},'MarkerFaceColor', 'white', ...
        'LineWidth', 1.2);
end
hold off
ax=xlabel('time:s');ay=ylabel('r$');
al=legend({'$\mu=0.01$','$\mu=0.1$','$\mu=0.5$','$\mu=1$','$\mu=1.5$','$\mu=2.5$'},'NumColumns', 2,'Location', 'best');
set([ax,ay,al],struct('FontName',{'Times New Roman'},'FontSize',{12},'LineWidth',1,'Interpreter','Latex'));
box on;set(gca, 'LineWidth', 1);
%% 3. Up and down bar
r_c_g=[r_av1 rc_av1 rg_av1;r_av2 rc_av2 rg_av2;r_av3 rc_av3 rg_av3;...
       r_av4 rc_av4 rg_av4;r_av5 rc_av5 rg_av5;r_av6 rc_av6 rg_av6];
value_colors1 = [0.90 0.29 0.23;0.16 0.44 0.69;0.07 0.62 0.42];
value_colors2 = [0.55 0.71 0.80;0.80 0.73 0.55;0.65 0.80 0.65];
value_colors3 = [0.60 0.85 1.00;1.00 0.90 0.60;0.60 1.00 0.60];
figure(2);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
rbar=bar(r_c_g, 'grouped');
hold on
for k = 1:size(r_c_g,2)
    rbar(k).FaceColor = 'flat';
    rbar(k).CData = repmat(value_colors2(k,:), size(r_c_g,1), 1);
end
plot((1:6)-0.2222, r_c_g(:,1), 'o-','LineWidth', 1.5,'Color', value_colors3(1,:));
plot((1:6), r_c_g(:,2), 's--', 'LineWidth', 1.5,'Color',  value_colors3(2,:));
plot((1:6)+0.2222, r_c_g(:,3), 'd-.', 'LineWidth', 1.5,'Color', value_colors3(3,:));
xlabel('$\alpha$','Interpreter','latex')
hold off
ylabel('Average communication rate')
legend({'$\bar{r}$', '$\bar{r}_\eta$', '$\bar{r}_\gamma$','$\bar{r}$', ...
        '$\bar{r}_\eta$', '$\bar{r}_\gamma$'},'NumColumns', 2,'Location', 'best','Interpreter','latex')
grid on
% Set axis ticks
xticks(1:6)
xticklabels({num2str(mu(1)), num2str(mu(2)), num2str(mu(3)),...
             num2str(mu(4)), num2str(mu(5)),num2str(alpha(6))})
set(gca, 'FontName', 'Times New Roman', 'FontSize', 12);
box on;set(gca, 'LineWidth', 1);