%% SIM for UAI
l_dic_size = [50];
l_sample_size =10000;
l_sparsity = [0.01:0.01:1];
l_var_noise = [0:0.01:1];
lp_order = 3;
E_diff_spar_nvar = zeros(length(l_sparsity),length(l_var_noise));
for si = 1:1:length(l_sparsity )
    for smp = 1:1:length(l_var_noise)
[E_diff_spar_nvar(si,smp),~] = simforUAI_lp_O(l_dic_size, l_sample_size, l_sparsity(si),l_var_noise(smp),lp_order);
    end
end
save('E_diff_spar_nvar.mat','E_diff_spar_nvar')
