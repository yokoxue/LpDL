
%% test convergence property
sys.N =4;%%# of user
sys.M = 100000;%% # of Rx antenna
sys.T = 200;%% # of pilot
sys.ch_spars =0.02;
noise_var = 0;
sys.var = noise_var;
Num_test = 1;
sumobj_l3 = zeros(1,300);
for testind = 1:1:Num_test    
    %% gen GM channel
    H_ini = Gen_sparse_ch_BG(sys);
    H_ini = H_ini.';
    H_ini_real = H_ini; %% 2N x 2M
    [meaMat_squ,~]=  qr((randn(sys.T,sys.T)+1j*randn(sys.T,sys.T)));
    meaMat_squ = meaMat_squ(1:sys.N,:);
    meaMat_squ= meaMat_squ.' ;
    meaMat_squ = meaMat_squ*diag(1 ./ sqrt(abs(diag(meaMat_squ'*meaMat_squ))));
    meaMat_squreal  = meaMat_squ;
    %% 2T x 2N
    Ztreal = meaMat_squreal* H_ini_real;
    rx_power = norm(Ztreal,'fro')^2/numel(Ztreal);
    Ytreal_unq = Ztreal + sqrt(noise_var) * (randn (size(Ztreal))+1j* randn (size(Ztreal)));
    %% 
    [ A1,~] =  qr((randn(sys.T,sys.T)+1j*randn(sys.T,sys.T)));
    [~,A_ind] = sort(diag(A1),'descend');
    A1R = A1(:,A_ind);
    A1R = A1R (:,1:sys.N);
    Y_in = Ytreal_unq;
    [A,run_time_l3,obj_l3]  = st_GPM_l3(Y_in, sys, H_est_power,meaMat_squreal, A1R);
    obj_l3 = [obj_l3,zeros(1,300-length(obj_l3))]; 
    %%
     sumobj_l3 = sumobj_l3 + obj_l3;
end
CONV_l3 = sumobj_l3/Num_test;
%% plot conv speed
termil3 = find(CONV_l3==max(CONV_l3));
CONV_l3(1,termil3:end)=max(CONV_l3);
plot(1:40,CONV_l3(1:40));
