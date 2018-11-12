clear
close all
clc
data1 = xlsread('13.csv');
% data2 = xlsread('2.csv');
time1 = data1(:,1);
ax = data1(:,2);
ay = data1(:,3);
az = data1(:,4);
N = length(ax);
% figure(1)
% plot(time1(end-300:end), ax(end-300:end));
% hold on
% plot(time1(end-300:end), ay(end-300:end));
% hold on 
% plot(time1(end-300:end), az(end-300:end));
%% 展示运动轨迹
% 假设运动是连续的，其实运动就是连续的,
%且起始速度为0
%假设在记录数据的时间间隔内加速度没有发生变化
x = zeros(1,N);
vx = zeros(1,N);
y = zeros(1,N);
vy = zeros(1,N);
z = zeros(1,N);
vz = zeros(1,N);
for i = 2:N
    t=time1(i)-time1(i-1);
    x(i) = x(i-1) + vx(i-1)*t + 0.5*ax(i-1)*t^2;
    vx(i) = vx(i-1) + ax(i-1)*t;
    y(i) = y(i-1) + vy(i-1)*t + 0.5*ay(i-1)*t^2;
    vy(i) = vy(i-1) + ay(i-1)*t;
    z(i) = z(i-1) + vz(i-1)*t + 0.5*az(i-1)*t^2;
    vz(i) = vz(i-1) + az(i-1)*t;
end
figure
plot3(x,y,z,'b-','linewidth',1.5);
grid on
xlabel('x');
ylabel('y');
zlabel('z');
title('moving trail');
figure 
plot(vx,'b-','linewidth',1.5);
hold on
plot(vy,'g-','linewidth',1.5);
hold on
plot(vz,'r-','linewidth',1.5);
legend('vx','vy','vz');
title('speed in three directions');
figure 
plot(x,'b-','linewidth',1.5);
hold on
plot(y,'g-','linewidth',1.5);
hold on
plot(z,'r-','linewidth',1.5);
legend('x','y','z');
title('displacement in three directions');
%% 统计特性
max = mean(ax);
may = mean(ay);
maz = mean(az);
bias_ax = std(ax);
bias_ay = std(ay);
bias_az = std(az);
%概率密度估计
[pax, xi] = ksdensity(ax);
[pay ,yi]= ksdensity(ay);
[paz ,zi]= ksdensity(az);
time=1;
figure
errorbar(time,max,bias_ax,'r-s');
hold on
errorbar(time,may,bias_ay,'b-s');
hold on
errorbar(time,maz,bias_az,'g-s');
ylabel('mean and var');
legend('ax','ay','az');
title('mean and var of accelerations');


figure
plot(xi ,pax,'b-','linewidth',1.5);
hold on
plot(yi ,pay,'g-','linewidth',1.5);
hold on
plot(zi ,paz,'r-','linewidth',1.5);
legend('ax','ay','az');
xlabel('acceleration');
ylabel('PDF');
title('PDF of accelerations');










