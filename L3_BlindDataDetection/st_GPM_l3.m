function[ A, run_time,obj] = st_GPM_l3(Yt, sys, H_est_power,D0,A1)
% GPM for Maximizing L3 over st , code by Ye XUE, Sally 2019 Nov HKUST

%% initial
tic
A = A1;
%  A = Real_decomp_mat(A);
%  A =   [ real(A) -imag(A); imag(A) real(A)];
Y_in = Yt;
error = 1;
errorgap = 2;
iter = 1;
disp('Starting l3 ST')
tic
obj = [];
lambda_n=[];
convm = [];
convmr = zeros(50,1);
while (errorgap>1e-6&&iter<100)
    error1 = error;
    phase=1./(abs(A' * Y_in)).*(A' * Y_in) ;
    phase (find(isnan(phase)))=0;
    dA = (3 * abs(A'* Y_in).^2 .* phase  * Y_in')';
    %
    
%      A = polar_dcomp(dA);
%       [U, S, V] = svd(dA);
%       St = [eye(min(size(S))) zeros(min(size(S)), (max(size(S))-min(size(S))))];
%       A = U *St'* V';
      [U,S,V]= svd(dA,'econ');
      lambda_n = [lambda_n,min(diag(S))];
      A = U * V';
      error = sum(sum((abs(A' * Y_in)).^3))/(3/4*sqrt(pi)*sys.M*sys.N*(sys.ch_spars*(sys.var+1)^(3/2)-...
          sys.ch_spars*sys.var^(3/2)+3*sys.var^(3/2)));
      errorgap = abs(error1-error);
      res = A'*D0;
      convm =[convm 1-sum(abs(res(:)).^4)/(sys.N)];
      obj  = [obj error];
      iter = iter + 1;
    
end
obj;
run_time = toc;
