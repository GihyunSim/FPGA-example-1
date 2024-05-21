#include "xparameters.h"
#include "xuartlite.h"
#include "xgpio.h"  // xgpio.h 헤더 파일 포함
#include "xil_printf.h"
#include "xil_types.h"
#include "xpseudo_asm.h"
#define BUFFER_SIZE 64

void generate_waveform(u8 *buffer, int size) {
    for (int i = 0; i < size; i++) {
        buffer[i * 4] = (i % 4 == 0) ? 1 : 0;
        buffer[i * 4 + 1] = (i % 4 == 1) ? 1 : 0;
        buffer[i * 4 + 2] = (i % 4 == 2) ? 1 : 0;
        buffer[i * 4 + 3] = (i % 4 == 3) ? 1 : 0;
    }
}

int main() {
    int Status;
    XUartLite UartLite;
    XGpio Gpio;  // XGpio 타입 선언
    u8 SendBuffer[BUFFER_SIZE];

    // Initialize UART
    Status = XUartLite_Initialize(&UartLite, XPAR_AXI_UARTLITE_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("UART Initialization failed\r\n");
        return XST_FAILURE;
    }

    // Initialize GPIO
    Status = XGpio_Initialize(&Gpio, XPAR_AXI_GPIO_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("GPIO Initialization failed\r\n");
        return XST_FAILURE;
    }

    // GPIO 채널 설정 (예: 1번 채널 출력 설정)
    XGpio_SetDataDirection(&Gpio, 1, 0x0);  // 모든 핀을 출력으로 설정

    xil_printf("UART and GPIO Initialized successfully\r\n");

    // Main loop to send data and control GPIO
    while (1) {
        // Assume SendBuffer is filled with data from Vivado configured hardware
        XUartLite_Send(&UartLite, SendBuffer, BUFFER_SIZE);

        // Example to toggle GPIO pin based on some condition
        XGpio_DiscreteWrite(&Gpio, 1, 0x1); // Set GPIO high
        for (volatile int i = 0; i < 1000000; i++);  // Delay
        XGpio_DiscreteWrite(&Gpio, 1, 0x0); // Set GPIO low
        for (volatile int i = 0; i < 1000000; i++);  // Delay
    }

    return XST_SUCCESS;
}
