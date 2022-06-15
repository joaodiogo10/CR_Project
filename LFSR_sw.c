#include <stdio.h>

#define WORD_LENGTH 32
#define NUMBER_OF_ELEMENTS 10

void PrintDataArray(unsigned int *pData)
{
    unsigned int *p;

    xil_printf("\n\r");
    for (p = pData; p < pData + NUMBER_OF_ELEMENTS; p++)
    {
        xil_printf("%08x  ", *p);
    }
}

void get_new_random(unsigned int *number)
{
    unsigned int new_bit;
    for (int i = 0; i < WORD_LENGTH; i++)
    {
        new_bit = ((*number >> 31) ^ (*number >> 30) ^ (*number >> 29) ^ (*number >> 9)) & 0x01;
        *number = (*number >> 1) | (new_bit << 31);
    }
}

void get_new_random_sw(unsigned int *pDst, unsigned int seed)
{
    unsigned int number = seed;
    unsigned int new_bit = 0;

    unsigned int *p;
    for (p = pDst; p < pDst + NUMBER_OF_ELEMENTS; p++)
    {
        for (int i = 0; i < WORD_LENGTH; i++)
        {
            new_bit = ((number >> 31) ^ (number >> 30) ^ (number >> 29) ^ (number >> 9)) & 0x01;
            number = (number >> 1) | (new_bit << 31);
        }
        *p = number;
    }
}

int main()
{
    unsigned int seed = 0xA2B523F5;
    printf("Seed = %08x\n", seed);
    unsigned int number = seed;

    for (int i = 0; i < 10; i++)
    {
        get_new_random(&number);
        printf("Number = %08x\n", number);
    }

    unsigned int *dst;
    get_new_random_sw(dst, seed);
    PrintDataArray(dst);

    return 0;
}