This is a document designed to guide users in using the code. The paper name is **Distributed State Estimation with Two Event-triggered Communication Strategies via Internet of Underwater Things**. You can refer to <u>Algorithm 1</u> in the paper for details.

***

# 1. how to use the code?

      There are four Subcode, namely SubCode1, SubCode2, SubCode3 and SubCode4.

## 1.1 SubCode1

        There are two codes, namely *Code1_1.m* and *Code1_2.m*. The *Code1_1.m* is used to generate the randomly and uniformly distributed nodes, and plot them topology. The *Code1_2.m*. is utilized to generate the testing data and define the state-space model parameters. *Topology.fig* is the topology figure.

## 1.2 SubCode2

       There is a code named Code2. It is used to produce the actual and estimated trajectories of the moving target based on the existing data in SubCode3. Thus, you should run SubCode3 firstly to produce the trajectory data. In, addition, the *Track.fig* is the trajectory figure.

## 1.3 SubCode3

      The performance test of different filter parameters is in SubCode3, including $\lambda$ in file <u>ParaLambda</u> and $\mu$ in file <u>ParaMu</u>. The two file have similar directory structure. So, only <u>ParaLambda</u> is introduced here.

        In  <u>ParaLambda, *TECS_based_DSE.m* is the main code used to generate plotting data. *PlotCode.m* is plotting code. *lambda.fig* and *lambda_rate.fig* are two figures.

## 1.4 SubCode4

This code is used to test the performance of our algorithm, for example, communication rate, ARMSE and energy consumption. *TECS_based_DSE.m* is the main code used to generate data. All *.....fig* are used to display the result figures.

# 2. Remark

## 2.1 Run code

       If external data is to be loaded, you should: 1) Ensure the data exists; 2) comment out the other code and click Run (only in this way can the data be correctly loaded).

## 2.2 State estimation data

       You need to manually change the data name, such as TECS_S1_1, TECS_S1_2 and TECS_S1_3.

## Epilogue

       Thank you for reading this paper. If you have any questions regarding code or paper, please do not hesitate to contact us.
