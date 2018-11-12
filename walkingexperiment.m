clear
close all
clc
%以两个用户的数据分类  adaboost
%该算法也能实现运动模式的判断，但是，需要标签，是监督学习
data1 = xlsread('1.csv');
data2 = xlsread('2.csv');
%data3 = xlsread('4.csv');
% data4 = xlsread('4.csv');
% data5 = xlsread('5.csv');
% data6 = xlsread('6.csv');
% data7 = xlsread('7.csv');
% data8 = xlsread('8.csv');
% data9 = xlsread('9.csv');
% data10 = xlsread('10.csv');
time1 = data1(:,1);
%time2 = [data2(:,1); data3(:,1)];
time2 = data2(:,1);

class1 = ones(length(time1),1);
class2 = (-1)*ones(length(time2),1);
data1 = data1(:,2:4);
% data2 = [data2(:,2:4);data3(:,2:4)];
data2 = data2(:,2:4);
data1 = [data1'; class1'];
data2 = [data2'; class2'];
data = [data1 data2];
data = data(:,randperm(size(data,2)) );
%N1 = size(data,2);
T = [50 100 150 200];
N = [1000 2000 3000 4000 5000 6000 7000 8000];
for i=1: length(T)
%8000个作为训练
for j=1: length(N)
    [s_class] = adaboost(data(1:3,1:N(j)), data(4,1:N(j)), T(i));
    [rate(i,j)] = adatest(s_class,data(1:3,N(j)+1:end),data(end,N(j)+1:end));

% Mdl = fitensemble(data(1:4,1:N(j))',data(5,1:N(j))','AdaBoostM1',T(i),'Tree');
% disp(Mdl.TrainedWeights);
% predict_class = predict(Mdl, data(1:4,N(j)+1:end)');
% rate(i,j) = length(find(predict_class'==data(5,N(j)+1:end)))/length(data(5,N(j)+1:end));%不同的训练迭代次数（i）,不同的训练数据长度（j）
end
end
figure 
% plot(rate(:,1));
plot(rate(1,:),'bo-','linewidth',1.5,  'markersize', 5);
hold on
plot(rate(2,:),'go-','linewidth',1.5,  'markersize', 5);
hold on
plot(rate(3,:),'ro-','linewidth',1.5,  'markersize', 5);
hold on
plot(rate(4,:),'yo-','linewidth',1.5,  'markersize', 5);
legend('num-weakclassfier =10','weakclassfier =50','num-weakclassfier =100','num-weakclassfier =200');
title('testing accuracy');
ylabel('accuracy');
xlabel('training length(*1000)');



