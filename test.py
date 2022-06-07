

def main():
    start_state = 0xA2B523F5
    
    lfsr = start_state
    number = 0
    period = 0

    total = 0
    while True:
        #taps: 31 30 29 9 
        bit = ((lfsr >> 31) ^ (lfsr >> 30) ^ (lfsr >> 29) ^ (lfsr >> 9)) & 1
        lfsr = (lfsr >> 1) | (bit << 31)
        period += 1
        number = number >> 1 | (bit << 31)

        
        if (period == 32):
            print(hex(number))
            period = 0
            total += 1
            if(total == 100):
                break

main()