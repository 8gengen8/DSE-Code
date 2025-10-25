function [rmse,armse]=func1(x_real,x_est)
mc_num=size(x_real,1);node_num=size(x_est{1},1);
sample_num=size(x_real{1},2);
rmse_node=zeros(node_num,sample_num);
for k=1:mc_num
    for i=1:node_num
        rmse_node(i,:)=rmse_node(i,:)+sum((x_real{k}([1,3],:)-x_est{k}{i}([1,3],:)).^2);
    end
end
rmse=mean(sqrt(rmse_node/mc_num));
armse=mean(sqrt(sum(rmse_node,2)/(mc_num*sample_num)));
end
