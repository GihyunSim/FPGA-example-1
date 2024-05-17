clc;
clear;

% UART 설정
serialObj = serialport("COM6", 9600);
configureTerminator(serialObj, "LF");
flush(serialObj);

% 데이터 수신 및 시각화
disp("데이터 수신 시작...");
figure;
hold on;

channel1_data = [];
channel2_data = [];
channel3_data = [];
channel4_data = [];

while true
    data = readline(serialObj);
    disp(['Received Data: ', data]);

    % 수신된 데이터를 파싱하여 각 채널의 값으로 분리
    parsedData = str2double(strsplit(data, ' '));
    
    % 데이터가 유효한지 확인
    if length(parsedData) >= 4
        channel1_data(end+1) = parsedData(1);
        channel2_data(end+1) = parsedData(2);
        channel3_data(end+1) = parsedData(3);
        channel4_data(end+1) = parsedData(4);
        
        % 그래프 업데이트
        plot(channel1_data, 'r');
        plot(channel2_data, 'g');
        plot(channel3_data, 'b');
        plot(channel4_data, 'k');
        drawnow;
    end
end
