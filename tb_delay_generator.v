`timescale 1us / 1ns

module tb_delay_generator;
    reg clk;
    wire dg_out1, dg_out2, dg_out3, pg_out;

    // Top 모듈 인스턴스 생성
    top_module uut (
        .clk(clk),
        .dg_out1(dg_out1),
        .dg_out2(dg_out2),
        .dg_out3(dg_out3),
        .pg_out(pg_out)
    );

    // 클럭 생성 (62.5us 주기, 50% duty cycle)
    initial begin
        clk = 0;
        forever begin
            clk = 1;
            #31.25;
            clk = 0;
            #31.25;
        end
    end

    // DG Output 1 설정 (초반에 3us 동안 high, 이후 26.8us 시점에 3us 동안 high)
    always begin
        force uut.dg_out1 = 1; #3 force uut.dg_out1 = 0;
        #23.8;
        force uut.dg_out1 = 1; #3 force uut.dg_out1 = 0;
        #32.7;  // 62.5 - (3 + 23.8 + 3) = 32.7 추가 딜레이로 다음 주기 시작
    end

    // DG Output 2 설정 (21.3us 후 ON)
    always begin
        #21.3;
        force uut.dg_out2 = 1; #1 force uut.dg_out2 = 0;
        #40.2;  // 62.5 - 21.3 - 1 = 40.2 추가 딜레이로 다음 주기 시작
    end

    // DG Output 3 설정 (23.5us 후 ON)
    always begin
        #23.5;
        force uut.dg_out3 = 1; #1 force uut.dg_out3 = 0;
        #38.0;  // 62.5 - 23.5 - 1 = 38.0 추가 딜레이로 다음 주기 시작
    end

    // PG Output 설정 (23.5us에 임펄스)
    always begin
        #23.5;
        force uut.pg_out = 1; #0.01 force uut.pg_out = 0;
        #38.99;  // 62.5 - 23.5 - 0.01 = 38.99 추가 딜레이로 다음 주기 시작
    end

    // 시뮬레이션 종료 시간 설정
    initial begin
        #1000 $finish;  // 1000us 동안 시뮬레이션 실행
    end

    // 시뮬레이션 모니터링
    initial begin
        $monitor("At time %t, clk = %b, dg_out1 = %b, dg_out2 = %b, dg_out3 = %b, pg_out = %b", $time, clk, dg_out1, dg_out2, dg_out3, pg_out);
    end
endmodule
