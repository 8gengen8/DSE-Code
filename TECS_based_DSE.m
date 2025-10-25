%Method 1 (TECS-based DSE): Our proposed DSE with two event-triggered
% communication strategies.
clear,tic
root_path = split(mfilename('fullpath'),'SubCode3');
load('root_path\SubCode1\A.mat')
load('root_path\SubCode1\test_data');
%Set different parameter
lambda=0.8;hbar=4;psi=4;mu=0.5;
K1=size(y_mc,1);m=size(y_mc,2);K=size(X_real_mc{1},2)-1;
F=model_para.F;Q=model_para.Q;H=model_para.H;R=model_para.R;
w=zeros(m);
Deg=sum(A,2);
for i=1:m
    for j=1:m
        if i~=j && A(i,j)==1
            w(i,j)=1/(1+max(Deg(i),Deg(j)));
        end
    end
    w(i,i)=1-sum(w(i,:));
end
X_est_mc=cell(K1,1);c_mc=cell(K1,1);g_mc=cell(K1,1);
ProgressBar=waitbar(0,'Please wait...','Name','TECS-based DSE');
for k1=1:K1
    disp(k1)
    %0.Define empty matrix and initial values.
    X_est=cell(m,1);X_after=cell(m,1);
    q_after=cell(m,1);Omega_after=cell(m,1);q_bar=cell(m,1);
    Omega_bar=cell(m,1);c=ones(m,K);g=zeros(m,K);
    for i=1:m
        X_est{i}=zeros(4,K+1);X_after{i}=zeros(4,K+1);q_after{i}=zeros(4,1);
        q_bar{i}=zeros(4,1);Omega_after{i}=diag([1/20 1/5 1/20 1/5]);
        Omega_bar{i}=diag([1/20 1/5 1/20 1/5]);
    end
    for k=1:K
        %1.Calculate event-driven factor c
        if k>1
            for i=1:m
                temp0=X_after{i}(:,k)-Omega_bar{i}^-1*q_bar{i};
                temp0=temp0.'*Omega_after{i}*temp0;
                temp1=[eig(Omega_after{i}*exp(-hbar)-Omega_bar{i});...
                       eig(Omega_bar{i}-Omega_after{i}*exp(psi))];
                temp1=sum(temp1<=0);
                if temp0<=lambda && temp1==8;c(i,k)=0;end
            end
        end
        %2.Filter
        for i=1:m
            %2.1 Fusion equation
            qi_F=w(i,i)*q_after{i};Omegai_F=w(i,i)*Omega_after{i};
            for j=1:m
                if j~=i
                    qi_F=qi_F+w(i,j)*(c(j,k)*q_after{j}+exp(-psi)*(1-c(j,k))*q_bar{j});
                    Omegai_F=Omegai_F+w(i,j)*(c(j,k)*Omega_after{j}+...
                            exp(-psi)*(1-c(j,k))*Omega_bar{j});
                end
            end
            X_est{i}(:,k+1)=Omegai_F^-1*qi_F;
            %2.2 Prediction equation
            Omegai_befor=(F*Omegai_F^-1*F.'+Q)^-1;
            qi_befor=Omegai_befor*F*(Omegai_F)^-1*qi_F;
            temp1=(c(i,k)*Omega_after{i}+(1-c(i,k))*Omega_bar{i})^-1;
            temp2=(c(i,k)*q_after{i}+(1-c(i,k))*q_bar{i});
            Omega_bar{i}=(F*temp1*F.'+Q)^-1;
            q_bar{i}=Omega_bar{i}*F*temp1*temp2;
            %2.3 Correction equation
            if i<31 && rand>=trace(mu*Omegai_befor)/trace((mu*Omegai_befor+H.'*R^-1*H));g(i,k)=1;end
            q_after{i}=qi_befor+g(i,k)*H.'*R^-1*y_mc{k1,i}(:,k+1);
            Omega_after{i}=Omegai_befor+g(i,k)*H.'*R^-1*H;
            X_after{i}(:,k+1)=Omega_after{i}^-1*q_after{i};
        end
    end
    X_est_mc{k1}=X_est;c_mc{k1}=c;g_mc{k1}=g;
    %2.4 Update progress bar
    waitbar(k1/K1, ProgressBar, sprintf('Process: %.1f%%',100*k1/K1));
end
close(ProgressBar)
%3. Save data
s1=struct('X_est_mc',{X_est_mc},'c_mc',{c_mc},'g_mc',{g_mc});
save('TECS_s1_1.mat','s1')
toc