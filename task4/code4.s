SECTION .data 
    	sse_msg db "SSE is supported", 0xA, 0 
    	avx_msg db "AVX is supported", 0xA, 0 

SECTION .bss 
    	buffer resb 128 

SECTION .text 
    	global _start 

_start: 
    	mov eax, 1	; Проверка поддержки SSE
    	cpuid 
    	test edx, 1 << 25 ; Проверка SSE бита 
    	jz .check_avx ; Переход к AVX, если нет поддержки SSE
    	mov ecx, sse_msg 
    	call print_message ; Вывод сообщения о поддержке SSE 

.check_avx: 
    	mov eax, 1	; Проверка поддержки AVX 
    	cpuid
    	test ecx, 1 << 28 ; Проверяем AVX бит (ECX[28]) 
    	jz .exit ; Если AVX не поддерживается, выходим 
    	mov ecx, avx_msg 
    	call print_message ; Вывод сообщения о поддержке AVX 

.exit: 
    	mov eax, 60 ; Вызов системного вызова exit 
    	xor edi, edi ; Код выхода 0 
    	syscall 

print_message:	; Подпрограмма для вывода сообщений 
    	mov eax, 1
    	mov edi, 1
    	mov rsi, rcx 
    	xor rdx, rdx
.find_length: 
    	cmp byte [rcx + rdx], 0 
    	je .done_counting 
    	inc rdx 
    	jmp .find_length 
.done_counting:
    	syscall
    	ret
