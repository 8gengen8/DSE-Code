%Generate test data
T=0.1;tf=50;K1=300;m=100;K=floor(tf/T);
qx=2;qy=2;F=[1 T 0 0;0 1 0 0;0 0 1 T;0 0 0 1];G=[T^2/2 0;T 0;0 T^2/2;0 T];
H=[1 0 0 0;0 0 1 0];Q=G*diag([qx^2 qy^2])*G.';R=diag([10 10]);
t=0:T:tf;model_para=struct('F',F,'Q',Q,'H',H,'R',R);
X_real=zeros(size(F,1),K+1);X_real(:,1)=[10;5;20;8];
X_real_mc=cell(K1,1);y_mc=cell(K1,m);
ProgressBar=waitbar(0,'Please wait...','Name','TECS-based DSE');
for k1=1:K1
    for k=1:K
        X_real(:,k+1)=F*X_real(:,k)+G*normrnd(0,sqrt([qx^2;qy^2]));
    end
    X_real_mc{k1}=X_real;
    for i=1:m
        y_mc{k1,i}=H*X_real+sqrt(diag(R)).*randn(size(H,1),K+1);
    end
    waitbar(k1/K1, ProgressBar, sprintf('Process: %.1f%%',100*k1/K1));
end
close(ProgressBar)
save('test_data','X_real_mc','y_mc','t','model_para')