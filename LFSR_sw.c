#include <stdio.h>

#define WORD_LENGTH 32

void get_new_random(unsigned int *number)
{
    unsigned int new_bit;
    for (int i = 0; i < WORD_LENGTH; i++)
    {
        new_bit = ((*number >> 31) ^ (*number >> 30) ^ (*number >> 29) ^ (*number >> 9)) & 0x01;
        *number = (*number >> 1) | (new_bit << 31);
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

    return 0;
}