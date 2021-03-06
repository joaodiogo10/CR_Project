#include <stdlib.h>
#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "fsl.h"
#include "xtmrctr_l.h"
#include "xil_printf.h"
#include "stdbool.h"

#define min(a, b)	((a < b) ? a : b)

#define WORD_LENGTH 32
#define N 4000

void PrintDataArray(unsigned int* pData, unsigned int size)
{
	unsigned int* p;

	xil_printf("\n\r");
	for (p = pData; p < pData + size; p++)
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

void get_new_random_sw(unsigned int* pDst,  unsigned int seed, unsigned int size)
{
	unsigned int state = seed;
	unsigned int newBit = 0;

	unsigned int* p;
	for(p = pDst; p < pDst + size; p++)
	{
		for (int i = 0; i < WORD_LENGTH; i++)
		{
			newBit = ((state >> 31) ^ (state >> 30) ^ (state >> 29) ^ (state >> 9)) & 0x01;
			state = (state >> 1) | (newBit << 31);
		}
		*p = state;
	}
}

void get_new_random_hw(unsigned int* pDst, unsigned int seed, unsigned int size)
{
	putfslx(seed, 0, FSL_DEFAULT);

	unsigned int* p;

	int i = 0;
	for (p = pDst; p < pDst + size; p++)
	{
		getfslx(*p, 0, FSL_DEFAULT);
		i++;
	}
}

bool checkResults(unsigned int* pData1, unsigned int* pData2, unsigned int size)
{
	unsigned int* p;

	for (p = pData1; p < pData1 + size; p++, pData2++)
	{
		if (*p != *pData2)
			return FALSE;
	}

	return TRUE;
}

int main()
{
	init_platform();
    xil_printf("\n\rSoftware Only vs. Hardware 32 bit random number generation using LFSR\n\r");

    unsigned int seed = 0xA2B523F5;

    xil_printf("\rSeed = %08x\n", seed);
    unsigned int hwResults[N];
    unsigned int swResults[N];

    memset(hwResults, 1, N * sizeof(unsigned int ));
    unsigned int state = seed;
    unsigned int timeElapsed;

    xil_printf("\n\rGenerating numbers using software\n");

    RestartPerformanceTimer();
    get_new_random_sw(swResults, state, N);
    timeElapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rSoftware number generation time: %d microseconds",
               timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
    PrintDataArray(swResults, min(8, N));
    xil_printf("\n\r");


    xil_printf("\n\rGenerating numbers using hardware\n");
    RestartPerformanceTimer();
    get_new_random_hw(hwResults, state, N);
    timeElapsed = StopAndGetPerformanceTimer();
    xil_printf("\n\rHardware number generation time: %d microseconds",
               timeElapsed / (XPAR_CPU_M_AXI_DP_FREQ_HZ / 1000000));
    PrintDataArray(hwResults, min(8, N));
    xil_printf("\n\r");

    xil_printf("\n\rCheck Result: %s\n", checkResults(swResults, hwResults, N) ? "OK" : "ERROR");

    return 0;
}
