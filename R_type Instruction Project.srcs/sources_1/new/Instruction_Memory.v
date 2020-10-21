`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2020 12:17:19 AM
// Design Name: 
// Module Name: Instruction_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Memory(
    input [31:0] Addr,
    output [31:0] Inst_out
    );
    
    reg [7:0] imem[0:4095]; //2^12 byte addresses
    
    //Read Memory Contents, 2 bit offset for alignment
    assign Inst_out = {
                       imem[{Addr[11:2],2'b0}+2'd3],
                       imem[{Addr[11:2],2'b0}+2'd2],
                       imem[{Addr[11:2],2'b0}+2'd1],
                       imem[{Addr[11:2],2'b0}+2'd0]
                       };
endmodule

