




segment .text
 
 global @square@12,@els@12,@le@12,@addspec@12,@subspec@12,@multsp@16,@add@20,@sub@20,@mult@20
 
  @add@20:
  push ebp
  push ebx
  push esi
  push edi
  mov esi,ecx  
  mov ebx,[esp+20]  
  mov ebp,[esp+24]  
  xor edi,edi
addloop:
  mov eax,dword [edx+4*edi]
  adc eax,dword [ebx+4*edi]
  mov dword [ebp+4*edi],eax
  inc edi
  loop addloop
  mov eax,0
  setc al
  mov ecx,dword [esp+28]
  sub ecx,esi
  jz endz
  cmp ah,al
  adlp:
  mov eax,dword [edx+4*edi]
  adc eax,0
  mov dword [ebp+4*edi],eax
  inc edi
  loop adlp
  mov eax,0
  setc al 
  endz:
  mov [ebp+4*edi],eax 
  add eax,[esp+28]
  pop edi
  pop esi
  pop ebx
  pop ebp
  ret 12
 
 @sub@20:
  push ebp
  push ebx
  push esi
  push edi
  mov esi,ecx  
  mov ebx,[esp+20]  
  mov ebp,[esp+24]  
  xor edi,edi
subloop:
  mov eax,dword [edx+4*edi]
  sbb eax,dword [ebx+4*edi]
  mov dword [ebp+4*edi],eax
  inc edi
  loop subloop
  mov eax,0
  setc al
  mov ecx,dword [esp+28]
  sub ecx,esi
  jz endsz
  cmp ah,al
  sblp:
  mov eax,dword [edx+4*edi]
  sbb eax,0
  mov dword [ebp+4*edi],eax
  inc edi
  loop sblp 
  endsz:  
  dec edi
  jz short edsuz 
  cmp dword [ebp+4*edi],0
  jnz short edsuz  
   dosz:  
   dec edi
   jz short edsuz
   cmp dword [ebp+4*edi],0
   jz short dosz
  edsuz:
  inc edi
  mov eax,edi
  pop edi
  pop esi
  pop ebx
  pop ebp
  ret 12


 @addspec@12:
  
   push esi
   push edi   
   mov edi,edx
   mov esi,dword [esp+12] 
   xor edx,edx
addsl:
  mov eax,dword [edi+4*edx]
  adc eax,dword [esi+4*edx]
  mov dword [edi+4*edx],eax
  inc edx
  loop addsl 
  jnc short endspec
 addcarry:
  adc dword [edi+4*edx],0
  inc edx
  jc short addcarry
 endspec:
 pop edi
 pop esi
 ret 4
 



  @subspec@12:
   push esi
   push edi   
   mov edi,edx
   mov esi,dword [esp+12] 
   xor edx,edx
subsl:
  mov eax,dword [edi+4*edx]
  sbb eax,dword [esi+4*edx]
  mov dword [edi+4*edx],eax
  inc edx
  loop subsl   
  jnc short endspec2
 subcarry:
  sbb dword [edi+4*edx],0
  inc edx
  jc short subcarry
 endspec2:
 pop edi
 pop esi
 ret 4


  @square@12:            
  push ebx      
  push esi      
  push edi                                            
  push ebp         
  mov ebp,edx    
  xor esi,esi                                            
  main_loopsq:                                                                      
    xor edi,edi	        
    xor ebx,ebx   
     internal_loopsq:
	   mov eax,dword [ecx+4*edi]
       mul dword [ecx+4*esi]
	   add eax,ebx
       adc edx,0                                              
       mov ebx,edx
	   mov edx,edi
       add edx,esi                                                                                                               
       add dword [ebp+4*edx],eax
	   jnc short skipsq
        addtoanssq:
         inc edx
         adc dword [ebp+4*edx],0
         jc short addtoanssq    
       skipsq:  
	   inc edi
       cmp edi,dword [esp+20]
       jnz short internal_loopsq
	mov edx,edi
    add edx,esi
	mov eax,ebx                                                                      		
    add dword [ebp+4*edx],eax
    jnc short finalskipsq
     finaladdsq:
      inc edx
      adc dword  [ebp+4*edx],0
      jc short finaladdsq
     finalskipsq:	
     inc esi
	 cmp esi,dword [esp+20]
     jnz short main_loopsq
  mov eax,esi
  shl eax,1
  mov ecx,eax
  dec ecx
  cmp dword [ebp+4*ecx],1
  sbb eax,0
  pop ebp
  pop edi
  pop esi
  pop ebx
  ret 4
  
  @els@12:
  push esi
  push edi
  mov esi,ecx 
  mov edi,edx 
  mov ecx,[esp+12] 
  cld
  xor eax,eax
  repe cmpsd
  sete al
  pop edi
  pop esi  
  ret 4
  
   @le@12:
   push esi
   push edi
   mov esi,ecx 
   mov edi,edx 
   mov ecx,[esp+12]
   xor eax,eax
   xor edx,edx
   cld
   repe cmpsd
   setc al
   sete dl
   or al,dl
   pop edi
   pop esi  
   ret 4
  
 
  @multsp@16
  push ebp
  mov ebp,dword [esp+12]
  push ebx      
  push esi      
  push edi                                              
  sub esp,4         
  mov ebx,edx    
  xor esi,esi                                            
  main_loopsq2:                                                                  
    xor edi,edi	        
    mov dword [esp],0   
     internal_loopsq2:
       mov eax,dword [ecx+4*edi]
       mul dword [ebp+4*esi]
	   add eax,dword [esp]
       adc edx,0                                              
       mov dword [esp],edx
	   mov edx,edi
       add edx,esi                                                                                                               
       add dword [ebx+4*edx],eax
	   jnc short skipsq2
        addtoanssq2:
         inc edx
         adc dword [ebx+4*edx],0
         jc short addtoanssq2    
       skipsq2:  
	   inc edi
       cmp edi,dword [esp+24]
       jnz short internal_loopsq2
	mov edx,edi
    add edx,esi
	mov eax,dword [esp]                                                                      		
    add dword [ebx+4*edx],eax
    jnc short finalskipsq2
     finaladdsq2:
      inc edx
      adc dword  [ebx+4*edx],0
      jc short finaladdsq2
     finalskipsq2:	
     inc esi
	 cmp esi,dword [esp+24]
     jnz short main_loopsq2  
  add esp,4 
  pop edi
  pop esi
  pop ebx
  pop ebp
  ret 8

 
 @mult@20
  push ebp
  mov ebp,dword [esp+16]
  push ebx      
  push esi      
  push edi                                              
  sub esp,4         
  mov ebx,edx    
  xor esi,esi                                            
  mainzlp:                                                                  
    xor edi,edi	        
    mov dword [esp],0   
     intzloop:
       mov eax,dword [ecx+4*edi]
       mul dword [ebp+4*esi]
	   add eax,dword [esp]
       adc edx,0                                              
       mov dword [esp],edx
	   mov edx,edi
       add edx,esi                                                                                                               
       add dword [ebx+4*edx],eax
	   jnc short skipqz
        addtoanszx:
         inc edx
         adc dword [ebx+4*edx],0
         jc short addtoanszx    
       skipqz:  
	   inc edi
       cmp edi,dword [esp+24]
       jnz short intzloop
	mov edx,edi
    add edx,esi
	mov eax,dword [esp]                                                                      		
    add dword [ebx+4*edx],eax
    jnc short finskippzv
     finaddszr:
      inc edx
      adc dword [ebx+4*edx],0
      jc short finaddszr
     finskippzv:	
     inc esi
	 cmp esi,dword [esp+28]
     jnz short mainzlp      
     mov eax,esi
     add eax,[esp+24]
     mov ecx,eax
     dec ecx
     cmp dword [ebx+4*ecx],1
     sbb eax,0
  add esp,4 
  pop edi
  pop esi
  pop ebx
  pop ebp
  ret 12
 
 

