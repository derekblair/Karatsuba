
#ifndef _karatsuba_h
#define _karatsuba_h

#include <stdint.h>


typedef uint32_t Digit;

typedef struct {
    
    Digit* digits;
    size_t length;
    
} Integer;


Integer power(Integer a, Digit p);


#endif
