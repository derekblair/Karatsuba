
#include "karatsuba.h"


Integer power(Integer a, Digit p)
{
    
    unsigned olen,exponent=*(in[1]->start),c,w=0,h=ABS((*in)->length),mask=0x80000000;
    unsigned* targ[2];
    targ[0]=new unsigned[exponent*h];
    targ[1]=new unsigned[exponent*h];
    bool t;
    if(exponent==1)return new Integer(*in);
    if(exponent==0)return new Integer(1);
    
    makezero(h<<1,targ[0]);
    for(w=0;!(exponent&mask);w++)exponent<<=1;
    olen=square((*in)->start,targ[0],h);
    
    if(t=((exponent<<=1)&mask)>0){
        
        makezero(olen+h,targ[1]);
        olen=mult(targ[0],targ[1],olen,h,(*in)->start);
    }
    
    for(c=1;c<31-w;c++)
    {		
        
        makezero(olen*2,targ[!t]);
        olen=ksquare(olen,targ[t],targ[!t]);  
        if((exponent<<=1)&mask){
            makezero(olen+h,targ[t]);
            olen=mult(targ[!t],targ[t],olen,h,(*in)->start);}
        else t=!t;
    }
    
    if((*in)->length<0&&((*(in[1]->start))&1))olen*=-1;
    
    delete [] targ[!t];
    
    return new Integer(targ[t],olen);
}



