`timescale 1ns / 1ps

module Control(
    input [5:0] op,
    input [5:0] func,
    output reg [3:0] ALUCntl,
    output reg RegWrite
    );
    
    always@(*) begin
        if(op==6'b0) begin
            RegWrite=1'b1;
            case(func)
                6'h20: ALUCntl=4'b1010; //add
                6'h21: ALUCntl=4'b0010;//Add Unsigned
                6'h22: ALUCntl=4'b1110;//sub
                6'h23: ALUCntl=4'b0110;//sub unsigned
                6'h24: ALUCntl=4'b0000;//and
                6'h25: ALUCntl=4'b0001;//or
                6'h26: ALUCntl=4'b0011;//xor
                6'h27: ALUCntl=4'b1100;//nor
                6'h2A: ALUCntl=4'b0111;//slt
                6'h2B: ALUCntl=4'b1101;//slt unsigned

                default: ALUCntl=4'b0000;
            endcase
        end
        else begin
            RegWrite=1'b0;
            ALUCntl=4'b0000;
            end
        end
    endmodule        