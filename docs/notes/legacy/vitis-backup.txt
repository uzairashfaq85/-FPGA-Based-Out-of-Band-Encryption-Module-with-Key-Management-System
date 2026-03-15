#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xil_types.h"

#define AES_DATA_BASEADDR    0x43C10000
#define AES_INV_DATA_BASEADDR    0x43C20000

unsigned int ciphertext[4];  // Store encrypted result
unsigned int decr_plaintext[4];  // Store decrypted result

static char uart_getc(void) { return (char)inbyte(); }

static int hex_to_nibble(char c)
{
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return c - 'a' + 10;
    if (c >= 'A' && c <= 'F') return c - 'A' + 10;
    return -1;
}

// Delay function for simulation
void delay_seconds(int seconds) {
    for (volatile int s = 0; s < seconds; s++) {
        for (volatile int i = 0; i < 10000000; i++);
    }
}

static u32 uart_read_u32_hex(void)
{
    u32 value = 0;
    char c;

    for (int i = 0; i < 8; i++) {
        c = uart_getc();
        while (c == '\r' || c == '\n' || c == ' ' || c == '\t') c = uart_getc();

        int nibble = hex_to_nibble(c);
        /*if (nibble < 0) {
            xil_printf("\r\n[ERROR] Invalid hex character: '%c'\r\n", c);
            return 0;
        }*/
        value = (value << 4) | (u32)nibble;
    }
    return value;
}

static void print_key_plain_one_line(const unsigned int key[8],const unsigned int pt[4])
{
    xil_printf("\r\nKEY_ECHO:");
    for (int i = 0; i < 8; i++) xil_printf("%08X", key[i]);
    xil_printf("\r\n");

    xil_printf("\r\nPLAIN_ECHO:");
    for (int i = 0; i < 4; i++) xil_printf("%08X", pt[i]);
    xil_printf("\r\n");
}

int main()
{
    unsigned int key[8];
    unsigned int pt[4];
    unsigned int ct[4];
    u32 *ptr_aes=AES_DATA_BASEADDR;
    u32 *ptr_inv_aes= AES_INV_DATA_BASEADDR;
    init_platform();

    while (1)
    {
        // ---- Ready for KEY ----
        xil_printf("RDY_KEY\n");

        for (int i = 0; i < 8; i++)
            key[i] = uart_read_u32_hex();

        xil_printf("ACK_KEY\n");

        /*// optional echo
        xil_printf("KEY_ECHO:");
        for (int i = 0; i < 8; i++) xil_printf("%08X", key[i]);
        xil_printf("\n");*/

        // ---- Ready for PLAINTEXT ----
        xil_printf("RDY_PT\n");

        for (int i = 0; i < 4; i++)
            pt[i] = uart_read_u32_hex();

        xil_printf("ACK_PT\n");

        print_key_plain_one_line(key,pt);


        ptr_aes[0]=pt[0];
        ptr_aes[1]=pt[1];
        ptr_aes[2]=pt[2];
        ptr_aes[3]=pt[3];

        ptr_aes[4]=key[0];
        ptr_aes[5]=key[1];
        ptr_aes[6]=key[2];
        ptr_aes[7]=key[3];
        ptr_aes[8]=key[4];
        ptr_aes[9]=key[5];
        ptr_aes[10]=key[6];
        ptr_aes[11]=key[7];

        ciphertext[3]=ptr_aes[12];
        ciphertext[2]=ptr_aes[13];
        ciphertext[1]=ptr_aes[14];
        ciphertext[0]=ptr_aes[15];


        xil_printf("KEY_ECHO:");
        for (int i = 0; i < 8; i++)
        {
            xil_printf("%08X", key[i]);
        }
        xil_printf("\r\n");

        
        xil_printf("Plain text:");
        for (int i = 0; i < 4; i++)
        {
            xil_printf("%08X", pt[i]);
        }
        xil_printf("\r\n");


        xil_printf("Cipher text After Encr:");
        for (int i = 0; i < 4; i++)
        {
            xil_printf("%08X", ciphertext[i]);
        }
        xil_printf("\r\n");
        

        xil_printf("RDY_CT\n");
        for (int i = 0; i < 4; i++)
            ct[i] = uart_read_u32_hex();

        xil_printf("ACK_CT\n");

        ptr_inv_aes[0]=ct[0];
        ptr_inv_aes[1]=ct[1];
        ptr_inv_aes[2]=ct[2];
        ptr_inv_aes[3]=ct[3];


        xil_printf("Plain text After Decr:");
        for (int i=7; i>=4; i--){
            xil_printf("%4x", ptr_inv_aes[i]);
        }
        xil_printf("\r\n");


    }

    cleanup_platform();
    return 0;
}
