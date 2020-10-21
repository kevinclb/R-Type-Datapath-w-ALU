`timescale 1ns / 1ps

module PCADD(
    input [31:0] PC_IN,
    output [31:0] PC_OUT
    );

    assign PC_OUT = PC_IN+4;


endmodule