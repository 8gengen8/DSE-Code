function [r,rc,rg,r_av,rc_av,rg_av]=func2(c,g,algorithm)
mc_num=size(c,1);sample_num=size(c{1},2);
sensor_num=30;node_num=size(c{1},1);
temp1=zeros(1,sample_num);
temp2=zeros(1,sample_num);
temp3=zeros(1,sample_num);
if algorithm==1
    for k=1:mc_num
        temp1=temp1+sum([c{k};2*g{k}])/(node_num+2*sensor_num);
        temp2=temp2+sum([c{k};g{k}])/(node_num+sensor_num);
        temp3=temp3+sum(g{k})/sensor_num;
    end
else
    for k=1:mc_num
        temp1=temp1+sum([c{k};g{k}])/(node_num+sensor_num);
        temp2=temp2+mean(c{k});
        temp3=temp3+sum(g{k})/sensor_num;
    end
end
r=temp1/mc_num;
rc=temp2/mc_num;
rg=temp3/mc_num;
r_av=sum(temp1)/(mc_num*sample_num);
rc_av=sum(temp2)/(mc_num*sample_num);
rg_av=sum(temp3)/(mc_num*sample_num);
r_av=round(r_av,4);rc_av=round(rc_av,4);rg_av=round(rg_av,4);
end