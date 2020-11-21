# LpDL

This is an open-source implementation for our series work on  dictionary learning.


The primary work is the UAI 2020 submission "Complete Dictionary Learning via  <i>ℓ</i><sub>p</sub>-norm Maximization'', Yifei Shen∗, Ye Xue∗, Jun Zhang, Khaled B. Letaief, Vincent Lau.  [pdf](http://proceedings.mlr.press/v124/shen20a/shen20a.pdf). The main theoretical results are summarized in this work

If you find it is useful, please cite:

```
@InProceedings{pmlr-v124-shen20a,
  title = 	 {Complete Dictionary Learning via $\ell_p$-norm Maximization},
  author =       {Shen, Yifei and Xue, Ye and Zhang, Jun and Letaief, Khaled and Lau, Vincent},
  pages = 	 {280--289},
  year = 	 {2020},
  editor = 	 {Jonas Peters and David Sontag},
  volume = 	 {124},
  series = 	 {Proceedings of Machine Learning Research},
  address = 	 {Virtual},
  month = 	 {03--06 Aug},
  publisher =    {PMLR},
  pdf = 	 {http://proceedings.mlr.press/v124/shen20a/shen20a.pdf},
  url = 	 {http://proceedings.mlr.press/v124/shen20a.html}
}
```



## 1.0 Prerequisites
+ **Matlab**


+ **MNIST Dataset**
MNIST data files
File format as specified on http://yann.lecun.com/exdb/mnist/

## 2.0 Run the experiment for synthetic data
Run the Matlab files in the "Synthetic data" folder

## 3.0 Run the experiment for MNIST data
Run the Matlab files in the "lp-mnist" folder

## 4.0 Application for Blind Data Detection 
Run the code in the "L3_BlindDataDetection" folder, which provides the elementary code for algorithmic verification.
If you find this application is helpful, please cite

```
@ARTICLE{9246702,
  author={Y. {Xue} and Y. {Shen} and V. {Lau} and J. {Zhang} and K. B. {Letaief}},
  journal={IEEE Transactions on Wireless Communications}, 
  title={Blind Data Detection in Massive MIMO via ℓ3-norm Maximization over the Stiefel Manifold}, 
  year={2020},
  volume={},
  number={},
  pages={1-1},
  doi={10.1109/TWC.2020.3033699}}
```
