#include "xparameters.h"
#include "xuartlite.h"
#include "xil_printf.h"
#include "xil_types.h"

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
    u8 SendBuffer[BUFFER_SIZE];

    Status = XUartLite_Initialize(&UartLite, XPAR_AXI_UARTLITE_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        xil_printf("UART Initialization failed\r\n");
        return XST_FAILURE;
    }

    xil_printf("UART Initialized successfully\r\n");

    while (1) {
        generate_waveform(SendBuffer, BUFFER_SIZE / 4);
        XUartLite_Send(&UartLite, SendBuffer, BUFFER_SIZE);
        for (volatile int i = 0; i < 1000000; i++);  // 딜레이
    }

    return XST_SUCCESS;
}
