`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2020 12:21:51 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0]ALUCntl,
    output reg [31:0]ALUout,
    output Z,
    output reg C,
    output reg V,
    output reg N
    );
    
reg signed[31:0] A_s,B_s;
assign Z = (ALUout ==32'b0) ? 1'b1 : 1'b0;
always@(*) begin
	A_s=A;
	B_s=B;
	case(ALUCntl)
	4'b0000:begin//And
		{V,C,ALUout}={2'bx,(A&B)};
		N=ALUout[31];
		end
	4'b0001:begin//Or
	   {V,C,ALUout}={2'bx,(A|B)};
	   N=ALUout[31];
	   end
	4'b0011:begin//Xor
	   {V,C,ALUout}={2'bx,(A^B)};
	   N=ALUout[31];
	   end
	4'b0010:begin//Add Unsigned
	   {C,ALUout} = A+B;
	   V=C;
	   N=1'b0;
	   end
	4'b0110:begin//Subtract Unsigned
	   {C,ALUout} = A-B;
	   V=1'bx;
	   N=ALUout[31];
	   end
	4'b1100:begin//Nor
       {V,C,ALUout}={2'bx,~(A|B)};
	   N=ALUout[31];
	   end
	4'b0111:begin//SLT
       ALUout = (A_s<B_s) ? {31'b0+1'b1} : 32'b0;
       C=1'bx;
	   V=1'bx;
	   N=0; 
	   end
	4'b1101:begin//SLT Unsigned
	   ALUout=(A<B) ? {31'b0+1'b1} :32'b0;
	   C=1'bx;
	   V=1'bx;
	   N=0;
	   end
	4'b1010:begin//Add
		{C, ALUout} = A_s+B_s;
		if((A_s[31] & B_s[31] & ~ALUout[31]) || (~A_s[31] & ~B[31] & ALUout[31]))
			V=1'b1;
		else
			V=1'b0;
		N=ALUout[31];
	   end
	4'b1110:begin//Subtract
		{C, ALUout} = A_s-B_s;
		if((A_s[31] & B_s[31] & ~ALUout[31]) || (~A_s[31] & ~B[31] & ALUout[31]))
			V=1'b1;
		else
			V=1'b0;
		N=ALUout[31];
	   end
	   default: begin
	       {C,V,N}=3'bx;
	       ALUout=32'bx;
	       end
    endcase
    end
endmodule
