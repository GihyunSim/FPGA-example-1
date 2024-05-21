`timescale 1 ps / 1 ps

module uart_wrapper
   (reset,
    sys_clock,
    usb_uart_rxd,
    usb_uart_txd);
  input reset;
  input sys_clock;
  input usb_uart_rxd;
  output usb_uart_txd;

  wire reset;
  wire sys_clock;
  wire usb_uart_rxd;
  wire usb_uart_txd;

  uart_sender uart_i
       (.reset(reset),
        .clk(sys_clock),
        .time_value(32'd0),  // 'time'을 'time_value'로 변경
        .dg_out1(1'b0), // 예시로 고정된 출력 값을 설정합니다. 실제 사용 시 변경 필요.
        .dg_out2(1'b0),
        .dg_out3(1'b0),
        .pg_out(1'b0),
        .tx(usb_uart_txd));
        // 필요하다면 oscillator 모듈을 인스턴스화합니다.
  oscillator osc_inst (
        // 필요한 포트 연결
  );
endmodule
