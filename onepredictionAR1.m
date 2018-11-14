clear all
close all
clc
% AR(1)模型
N = 400;
z = 1*randn(1,N);
x(1) = 1;
seta = 0.791;
for i = 2:N
    x(i) = seta*x(i-1)+z(i);
end
 x = x-mean(x);
%% LMS 用于预测AR（1）模型
% 最小均方差收敛于噪声的方差，与噪声的方差大小无关
% 与理论值一致，通过训练得到的滤波器的参数与理论分析值有一定的关联。
% N_tr = 1500;
% N_te = 500;
% DE = 1;
% x_tr = zeros(DE,N_tr);
% des_tr = zeros(1,N_tr);
% x_te = zeros(DE,N_te);
% des_te = zeros(1,N_te);
% for i=1:N_tr
%     x_tr(:,i) = x(i:i+DE-1);
%     des_tr(i) = x(i+DE);
% end 
% for i=1:N_te
%     x_te(:,i) = x(i+N_tr:i+N_tr+DE-1);
%     des_te(i) = x(i+DE+N_tr);
% end
% wstep = 0.01;
% step_bias = 0.001;
% flaglearningcurve = 1;
% [learningcurve,w,bias,err]=mylms(x_tr,des_tr,x_te,des_te,wstep,step_bias,flaglearningcurve);
% Verr=mean(err.^2);
% figure
% plot(learningcurve,'Linewidth',1.5);
% xlabel('iteration time');
% ylabel('MSE');
% title ('noise variance 1');
%% 通过durbin-levinson算法的迭代思想进行求解
% 数据已经准备好了，确定迭代次数为80
h = 80;
mx = mean(x);
%初始化参数
% gama = zeros(1,h);
gama0 = 0;
gama1 = 0;
for t = 1: N
        gama0 = gama0+(x(t)-mx)*(x(t)-mx);
        
end
for t =1:N-1
    gama1 = gama1+(x(t+1)-mx)*(x(t)-mx);
end
 gama0 = (1/N)*gama0;%
 gama1 = (1/N)*gama1;
%  fai = zeros(1,h);
%  v = zeros(1,h);%v0 = gama0;但是没有标注出来
 fai(1) = gama1/gama0;
 v(1) = gama0*(1-fai(1).^2);
 gama(1) = gama1;
for i = 2:h
    gama0 = 0;
    for t = 1: N-i
        gama0 = gama0+(x(t+i)-mx)*(x(t)-mx);
    end
    gama0 = (1/N)*gama0;
    gama(i) =  gama0;
    gamat = fliplr(gama);
    fai(i) = (gama(i) -fai(1:i-1)*gamat(2:i)')/v(i-1);
    v(i) = v(i-1)*(1-fai(i).^2);
    fait = fliplr(fai);
    fai(1:end-1) = fai(1:end-1)-fai(i)*fait(2:end);
end 

figure 
plot(fai);