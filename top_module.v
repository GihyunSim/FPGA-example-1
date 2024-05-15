`timescale 1us / 1ns

module top_module (
    input wire clk,
    output reg dg_out1,
    output reg dg_out2,
    output reg dg_out3,
    output reg pg_out
);

   

    initial begin
       
        dg_out1 = 0;
        dg_out2 = 0;
        dg_out3 = 0;
        pg_out = 0;
    end
endmodule
