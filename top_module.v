module top_module (
    input clk,
    output reg dg_out1,
    output reg dg_out2,
    output reg dg_out3,
    output reg pg_out
);

  localparam DG1_HIGH_TIME = 3;
  localparam DG1_LOW_TIME = 23.8;
  localparam DG2_DELAY = 21.3;
  localparam DG3_DELAY = 23.5;
  localparam PG_DELAY = 23.5;
  localparam PG_PULSE_WIDTH = 0.01;
  localparam CYCLE = 62.5;

  // DG Output 1 설정
  always @(posedge clk) begin
    #DG1_HIGH_TIME;
    dg_out1 <= 1;
    #DG1_LOW_TIME;
    dg_out1 <= 0;
    #DG1_HIGH_TIME;
    dg_out1 <= 1;
    #DG1_LOW_TIME;
    dg_out1 <= 0;
  end

  // DG Output 2 설정
  always @(posedge clk) begin
    #DG2_DELAY;
    dg_out2 <= 1;
    #1;
    dg_out2 <= 0;
  end

  // DG Output 3 설정
  always @(posedge clk) begin
    #DG3_DELAY;
    dg_out3 <= 1;
    #1;
    dg_out3 <= 0;
  end

  // PG Output 설정
  always @(posedge clk) begin
    #PG_DELAY;
    pg_out <= 1;
    #PG_PULSE_WIDTH;
    pg_out <= 0;
  end

endmodule
