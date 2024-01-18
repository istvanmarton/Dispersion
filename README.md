# Dispersion
This repository accompanies the publication

> I. Márton, L. Sarkadi, ["Study of the effect of higher-order dispersions on photoionisation induced by ultrafast laser pulses applying a classical theoretical method", Scientific Reports, **12**, 13841 2022](https://www.nature.com/articles/s41598-022-18034-w). 

There are two independent directories:

- `1bit2out` contains functions for heuristic optimization of the computation of the one-bit classical bound *L1bit* for a correlation Bell-type inequality defined by an $m\otimes n$ integer matrix *A*. 

- `generic` contains functions for a branch-and-bound optimization of the so-called Lk norm, which is the classical bound augmented by *log<sub>2 </sub>k* bits of communication of a bipartite Bell-type inequality. For *k=2* we have the classical one-bit bound. Note that the Bell-type coefficients must be given as integers, the setup can have an arbitrary number of outcomes, and the optimization gives the exact value of the Lk norm.
