# NSMtoKNN

This code is the supplementary material for the paper

```
@article{maddalena2020nsm,
  title={NSM Converges to a k-NN Regressor Under Loose Lipschitz Estimates},
  author={Maddalena, E. T. and Jones, C. N.},
  journal={IEEE Control Systems Letters},
  volume={4},
  number={4},
  pages={880--885},
  year={2020},
  publisher={IEEE}
}
```

## Summary :books:

Nonlinear Set Membership (NSM) models are non-parametric regressors built based on a Lipschitz constant estimate of the data-generating process. Estimating such constant with precision can be challenging in many real-world situations, and practitioners can be tempted to use loose estimates instead. 

In this paper we show how NSM converges to a Nearest Neighbor map, a simple reproduction of the closest data-point value, under loose Lipschitz estimates. The repository contains two MATLAB examples that illustrate this convergence process. 


![alt text](https://github.com/emilioMaddalena/NSMtoKNN/blob/master/pic/coolSurface.png)

This picture shows the NSM ceiling and floor functions in a 3D scenario. Data are plotted in white.
