`timescale 1us / 1ns

module tb_delay_generator;
  reg clk;
  wire dg_out1, dg_out2, dg_out3, pg_out;

  top_module uut (
    .clk(clk),
    .dg_out1(dg_out1),
    .dg_out2(dg_out2),
    .dg_out3(dg_out3),
    .pg_out(pg_out)
  );

  localparam CLK_PERIOD = 31.25;

  initial begin
    clk = 0;
    forever #CLK_PERIOD clk = ~clk;
  end

  initial begin
    #1000 $finish;
  end
endmodule
