Divisor_8_Bits
==============

This project is developed and produced by two student in computer science : Med Hassine Ben Taieb and Amine Haddad.

Required software : xilinx 14 or better.

In this project we modeled the architecture of an 8-bit divider.
We built the flip-flopsT and D that we used after the realization of registries and the sequencer.
The divisor_system use 3 registries one to store the dividand, one to store the divisor and one to store the ratio.
The sequencer is the main part of the project,it synchronize the action of each part of the system(UAL,Registries).
The State graph of the sequencer is in additional file, it describes the operation and steps followed to achieve a division.
UAL have only one fonction; add or substract.

All the project is developed using VHDL. It is possible to view the schematic : in xilinx tools=>schematic viewer=>technology
it is possible also to make the execution of an operation(4/2) : in xilinx simulation - simulate bihavioral model.
