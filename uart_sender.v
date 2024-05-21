module uart_sender (
    input wire clk,
    input wire reset,
    input wire [31:0] time_value, // 'time'을 'time_value'로 변경하여 예약어 충돌 방지
    input wire dg_out1,
    input wire dg_out2,
    input wire dg_out3,
    input wire pg_out,
    output wire tx
);
    reg [7:0] data;
    reg send;
    wire ready;

    uart_tx uart_tx_inst (
        .clk(clk),
        .reset(reset),
        .data(data),
        .send(send),
        .tx(tx),
        .ready(ready)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'b0;
            send <= 0;
        end else if (ready) begin
            // 데이터 전송 로직 (예시로 time_value 값의 하위 8비트를 전송)
            data <= time_value[7:0];
            send <= 1;
        end else begin
            send <= 0;
        end
    end
endmodule
