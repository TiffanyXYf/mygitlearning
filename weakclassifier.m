%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%线性弱分类器，sign函数实现
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  [Gw, w] = weakclassifier( data ,class,w)
[M,N] = size(data);%共有N个数据,每个数据是个M维的向量
%% %对于多维数据，弱分类器需要一维一维地找

% w 不影响分类是否正确，主要是用来计算分类的错误概率

%如何确定在某一维上是最好的呢？分错的概率最小
%%
%在每一个维度上找到“最优分类器”，共有 M 维 
Gw.number = zeros(1,M);
Gw.alpha = zeros(1,M);
% 思考： 每一个维度上寻找几次比较好？？？？先确定一个参数 num_s来确定寻找步长
num_s = 10;
for i = 1:M   
    % 在每一个维度上都要寻找到一个最优的分类器，判断最优的标准是错误概率最小
    
    V1 = min(data(i,:));
    V2 = max(data(i,:));
    x = data(i,:);
    eta = (V2-V1)/num_s;
    G = zeros(num_s,N);
    
    for j = 1: num_s-1
        G(j,:) = sign(x-(V1+j*eta));
       % ==如果相等返回1，如果不相等返回0，最终得到的数值是和相互比较的数据size一致的参数
        A = (G(j,:) == class);
        error(j) = w*A';
         G_number(j) = 1; 
        if error(j) > 0.5 %如果这个分类器的错误概率很高，我们将它的error改成负数用于标记
           G(j,:) = sign((V1+j*eta)-x);
           A = (G(j,:) == class);
           error(j) = w*A';
            G_number(j) = -1; 
        else
        end
    end
    [err,index]= min(error);%找到错误概率最小的分类器
    if  G_number(index) < 0
        Gw.judge(i) =-1;% 用G.judge判断这个分类器是 sign(x-v) 还是sign (v-x);
    else
        Gw.judge(i) = 1;% G.judge = 1,这个分类器是 sign(x-v)
    end
    Gw.number(i) = V1+index*eta;%这个值确定
    Gw.alpha(i) = 0.5*log((1-abs(err))/abs(err));%得到分类器的权重，由分类正确率决定
    w = w.*exp( Gw.alpha(i)*(G(index,:)==class));
    w = w/sum(w);
    %完成了对第 i 个维度上的最优弱分类器的寻找
    %每次调用函数返回的都是一个含有 M 个分类器的参数的代表向量的分类器。
    %并且返回当前对每个数据的权值的改变情况
end
















