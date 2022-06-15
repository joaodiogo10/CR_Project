#include <stdlib.h>
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xtmrctr_l.h"
#include "xil_printf.h"

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

void ResetPerformanceTimer()
{
    XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
    XTmrCtr_SetLoadReg(XPAR_TMRCTR_0_BASEADDR, 0, 0x00000001);
    XTmrCtr_LoadTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
    XTmrCtr_SetControlStatusReg(XPAR_TMRCTR_0_BASEADDR, 0, 0x00000000);
}

void RestartPerformanceTimer()
{
    ResetPerformanceTimer();
    XTmrCtr_Enable(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int GetPerformanceTimer()
{
    return XTmrCtr_GetTimerCounterReg(XPAR_TMRCTR_0_BASEADDR, 0);
}

unsigned int StopAndGetPerformanceTimer()
{
    XTmrCtr_Disable(XPAR_TMRCTR_0_BASEADDR, 0);
    return GetPerformanceTimer();
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

void get_new_random_hw(unsigned int *pDst, unsigned int seed, unsigned int size)
{
    putfslx(seed, 0, FSL_DEFAULT);

    unsigned int *p;

    for (p = pDst; p < pDst + size; p++)
    {
        xil_printf("Test: %d", *p);
        getfslx(*p, 0, FSL_DEFAULT);
    }
}

int main()
{
    unsigned int seed = 0xA2B523F5;
    xil_printf("\rSeed = %08x\n", seed);
    unsigned int hw_results[RESULT_LENGTH];
    unsigned int sw_results[RESULT_LENGTH];
    unsigned int number = seed;
    unsigned int time_elapsed;

    xil_printf("\n\rGenerating numbers using software\n");
    RestartPerformanceTimer();
    for (int i = 0; i < RESULT_LENGTH; i++)
    {
        get_new_random_sw(&number);
        sw_results[i] = number;
    }
    time_elapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rSoftware number generation time: %d microseconds",
               timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));

    xil_printf("\n\rGenerating numbers using hardware\n");
    RestartPerformanceTimer();
    for (int i = 0; i < RESULT_LENGTH; i++)
    {
        hw_results[i] = Xil_In32(XPAR_LFSR_RANDOM_0_S00_AXI_BASEADDR + 0); // TODO how does this connect with the hardware?
    }
    time_elapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rHardware number generation time: %d microseconds",
               timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));

    bool equal = false;

    for (int i = 0; i < RESULT_LENGTH; i++)
    {
        equal = (sw_results[i] == hw_results[i]);
    }

    xil_printf("\n\rCheck Result: %s\n", equal ? "OK" : "ERROR");
    return 0;
}