# Project 3
Design a single-cycle MIPS processor based on the datapath from Module06

## Required instruction implementation
The developed datapath should support a subset of the MIPS ISA, which includes LW, SW, BEQ, ADD, ADDI,
SUB, J, AND, OR, and SLT instructions

## Module and port-names must NOT differ from below
module single_cycle_mips (

    input logic clk,  //clock signal
    input logic rest_n  //active-low reset signal used for initialization
);
