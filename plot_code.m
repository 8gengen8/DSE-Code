% clear,clc
load('data1.mat')
t = data.t;
X_real = data.X_real;
X_est = data.X_est;
P_est_Tr = zeros(1,length(t));
temp = zeros(1,length(t));
for k=1:length(t)-1
    P_est_Tr(k) = trace(data.P_est{k});
    temp(k) = det(data.P_est{k});
end
rate = mean(data.gamma,1);
rate_hat = data.rate_hat;
rate_mean = zeros(1,length(rate));
fprintf('统计平均通信率%.4f, 理论计算平均通信率%.4f.\n',mean(rate), mean(rate_hat))
%% 航迹绘图
figure(1);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
plot(X_real(1,:), X_real(3,:), 'k', X_est(1,:), X_est(3,:), 'r--+')
legend('True track', 'Estimated track')
set(findall(gcf, '-property', 'FontName', '-or', '-property', 'FontSize'),...
    'FontName', 'Times New Roman','FontSize', 12)
xlabel('p_x[m]', 'FontSize', 14)
ylabel('p_y[m]', 'FontSize', 14)
box on;set(gca, 'LineWidth', 1)
%% RMSE图
figure(2);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
subplot(211)
plot(t, sum(abs(X_real([1,3],:) - X_est([1,3],:))))
set(findall(gcf, '-property', 'FontName', '-or', '-property', 'FontSize'),...
    'FontName', 'Times New Roman','FontSize', 12)
xlabel('t[s]', 'FontSize', 14)
ylabel('y_{mae}', 'FontSize', 14)
box on;set(gca, 'LineWidth', 1)
subplot(212)
plot(t, sum(abs(X_real([2,4],:) - X_est([2,4],:))))
set(findall(gcf, '-property', 'FontName', '-or', '-property', 'FontSize'),...
    'FontName', 'Times New Roman','FontSize', 12)
xlabel('t[s]', 'FontSize', 14)
ylabel('v_{mae}', 'FontSize', 14)
box on;set(gca, 'LineWidth', 1)
%% 协方差矩阵的迹绘图
figure(3);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
plot(t, P_est_Tr)
set(findall(gcf, '-property', 'FontName', '-or', '-property', 'FontSize'),...
    'FontName', 'Times New Roman','FontSize', 12)
xlabel('t[s]', 'FontSize', 14)
ylabel('Tr(P)', 'FontSize', 14)
box on;set(gca, 'LineWidth', 1)
%% 通信率绘图
figure(4);set(gcf,'unit','centimeters','Position',[10,10,15,15*0.5])
plot(t(1:end-1), rate)
set(findall(gcf, '-property', 'FontName', '-or', '-property', 'FontSize'),...
    'FontName', 'Times New Roman','FontSize', 12)
xlabel('t[s]', 'FontSize', 14)
ylabel('r', 'FontSize', 14)
box on;set(gca, 'LineWidth', 1)