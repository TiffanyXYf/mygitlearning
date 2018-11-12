function [s_class] = adaboost(data, class, num)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% adaboost classifier
% input:  data, class, 
%         num: the number of weakclassifier
% output: s_class: Classification result 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M,N] = size(data);%共有N个数据,每个数据是个M维的向量
%初始化数据权重
w = (1/N)*ones(1,N);
for i = 1:num% train num 个弱分类器
    [G(i), w] = weakclassifier( data ,class,w);
    % 利用 w 训练一个弱分类器
    %计算弱分类器的错误率
    %为该弱分类器计算权重
    %更新各个数据的权重 w
end
s_class = G;
%最后得到一个强分类器
