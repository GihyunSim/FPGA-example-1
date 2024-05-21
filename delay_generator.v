module delay_generator (
    input wire clk,
    input wire pulse,       // 함수발생기에서 입력된 16kHz 펄스
    output reg dg_out1,     // 지연 출력 1
    output reg dg_out2,     // 지연 출력 2
    output reg dg_out3,     // 지연 출력 3
    output reg pg_out       // 지연 출력 4
);

    reg [15:0] counter = 0;

    always @(posedge clk) begin
        if (pulse) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end

        // 초기 상태를 LOW로 설정
        if (counter == 0) begin
            dg_out1 <= 0;
            dg_out2 <= 0;
            dg_out3 <= 0;
            pg_out  <= 0;
        end

        // DG Output 1: PA, US 트리거
        if (counter == 10) begin
            dg_out1 <= 1;
        end else if (counter == 20) begin
            dg_out1 <= 0;
        end

        if (counter == 33) begin
            dg_out1 <= 1;
        end else if (counter == 43) begin
            dg_out1 <= 0;
        end

        // DG Output 2: 특정 시간에 15μs 동안 high
        if (counter == 15) begin
            dg_out2 <= 1;
        end else if (counter == 30) begin
            dg_out2 <= 0;
        end

        // DG Output 3: 특정 시간에 20μs 동안 high
        if (counter == 20) begin
            dg_out3 <= 1;
        end else if (counter == 40) begin
            dg_out3 <= 0;
        end

        // PG Output: 23.5μs일 때 한 번 반짝임
        if (counter == 23) begin
            pg_out <= 1;
        end else if (counter == 24) begin
            pg_out <= 0;
        end
    end
endmodule
