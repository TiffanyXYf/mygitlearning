function [dt] = low_filter(xt,N,flag,bound)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%若flag = 1做低通滤波和信号的截取
%若flag=0 做简单的低通滤波
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yt = zeros(size(xt));
if flag
    %做滤波的同时改变一下幅度之类，为了保留信号的幅度
for i=1:length(xt)-N
    yt(i)= sum(xt(i:i+N).^2*100);
end
zt = zeros(size(yt));
zt = (yt>bound);
dt = xt(yt>bound);

else
    %做简单的低通滤波
    dt = zeros(size(xt));
    for i=1:length(xt)-N
         dt(i)= sum(xt(i:i+N));
    end
end

end