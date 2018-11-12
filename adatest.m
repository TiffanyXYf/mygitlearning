function [accuracy]=adatest(s_class,data_test,class_test)
num = length(s_class);
%  a = s_class(1).alpha(1);
[M,N] = size(data_test);
G =  zeros(M,N);
for i = 1:M
    for j = 1:num
        if s_class(j).judge(i) >0
            G(i,:) = G(i,:) + s_class(j).alpha(i)*sign(data_test(i,:)-s_class(j).number(i));
        else
            G(i,:) = G(i,:) + s_class(j).alpha(i)*sign(s_class(j).number(i)-data_test(i,:));
        end 
    end
end
%循环结束之后得到一个带有权重的对于各个维度的判断
G = -sum(G);
G = sign(G);
accuracy = sum(G == class_test)/N;