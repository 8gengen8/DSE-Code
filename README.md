This is a document designed to guide users in using our simulation code accompanying our paper **Distributed State Estimation with Two Event-triggered Communication Strategies via Internet of Underwater Things**, which is recently accepted by IEEE IoTJ. The readers can refer to <u>Algorithm 1</u> in the paper for algorithm design details.

***

# 1. how to use the code?

## 1.1 SubCode1

        There are two files, namely *Code1_1.m* and *Code1_2.m*. *Code1_1.m* is used to generate the uniformly randomly distributed IoT nodes, and plot their topology. *Code1_2.m*. is used to generate the testing data and define the state-space model parameters. *Topology.fig* is an example figure of the generated topology.

## 1.2 SubCode2

       There is a code file named Code2. It is used to produce the groundtruth and estimated trajectories of the moving target based on the existing data produced in SubCode3. It means users should run SubCode3 first to produce the trajectory data. In, addition, *Track.fig* shows the generated trajectory.

## 1.3 SubCode3

      The performance test of different filter parameters is provided in SubCode3, including $\lambda$ in file <u>ParaLambda</u> and $\mu$ in file <u>ParaMu</u>. The two files have a similar directory structure. In  <u>ParaLambda, *TECS_based_DSE.m* is the main code used to generate plotting data. *PlotCode.m* is plotting code. *lambda.fig* and *lambda_rate.fig* are two figures.

## 1.4 SubCode4

This part is used to test the performance of our algorithm, for example, measuring the communication rate, ARMSE and energy consumption. *TECS_based_DSE.m* is the main code used to generate data. All *.....fig* are used to display the evaluation results.

# 2. Remark

## 2.1 Running the code

       If any external data is to be loaded, one should: 1) ensure that the data exists; 2) comment out the other code lines and click Run (only in this way can the data be correctly loaded).

## 2.2 State estimation data

       The users need to manually change the data name, such as TECS_S1_1, TECS_S1_2 and TECS_S1_3.

## Maintenance and technical support

       Please contact us via emails if you have any questions regarding our work. However, the simulation code is provides as it is and maintained with best effort. 
