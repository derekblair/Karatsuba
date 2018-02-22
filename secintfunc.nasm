



segment .text

global @remain@12,@hextodec@12,@dedsp@8,@inc@4,@subza@16,@divideto@12,@dividedw@16,@mod@16,@cmpth@8,@doub@8,@deduct@12,@startdiv@4




@remain@12
  push ebx 
  push esi
  mov ebx,[esp+12]
  mov esi,ecx
  mov ecx,edx     
  xor edx,edx  
  remloop:
   dec esi
   mov eax,[ebx+4*esi]
   div ecx
   cmp esi,0
  jnz short remloop
  mov eax,edx
  pop esi
  pop ebx
  ret 4

  
 @divideto@12
  push ebx 
  push esi
  mov ebx,[esp+12]
  mov esi,ecx
  mov ecx,edx     
  xor edx,edx  
  divloop:
   dec esi
   mov eax,[ebx+4*esi]
   div ecx
   mov [ebx+4*esi],eax
   cmp esi,0
  jnz short divloop
  mov eax,edx
  pop esi
  pop ebx
  ret 4

  @dividedw@16
  push ebx 
  push esi
  push edi
  mov esi,[esp+16]
  mov edi,[esp+20]
  mov ebx,edx     
  xor edx,edx  
  divloopdw:
   dec ecx
   mov eax,[esi+4*ecx]
   div ebx
   mov [edi+4*ecx],eax
   cmp ecx,0
  jnz short divloopdw
  mov eax,edx
  pop edi
  pop esi
  pop ebx
  ret 8

  @hextodec@12
  push esi
  push edi
  push ebx
  push ebp
  mov ebp,edx 
  xor edi,edi 
  mov esi,1000000000
  mloop:
   xor edx,edx 
   mov ebx,ecx 
  htdloop:
   dec ecx
   mov eax,[ebp+4*ecx]
   div esi
   mov [ebp+4*ecx],eax
   cmp ecx,0
  jnz short htdloop
   mov ecx,ebx
   mov ebx,[esp+20]
   mov [ebx+4*edi],edx
   inc edi
   mov eax,ecx
   dec eax
   cmp dword [ebp+4*eax],1
   sbb ecx,0
   jnz mloop
   mov eax,edi
  pop ebp
  pop ebx
  pop edi
  pop esi
  ret 4

  @dedsp@8
 
 xor eax,eax
 pzr:
   cmp dword [edx+4*eax],0
   jnz short skipzr
   inc eax
   loop pzr
 
 skipzr:

 not dword [edx+4*eax]
 inc dword [edx+4*eax]
 dec ecx
 jz abort
 
 mp:
  inc eax
  not dword [edx+4*eax]
  loop mp
  abort:
  ret 


@inc@4
  xor edx,edx
  adc dword [ecx],1
  jnc short skipit  
 il:
  inc edx
  adc dword [ecx+4*edx],0
  jc short il
 skipit:
 xor eax,eax
 cmp dword [ecx+4*edx],1
 setz al
 ret



 
@subza@16:
  
  push ebx
  push esi
  push edi 
  mov edi,edx
  mov esi,[esp+16]
  mov ebx,[esp+20]
  xor edx,edx
subzloop:
  mov eax,dword [edi+4*edx]
  sbb eax,dword [esi+4*edx]
  mov dword [ebx+4*edx],eax
  inc edx
  loop subzloop
  dec edx
  jz short endz 
  cmp eax,0
  jnz short endz  
   doz:  
   dec edx
   jz short endz
   cmp dword [ebx+4*edx],0
   jz short doz
  endz:
  inc edx
  mov eax,edx 
  pop edi
  pop esi
  pop ebx
  ret 8

  @mod@16  
  mov eax,[esp+4]
  div dword [esp+8]
  mov [ecx],eax
  mov eax,edx
  ret 8

  
 
  @doub@8
  push edi   
  mov ebx,ecx
  xor edi,edi
  dloop: 
  rol byte [edx+edi],1
  inc edi
  loop dloop
  setc byte [edx+edi]
  adc edi,0
  mov eax,edi
  pop edi
  ret
  
  @deduct@12
  push ebx
  push edi
  mov ebx,[esp+12]
  xor edi,edi
  deloop
  mov al,[ebx+edi]
  sbb [edx+edi],al
  inc edi
  loop deloop 


 pop edi
 pop ebx
  ret 4

  @startdiv@4
  mov edx,0100h
  xor eax,eax
  div ecx
  ret 