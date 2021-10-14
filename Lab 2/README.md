# Lab 2 Due October 24th 11:59 p.m.
Create a 32 bit ALU that can do addition, subtraction, multiplication, and division.

## Module and Port-Names
module Au_32b (

               input logic [31:0] a,b, //operands
               input logic [1:0] ALUop, //ADD(ALUop=00), SUB(ALUop=01), Mult(ALUop=10), Div(ALUop=11)
               input logic clk, //clock signal
               input logic rst_n, //active-low reset signal user for initialization
               output logic [31:0] s, //result of add/sub
               output logic [31:0] hi, //left half of the product/remainder register for mult/div
               output logic [31:0] lo, //right half of the product/remainder register for mult/div
               ouput logic zero //zero flag
);

## Addition & Subtraction
Expand our project 1 adder to 32 bits from slide 10 of Module 5a

## Unsigned Multiplication
Using algorithm from slides 18 and 19 of Module 5a

## Unsigned Division
Using algorithm from Slides 23 and 24 of Module 5a
