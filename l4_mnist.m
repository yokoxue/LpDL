% clear
% clc
% p = 0.1;
n = 400;
l = 400;
lp = 4;
num_b = 5;
[imgs, labels] = readMNIST('train-images.idx3-ubyte','train-labels.idx1-ubyte',50000,0);
clc
imgs_f = reshape(imgs, [400,50000]);
img_mean = mean(imgs_f,2);
img_var = var(imgs_f,0,2);
imgs_f = (imgs_f - img_mean);
Y = imgs_f(:,1:50000);

tic
T = 50;
conv = [];
A = randn(n);
[A0,R] = qr(A);
A0 = A0(1:l,:);
A = A0;
sigma = [eye(l) zeros(l,n-l)];
A = A0/norm(A0);
last_A = zeros(l,n);
for i=1:T
        AY = A*Y;
        dA = lp*abs(AY).^(lp-1).*sign(AY)*Y';%abs(AY).^(lp-1).*sign(AY)*Y';%AY.^(lp-1)*Y';
        [U,S,V] = svd(dA);
        A = U*sigma*V';
        if(norm(A-last_A,'fro')/sqrt(n*l) < 1e-6)
            break
        end
        last_A = A;
end
toc

AY = A*imgs_f;
whole_basis = [];
for ii = 1:10
    tmp_img = [];
    for jj = 1:4
        rec_Y = AY(:,(ii-1)*20+jj);
        tmp = sort(abs(rec_Y),'descend');
        tmp = tmp(num_b);
        rec_Y(abs(rec_Y)<tmp)=0;
        img_exp = A'*rec_Y;
        img_exp = (img_exp + img_mean)*255;
        img_exp = reshape(img_exp,[20,20]);
        img_exp = uint8(img_exp);
        tmp_img = [tmp_img;img_exp];
    end
    whole_basis = [whole_basis tmp_img];

end
imshow(whole_basis)


% %[sum(sum((A*Y)>0.01)) sum(sum((D0'*Y)>0.01))]
% res1 = A*Y;
% res1 = res1(:);
% res2 = D0'*Y;
% res2 = res2(:);
% %[sum(res1.^4) sum(res2.^4)]
% %         idx = ceil(kk/10);
% %         pt(idx) = pt(idx) + (sum(res.^4)/n>0.95)/times;
%         
% %     end
% % end
% %toc
% %plot(pt);




