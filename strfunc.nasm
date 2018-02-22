

segment .data
  
hextable dw "00","01","02","03","04","05","06","07","08","09","0A","0B","0C","0D","0E","0F","10","11","12","13","14","15","16","17","18","19","1A","1B","1C","1D","1E","1F",\
            "20","21","22","23","24","25","26","27","28","29","2A","2B","2C","2D","2E","2F","30","31","32","33","34","35","36","37","38","39","3A","3B","3C","3D","3E","3F",\
            "40","41","42","43","44","45","46","47","48","49","4A","4B","4C","4D","4E","4F","50","51","52","53","54","55","56","57","58","59","5A","5B","5C","5D","5E","5F",\
            "60","61","62","63","64","65","66","67","68","69","6A","6B","6C","6D","6E","6F","70","71","72","73","74","75","76","77","78","79","7A","7B","7C","7D","7E","7F",\
            "80","81","82","83","84","85","86","87","88","89","8A","8B","8C","8D","8E","8F","90","91","92","93","94","95","96","97","98","99","9A","9B","9C","9D","9E","9F",\
            "A0","A1","A2","A3","A4","A5","A6","A7","A8","A9","AA","AB","AC","AD","AE","AF","B0","B1","B2","B3","B4","B5","B6","B7","B8","B9","BA","BB","BC","BD","BE","BF",\
            "C0","C1","C2","C3","C4","C5","C6","C7","C8","C9","CA","CB","CC","CD","CE","CF","D0","D1","D2","D3","D4","D5","D6","D7","D8","D9","DA","DB","DC","DD","DE","DF",\
            "E0","E1","E2","E3","E4","E5","E6","E7","E8","E9","EA","EB","EC","ED","EE","EF","F0","F1","F2","F3","F4","F5","F6","F7","F8","F9","FA","FB","FC","FD","FE","FF"

segment .text
  
  global @sl@4,@valof@4,@sc@8,@makezero@8,@printhex@8,@printhexz@8,@mov@12,@invdigit@4,@indexof@8,@lastindexof@8,@outcut@8,@movb@12,@makezerob@8
  
  @sl@4:
  mov edx,edi
  mov edi,ecx
  mov ecx,0ffffffffh
  xor eax,eax
  cld
  repnz scasb
  mov eax,ecx            
  not eax
  dec eax
  mov edi,edx
  ret

  @valof@4:
	xor eax,eax
	xor edx,edx
    convloop:
	shl eax,4
	mov dl,byte [ecx]
    sub dl,'0'
	cmp byte [ecx],'A' 
	 jl short first
	 sub dl,'A'-'0'-10
	 first:
	 add eax,edx
	 inc ecx
	 cmp byte [ecx],0
	 jne short convloop
    ret


  @sc@8:
	  xor eax,eax
	  dec ecx
	  dec edx
	  cloop:
	  inc ecx
	  inc edx
	  mov byte al,[ecx]
	  test byte [edx],al
	  je equal
	  cmp byte al,[edx]
      je short cloop
	   mov edx,0
	   mov eax,1
	   setc dl  
	   shl dl,1          
	   sub eax,edx
      equal:
  ret

  @makezero@8
  push edi
  mov edi,edx
  xor eax,eax
  cld
  rep stosd
  pop edi
  ret
  
  @makezerob@8
  push edi
  mov edi,edx
  xor eax,eax
  cld
  rep stosb
  pop edi
  ret


  @printhex@8 
  mov eax,edx
  movzx edx,al
  mov dx,[hextable+2*edx]
  mov [ecx+6],dx
  movzx edx,ah
  mov dx,[hextable+2*edx]
  mov [ecx+4],dx
  shr eax,16
  movzx edx,al
  mov dx,[hextable+2*edx]
  mov [ecx+2],dx
  movzx edx,ah
  mov dx,[hextable+2*edx]
  mov [ecx],dx
  ret

  @printhexz@8
  
  mov eax,edx
  movzx edx,al
  mov dx,[hextable+2*edx]
  mov [ecx+6],dx
  movzx edx,ah
  mov dx,[hextable+2*edx]
  mov [ecx+4],dx
  shr eax,16
  movzx edx,al
  mov dx,[hextable+2*edx]
  mov [ecx+2],dx
  movzx edx,ah
  mov dx,[hextable+2*edx]
  mov [ecx],dx  
  mov eax,ecx
  mov ecx,7
  chop:
   cmp byte [eax],'0'
   jnz endchop
   
   mov edx,[eax+1]
   mov [eax],edx
   mov edx,[eax+4]
   mov [eax+3],edx
   mov byte [eax+7],0
  loop chop
  endchop:

  ret

  @mov@12
  push edi
  push esi
  mov edi,edx
  mov esi,dword [esp+12]
  cld
  rep movsd
  pop esi
  pop edi
  ret 4
  
  @movb@12
  push edi
  push esi
  mov edi,edx
  mov esi,dword [esp+12]
  cld
  rep movsb
  pop esi
  pop edi
  ret 4

  @invdigit@4
  xor eax,eax
  mov edx,1
  inc ecx
  div ecx
  ret

  @indexof@8
    mov eax,ecx
  tst:
    
	cmp byte [eax],dl
	jz short end
    inc eax
	cmp byte [eax],0
	jz short notfound    
    jmp short tst
  notfound:
     mov eax,-1
	 ret
  end:
    sub eax,ecx
    ret

	@lastindexof@8:
	mov eax,ecx
	rpl:
	inc eax
	cmp byte [eax],0	
    jnz short rpl
	
	tsd:
    dec eax
	cmp byte [eax],dl
	jz short ed
    cmp eax,ecx
	jz short nfound    
    jmp short tsd
	nfound:
     mov eax,-1
	 ret
  ed:
    sub eax,ecx

    ret

    
@outcut@8:
  push ebx
  xor ebx,ebx
  xor eax,eax
  mloop:
  cmp byte [ecx],'('
  setz bl
  add eax,ebx
  cmp byte [ecx],')'
  setz bl
  sub eax,ebx
  cmp byte [ecx],dl
  setnz bl
  or ebx,eax
  jz short found
  inc ecx
  cmp byte [ecx],0
  jnz short mloop
  found:  
  mov eax,ecx
  pop ebx
  ret

    
    
	
