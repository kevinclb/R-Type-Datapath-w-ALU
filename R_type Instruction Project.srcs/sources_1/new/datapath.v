`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2020 06:39:37 PM
// Design Name: 
// Module Name: Datapath
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


module Datapath(
    input clk,
    input reset,
    output [31:0] Dout
    );
    wire [31:0] A,B,Instruction,PC_in,PC_out;
    wire [5:0] Control2;
    wire [5:0] Control1;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [3:0] ALUCntrl;
    wire N,Z,C,V,RegWrite;
    integer i;
    assign Control2=Instruction[5:0];
    assign Control1=Instruction[31:26];
    assign rs=Instruction[25:21];
    assign rt=Instruction[20:16];
    assign rd=Instruction[15:11];

    PC pc(.clk(clk),.reset(reset),.PC_in(PC_in),.PC_out(PC_out));
    PCADD add(.PC_IN(PC_out),.PC_OUT(PC_in));
    Instruction_Memory instr(.Addr(PC_out),.Inst_out(Instruction));
    Control control(.op(Control1),.func(Control2),.ALUCntl(ALUCntrl),.RegWrite(RegWrite));
    regfile32 rf(.clk(clk),.reset(reset),.D_En(RegWrite),.D_Addr(rd),.S_Addr(rs),.T_Addr(rt),.D(Dout),.S(A),.T(B));
    ALU alu(.A(A),.B(B),.ALUCntl(ALUCntrl),.ALUout(Dout),.Z(Z),.C(C),.V(V),.N(N));
    
endmodule

