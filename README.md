This is a short guide for using the accompanying simulation code for our paper **Distributed State Estimation with Two Event-triggered Communication Strategies via Internet of Underwater Things**, submitted to IEEE IoTJ. The readers can refer to <u>Algorithm 1</u> in the paper for algorithm design details.

***

# 1. how to use the code?

      There are four entrances named after "Subcode", namely SubCode1, SubCode2, SubCode3 and SubCode4.

## 1.1 SubCode1

        There are two code files, namely *Code1_1.m* and *Code1_2.m*. *Code1_1.m* is used to generate the uniformly randomly distributed nodes, and plot their topology. *Code1_2.m*. is used to generate the testing data and define the state-space model parameters. *Topology.fig* is one exaple of the generated topology figure.

## 1.2 SubCode2

       There is one code file named Code2. It is used to produce the groundtruth and estimated trajectories of the moving target based on the data provided in SubCode3. One needs to run SubCode3 firstly to produce the trajectory data. In addition, the file *Track.fig* shows the generated trajectory.

## 1.3 SubCode3

      The performance test of different filter parameters is provided in SubCode3, including $\lambda$ in file <u>ParaLambda</u> and $\mu$ in file <u>ParaMu</u>. The two files have a similar directory structure. We introduce  <u>ParaLambda</u> here as an example.

        In  <u>ParaLambda, *TECS_based_DSE.m* is the main code used to generate data plots. *PlotCode.m* contains the code for result visualization. *lambda.fig* and *lambda_rate.fig* are two generated figures.

## 1.4 SubCode4

This code file is used to test the performance of our algorithm, for example, measuring the communication rate, ARMSE and energy consumption. *TECS_based_DSE.m* is the main code used to generate data. All *.....fig* are generated to display the results.

# 2. Remark

## 2.1 Run code

       If external data is to be loaded, one should: 1) ensure that the data exists; 2) comment out the other lines and click ``Run'' (only in this way can the data be correctly loaded).

## 2.2 State estimation data

       The user needs to manually change the data name, such as TECS_S1_1, TECS_S1_2 and TECS_S1_3.

## Support & Maintenance

       Thank you for the interest in reading our paper. Please feel free to contact us for questions regarding our work (via emails). However, the repository is provided as it is and maintained with best effort. 
