function [X_real, Y, n, m, F, Q, H, R] = system_model(K, T, dim, num_node, X0, P0)
%1.定义状态空间模型
F = kron(eye(dim), [1, T;0, 1]);
G = kron(eye(dim), [T^2/2; T]);
Sigma = diag([4, 4]);
Q = G * Sigma * G';
H = [1, 0, 0, 0;0, 0, 1, 0];
R = 10 * eye(2);
%2.系统仿真
n = size(F,1);
m = size(R,1);
X_real = zeros(n, K+1);
X_real(:,1) = mvnrnd(X0, P0)';
Y = cell(num_node);
for i=1:num_node
    Y{i} = zeros(m, K);
end
for k=1:K
    w_k = mvnrnd(zeros(size(Sigma,1),1), Sigma)';
    X_real(:,k+1) = F * X_real(:, k) + G * w_k;
    for i=1:num_node
        v_ki = mvnrnd(zeros(size(R,1),1), R)';
        Y{i}(:,k) = H * X_real(:, k+1) + v_ki;
    end
end
end