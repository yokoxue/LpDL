%%
function Ang_H=Gen_sparse_ch_BG(sys)
M=sys.M;
N=sys.N;
B = rand(M,N);
B(B>sys.ch_spars) = 0;
B(B>0) = 1;
G =1/sqrt(2)*( randn(M,N)+1j*randn(M,N));
Ang_H= B.*G;
