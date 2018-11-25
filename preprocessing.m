clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%author: Cuifang Xie
%date :2018 Nov 19
%      语音预处理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 声音输入
[s1,fs1] = audioread('B.wav');%wav,fs =16000
% [s2,fs2] = audioread('敲柱子.wav');
% [s3,fs3] = audioread('youkelili2.wav');%wav,fs =16000
% [s4,fs4] = audioread('B');
% [s1,fs1] = audioread('qiao2.wav');%wav,fs =16000
% [s2,fs2] = audioread('B');
% [s1,fs1] = audioread('qiao2.wav');%wav,fs =16000
% [s2,fs2] = audioread('B');
%% 短时傅里叶变换降采样前
figure 
plot(s1);
title('signal');

win_size =512;
lap = 256;
han_win = hamming(win_size); 
nfft = win_size;
[S1, F, T] = spectrogram(s1, win_size,lap, win_size, fs1);
figure
imagesc(T, F, log10(abs(S1)))
colorbar
set(gca, 'YDir', 'normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('原始信号')

%% 时频特性不明显做一次预加重试试
% [s1] = preprocess(s1);
% win_size =128;
% lap = 64;
% han_win = hamming(win_size); 
% nfft = win_size;
% [S1, F, T] = spectrogram(s1, win_size,lap, win_size, fs1);
% figure
% imagesc(T, F, log10(abs(S1)))
% colorbar
% set(gca, 'YDir', 'normal')
% xlabel('Time (secs)')
% ylabel('Freq (Hz)')
% title('预加重后')
% hold on

FS = 12000;
%% 信号降采样
s1 = resample(s1,FS,fs1);
% s2 = resample(s2,FS,fs2);
% s3 = resample(s3,FS,fs3);
%% 对S1做短时傅里叶变换截取前
win_size =128;
lap = 64;
han_win = hamming(win_size); 
nfft = win_size;
[S1, F, T] = spectrogram(s1, win_size,lap, win_size, FS);
figure
imagesc(T, F, log10(abs(S1)))
colorbar
set(gca, 'YDir', 'normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('降采样')







% noise  = 0.001*randn(1,length(s1));
% s1 = s1+noise';
%% 做滤波和截取

N =30;flag = 1;bound = 0.001;
[dt1] = low_filter(s1,N,flag,bound);
time1 = (1:length(dt1))/FS;
% N =30;flag = 1;bound = [0.001,0.1,0.1];

% for i = 1:3
%     if i ==1
%         [dt1] = low_filter(s1,N,flag,bound(i));
%         time1 = (1:length(dt1))/FS;
%     else if i==2
%             [dt2] = low_filter(s2,N,flag,bound(i));
%             time2 = 1:length(dt2);
%         else if i==3
%                [dt3] = low_filter(s3,N,flag,bound(i));
%                time3 = 1:length(dt3);
%             end
%         end
%     end
%             
% end
%% 做短时傅里叶变换截取后

 win_size =512;
lap = 256;
han_win = hamming(win_size); 
nfft = win_size;
[S1, F, T] = spectrogram(dt1, win_size, lap,win_size, FS);
figure
imagesc(T, F, log10(abs(S1)))
colorbar
set(gca, 'YDir', 'normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('截取后')
figure 
plot(dt1);







%% 加周期性信号
% t11 = linspace(-10,10,length(dt1))';
% noise1 = 0.01*cos(2*pi*t11);
% dt1 = noise1+dt1;
% plot(1:length(dt1),noise1)
% 
% t22 = linspace(-10,10,length(dt2))';
% noise2 = 0.01*cos(2*pi*t22);
% dt2 = noise2+dt2;
% plot(1:length(dt2),noise2)
% 
% t33 = linspace(-10,10,length(dt3))';
% noise3 = 0.01*cos(2*pi*t33);
% dt3 = noise3+dt3;
% plot(1:length(dt3),noise3)
%% 截取信号后进行低通滤波（降噪）
[dt1] = low_filter(dt1,2,0);
% [dt2] = low_filter(dt2,2,0);
% [dt3] = low_filter(dt3,2,0);


%% 短时傅里叶变换降噪之后

 win_size =512;
lap = 256;
han_win = hamming(win_size); 
nfft = win_size;
[S1, F, T] = spectrogram(dt1, win_size, lap,win_size, FS);
figure
imagesc(T, F, log10(abs(S1)))
colorbar
set(gca, 'YDir', 'normal')
xlabel('Time (secs)')
ylabel('Freq (Hz)')
title('低通滤波之后')



% figure(1),clf
% hold on
%  plot(t1,s1,'r-.','LineWidth',2,'MarkerSize',10)
%  plot(t1,yt1,'b--','LineWidth',2,'MarkerSize',10)
%  plot(t1,zt1,'m- ','LineWidth',1,'MarkerSize',10)
% hold off
% figure(2),clf
% plot(dt1,'c-')


audiowrite('new_B.wav',dt1,FS);
A1 = [time1;dt1'];
A1 = A1';
csvwrite( '1.csv',A1) ;
% A2 = [time2;dt2'];
% A2 = A2';
% csvwrite( '2.csv',A2) ;
% 
% A3 = [time3;dt3'];
% A3 = A3';
% csvwrite( '3.csv',A3) ;
% 
% time4 = (1:length(s1))/fs1;
% A4 = [time4;s1'];
% A4 = A4';
% csvwrite( '4.csv',A4) ;
