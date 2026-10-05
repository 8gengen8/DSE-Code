%基于测量值设计的事件触发策略，交换测量值进行分布式滤波
clear,clc
%% 0.定义模型参数
load('A'); load('test_data.mat')
X0 = [10; 5; 20; 8];
P0 = diag([20, 5, 20, 5]);
K_MC=size(y_mc,1); K=size(X_real_mc{1},2)-1;
F=model_para.F; Q=model_para.Q; H=model_para.H; R=model_para.R;
n = size(F,1); m= size(R,1); num_node = size(y_mc,2);
X_est_MC = cell(K_MC,1);
P_est_MC = cell(K_MC,1);
rate_MC = cell(K_MC,1);
disp('开始蒙特卡洛实验...')
%% 1.事件触发的分布式滤波器
ProgressBar=waitbar(0,'请稍候...','Name','Our Aigorithm');
for k_mc = 1:K_MC
    %1.0 初始化滤波器
    X_F = cell(num_node, 1);
    P_F = cell(num_node, K);
    X_befor = cell(num_node, 1);
    P_befor = cell(num_node, K);
    X_after = cell(num_node, 1);
    P_after = cell(num_node, K);
    gamma = zeros(num_node, K);
    Psi = cell(num_node,1);
    X_bar = cell(num_node, 1);
    P_bar = cell(num_node, K);
    for i=1:num_node
        X_F{i} = zeros(n, K);
        P_F{i,1} = P0;
        X_befor{i} = zeros(n, K);
        X_after{i} = zeros(n, K);
        gamma(i,1) = 1;
        Psi{i} = 0.16*eye(m);
        X_bar{i} = zeros(n, K);
        P_bar{i,1} = zeros(n);
    end
    for k=1:K
        for i=1:num_node
            %1.1 预测方程：时间更新
            X_befor{i}(:,k) = F * X_F{i}(:,k);
            P_befor{i,k} = F * P_F{i,k} * F.' + Q;
            %1.2 修正方程：测量更新
            info_mat_after = inv(P_befor{i,k}) + H.' * inv(R) * H;
            P_after{i,k} = inv(info_mat_after);
            X_after{i}(:,k) = P_after{i,k} * (inv(P_befor{i,k}) * ...
                X_befor{i}(:,k) + H.' * inv(R) * Y{i}(:,k));
            %1.3 事件触发（初始时刻默认触发）
            if k>1
                r = Y{i}(:,k) - H * F * X_bar{i}(:,k-1);
                indicator = exp(-(r.' * Psi{i} * r)/2);
                if indicator <= rand
                   gamma(i,k) = 1;
                end
                X_bar{i}(:,k) = gamma(i,k) * X_after{i}(:,k) +...
                            (1 - gamma(i,k)) * F * X_bar{i}(:,k-1);%信息交换
                P_bar{i,k} = gamma(i,k) * P_after{i,k} + ...
                            (1-gamma(i,k)) * (F * P_bar{i,k-1} * F.' + Q);
            else
                P_bar{i,k} = P_after{i,k};X_bar{i}(:,1) = X_after{i}(:,1);
            end
        end
        for i=1:num_node
            %1.4 融合方程：
            info_mat_after = inv(P_after{i,k});
            info_mat_F = info_mat_after;
            info_vec = info_mat_after * X_after{i}(:,k);
            in_neighbors = find(A(i,:) == 1);%内邻居集合
            for j = in_neighbors
                info_mat_F = info_mat_F + H.' * inv(R + (1 - gamma(j,k)) * inv(Psi{j})) * H;
                info_vec = info_vec + H.' * (gamma(j,k) * inv(R) * Y{j}(:,k) + ...
                    (1 - gamma(j,k)) * inv(inv(Psi{j}) + R) * H * X_bar{j}(:,k));
            end
            P_F{i,k+1} = inv(info_mat_F);
            X_F{i}(:,k+1) = P_F{i,k+1} * info_vec;
        end
    end 
    X_est_MC{k_mc} = X_F;
    P_est_MC{k_mc} = P_F;
    rate_MC{k_mc} = gamma;
    waitbar(k_mc/(K_MC-1), ProgressBar, sprintf('进度: %.1f%%',100*k_mc/(K_MC-1)));% 更新进度条
end
close(ProgressBar);
%% 3.计算关键数据：平均RMSE、平均协方差迹和平均通信率
disp('正在计算...')
mae_node = zeros(num_node, K+1);
P_est_Tr = zeros(num_node, K+1);
rate = zeros(1, K);
for k_mc = 1:K_MC
    for i=1:num_node
        error = X_est_MC{k_mc}{i}([1,3],:) - X_real_mc{k_mc}([1,3],:);
        mae_node(i,:) = mae_node(i,:) + sum(error.^2);
        P_est_Tr(i,:) = P_est_Tr(i,:) + cellfun(@trace, P_est_MC{k_mc}(i,:));
    end
    rate = rate + mean(rate_MC{k_mc});
end
RMSE_avg = mean(sqrt(mae_node/K_MC));
P_est_Tr_avg = mean(P_est_Tr/K_MC);
rate_avg = rate/K_MC;
disp('计算结束！')
%% 4.保存数据
disp('正在保存数据，请稍后...')
data = struct('t', {t}, 'RMSE_avg', {RMSE_avg}, 'P_est_Tr_avg', {P_est_Tr_avg}, ...
              'rate_avg', {rate_avg});
save('data.mat', 'data')
disp('数据保存完毕！')