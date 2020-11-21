Ment = 10000;
C = 1.2;
Nl=[4,8];
orderl = [4];
Kl = [ 1 ];
delta = sqrt(0.1);
Tl=[10:10:500];
% Tl = [2^2*/(delta^2*2):10:10000];
Emp_prob =zeros(length(orderl),length(Tl));
The_prob =zeros(length(orderl),length(Tl));
for or = 1:1:length(Nl)
    
    for ti = 1:1:length(Tl)
        temp =zeros(size(Ment));        
            
            T=ceil(Tl(ti));
            order =orderl;
            k = log2(order);
            frameLength = k*T;
            N = Nl(or);
            for mi = 1:1:Ment
            %%===QAM==============
            hMod = comm.RectangularQAMModulator('ModulationOrder',order,'BitInput',true,'NormalizationMethod','Average power','AveragePower',1,'SymbolMapping','Gray');
            modData=zeros(N,T);
            data = randi([0 1],N ,frameLength  );
            for n=1:1:N
                modData(n,:) = step(hMod, data(n,:).');
            end
            meaMat_squ=modData*sqrt(1/T);%%T x nTx
            K = (1)/sqrt(log(2));
            temp(mi)=norm(meaMat_squ*meaMat_squ' -eye(N),'fro')/sqrt(N);
            end
         Emp_prob(or,ti) = sum(temp<delta)/Ment;
    end
   The_prob (or,:)= 1- 2*exp(-(delta.*sqrt(Tl)./C-sqrt(N)).^2); 
end

% deltac = log(2)*2;
The_prob (1,:)= 1- 2*exp(-(delta*log(2).*sqrt(Tl)./0.426-sqrt(4)).^2);
The_prob (2,:)= 1- 2*exp(-(delta*log(2).*sqrt(Tl)./0.464-sqrt(8)).^2);
ind1=find(The_prob(1,:)<0);
ind2=find(The_prob(2,:)<0);
The_prob(1,1:ind1(end))=zeros(1,length(1:ind1(end)));
The_prob(2,1:6)=zeros(1,length(1:6));

semilogy(Tl,(1-(Emp_prob(1,:))),Tl,(1-The_prob(1,:)),Tl,(1-(Emp_prob(2,:))),'--','LineWidth',2)
hold on 
semilogy(Tl(1:end),1-The_prob(2,1:end),'--','LineWidth',2)
ylim([10^-3 1])
% Tl = [2^2*N/(delta^2*2):10:10000];


legend('Empirical (K=4)','Theoretical (K=4)','Empirical (K=8)','Theoretical (K=8)')

Yl =ylabel ('Probability of $\frac{||\mathbf{X}\mathbf{X}^{H}-\mathbf{I}||_F}{\sqrt{K}}>\sqrt{0.1}$');

set(Yl,'Interpreter','Latex');
xlabel('T');
% set(Xl,'Interpreter','Latex');