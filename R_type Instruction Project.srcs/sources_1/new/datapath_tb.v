`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2020 01:36:43 PM
// Design Name: 
// Module Name: Datapath_tb
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


module Datapath_tb();
    reg clk;
    reg reset;
    wire [31:0] Dout;
    integer i;

    Datapath uut(.clk(clk),.reset(reset),.Dout(Dout));

    always
    #10 clk=~clk;
    
    task Dump_RegFile; begin
        $timeformat(-9,1," ns",9);
        for(i=0;i<32;i=i+1) begin
            @(posedge clk)
            $display("t=%t, rf[%0h]: %h",
            $time,i,uut.rf.regArray[i]);
        end
    end
    endtask
    
    initial begin
    clk = 0; reset = 1; #20;
        $readmemh("imem.dat",uut.instr.imem);
        $readmemh("regfile.dat",uut.rf.regArray);
        reset = 0; #220;
        
        
        Dump_RegFile;
        $finish;
       end
endmodule
