clear
clc
%% parameters
theta = 0.1;                                                                                                                                                                             ;
n = 100;
m = n;
lp = 3;
r = 40000;
noi_var = 0; %AWGN var
% p2 = 0.1; % sparsity level of corrupt

tot_time = 0;
tot_error = 0;
times = 1;

for i = 1:times
    
    
    %% Gen dictionary
    A = randn(n);
    [Q,R] = qr(A);
    D0 = Q(:,1:m);
    
    %% Gen sparse code
    B = rand(m,r);
    B(B>theta) = 0;
    B(B>0) = 1;
    G = randn(m,r);
    X0 = B.*G;
    Y0 = D0*X0;
    
    
    
    %% add noise
    Y = Y0 + noi_var*randn(n,r);
    
    % %% add corruption
    % B = rand(n,m);
    % B(B>p2) = 0;
    % B(B>0) = 1;
    % S = rand(n,m);
    % S(S<1/2) = -1;
    % S(S>0) = 1;
    %l=3;
    
    %% Start Lp DL
    Num_iter = 300;
    
    last_A = zeros(m,n);
    conv = [];
    %initial
    A = randn(n);
    [A0,R] = qr(A);
    A0 = A0(1:m,:);
    A = A0;
    
    tot = 0;
    tic
    for i=1:Num_iter
        
        AY = A*Y;
        %dA = 4*AY.^(lp-1)*Y'/m;
        if(mod(lp,2)==1)
            dA = abs(AY).^(lp-1).*sign(AY)*Y'/r;
        else
            dA = AY.^(lp-1)*Y'/r;
        end
        
        [U,S,V] = svd(dA,'econ');%-12*m*p^2*A%+2*p*noi_var^2+noi_var^4
        A = U*V';
        
        res = A*D0;
        res = res(:);
        if(norm(A-last_A,'fro')/n < 1e-8)
            %         if(sum(res.^4)/l>0.99)
            break
        end
        conv = [conv sum(res.^4)/n];
        last_A = A;
    end
    tot = toc;
    error = 1-sum(res.^4)/n;
    tot_time = tot_time + tot/times;
    tot_error = tot_error + error/times;
end

semilogy(1-conv,'linewidth',2);
hold on

