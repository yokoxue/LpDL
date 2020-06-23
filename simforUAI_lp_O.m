function [N_error,timet] = simforUAI_l3_O(dic_size, sample_size, sparsity,var_noise,lp_order)
p = sparsity;
n = dic_size;
l = n;
Ment_num = 10;
sum_error = 0;
or = lp_order;
for mt = 1:1:Ment_num
A = randn(n);
 [Q,R] = qr(A);
 D0 = Q(:,1:l);
%  D0 = eye(n);
%  D0 = D0(:,1:l);



%tic
% for kk=1:10:200
%     for jj = 1:times
m = sample_size;
%noise_level = 0.005*kk;

B = rand(l,m);
B(B>p) = 0;
B(B>0) = 1;
G = randn(l,m);
X0 = B.*G;
Y0 = D0*X0;
rp = norm(Y0,'fro')^2/numel(Y0);
noi_var = var_noise*rp;
Y = Y0 + noi_var*randn(n,m);

%l=3;
tic
 conv = [];
Ai = rand(n);
[A0,~] = qr(Ai);
A0 = A0(:,1:l);
A = A0;
iter = 1;
errorg = 1;
error=10;
while(iter<500&&errorg>1e-10)
    error2 = error;
        AY = A'*Y;       
        dA = or*(abs((AY).^(or-1)).*sign(AY)*Y')';%AY.^(lp-1)*Y'/m;
       [U,~,V] = svd(dA,'econ');
         A = U*V';
%         A = U*sigma*V';
        res = A'*D0;
        res = res(:);
        error = 1-sum(abs(res).^4)/n;
        errorg = abs(error-error2);
        conv = [conv error];
        iter = iter+1;
end
timet = toc;
sum_error =sum_error+ error;
end
N_error = sum_error/Ment_num;
%[sum(res1.^4) sum(res2.^4)]
%         idx = ceil(kk/10);
%         pt(idx) = pt(idx) + (sum(res.^4)/n>0.95)/times;
        
%     end
% end
%toc
%plot(pt);
