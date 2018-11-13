clear
close all
clc
data1 = xlsread('1.csv');
data1 = data1(:,2:4);
N = size(data1,1);
figure
plot3(data1(:,1),data1(:,2),data1(:,3),'.');
title('origin data');
grid on
% data1 = data1';
[cidx3,cmeans3] = kmeans(data1,2);
figure 
plot3(data1(cidx3==1,1),data1(cidx3==1,2),data1(cidx3==1,3),'r.','Markersize',6)
hold on
plot3(data1(cidx3==2,1),data1(cidx3==2,2),data1(cidx3==2,3),'b.','Markersize',6)
hold on
% plot3(data1(cidx3==3,1),data1(cidx3==3,2),data1(cidx3==3,3),'g.','Markersize',6)
% hold on
% plot3(data1(cidx3==4,1),data1(cidx3==4,2),data1(cidx3==4,3),'m.','Markersize',6)
% hold on
plot3(cmeans3(:,1),cmeans3(:,2),cmeans3(:,3),'kx','Markersize',10,'Linewidth',2);
xlabel('ax');ylabel('ay');zlabel('az');
title ('k-means clustering');
%  view(0,90);

grid on
gm = gmdistribution.fit(data1,2);
idx = cluster(gm,data1);
figure
% for i = 1:N
%     if idx(i) ==1
%         plot3(data1(i,1),data1(i,2),data1(i,3),'r.');
%     else if idx(i) ==2
%             plot3(data1(i,1),data1(i,2),data1(i,3),'b.');
%             else if idx(i) ==3
%                     plot3(data1(i,1),data1(i,2),data1(i,3),'g.');
%                 else 
%                     plot3(data1(i,1),data1(i,2),data1(i,3),'m.');
%                 end
%         end
%        
%     end
%     hold on
% end


plot3(data1(idx==1,1),data1(idx==1,2),data1(idx==1,3),'r.','Markersize',6)
hold on
plot3(data1(idx==2,1),data1(idx==2,2),data1(idx==2,3),'b.','Markersize',6)
hold on
% plot3(data1(idx==3,1),data1(idx==3,2),data1(idx==3,3),'g.','Markersize',6)
% hold on
% plot3(data1(idx==4,1),data1(idx==4,2),data1(idx==4,3),'m.','Markersize',6)
% hold on
plot3(gm.mu(:,1),gm.mu(:,2),gm.mu(:,3),'kx','Markersize',10,'Linewidth',2);

% plot3(gm.mu(1,1),gm.mu(1,2),gm.mu(1,3),'ro');
% plot3(gm.mu(2,1),gm.mu(2,2),gm.mu(2,3),'bo');
% plot3(gm.mu(3,1),gm.mu(3,2),gm.mu(3,3),'go');
% plot3(gm.mu(4,1),gm.mu(4,2),gm.mu(4,3),'mo');
xlabel('ax');ylabel('ay');zlabel('az');
title ('Gmm clustering');
grid on




