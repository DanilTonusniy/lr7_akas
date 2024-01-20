SECTION .data 
		msg_bmi1 db "Поддержка набора инструкций BMI1: ", 0 
		msg_bmi2 db "Поддержка набора инструкций BMI2: ", 0 
		msg_adx db "Поддержка набора инструкций ADX: ", 0 
		msg_yes db "Да", 0 
		msg_no db "Нет", 0 
		msg_bmi1_len equ $ - msg_bmi1 
		msg_bmi2_len equ $ - msg_bmi2 
    	msg_adx_len equ $ - msg_adx 
    	msg_yes_len equ $ - msg_yes 
    	msg_no_len equ $ - msg_no

SECTION .text 
    global _start 
_start:  
    	mov eax, 7	; Проверка наличия поддержки набора инструкций BMI1
    	xor ecx, ecx 
    	cpuid 
    	test ebx, 0x8 ; Проверяем бит 3 (BMI1) 
    	jz bmi1_not_supported 
    	mov eax, 4	; Вывод сообщения о поддержке набора инструкций BMI1 
    	mov ebx, 1 
    	mov ecx, msg_bmi1 
    	mov edx, msg_bmi1_len 
    	int 0x80 
    	mov eax, 4	; Вывод "Да" 
    	mov ebx, 1 
    	mov ecx, msg_yes 
    	mov edx, msg_yes_len 
    	int 0x80 
bmi1_not_supported: 
    	mov eax, 7	; Проверка наличия поддержки набора инструкций BMI2 
    	xor ecx, ecx 
    	cpuid 
    	test ebx, 0x10 ; Проверяем бит 4 (BMI2) 
    	jz bmi2_not_supported 
    	mov eax, 4	; Вывод сообщения о поддержке набора инструкций BMI2
    	mov ebx, 1 
    	mov ecx, msg_bmi2 
    	mov edx, msg_bmi2_len 
    	int 0x80 
   		mov eax, 4	; Вывод "Да" 
    	mov ebx, 1 
    	mov ecx, msg_yes 
    	mov edx, msg_yes_len 
    	int 0x80 
bmi2_not_supported: 
    	mov eax, 7	; Проверка наличия поддержки набора инструкций ADX 
    	xor ecx, ecx 
    	cpuid 
    	test ebx, 0x20 ; Проверяем бит 5 (ADX) 
    	jz adx_not_supported  
    	mov eax, 4	; Вывод сообщения о поддержке набора инструкций ADX
    	mov ebx, 1 
    	mov ecx, msg_adx 
    	mov edx, msg_adx_len 
    	int 0x80 
    	mov eax, 4	; Вывод "Да"
    	mov ebx, 1 
    	mov ecx, msg_yes 
    	mov edx, msg_yes_len 
    	int 0x80 
adx_not_supported: 
    	mov eax, 4	; Вывод "Нет" для всех неподдерживаемых наборов инструкций
    	mov ebx, 1 
    	mov ecx, msg_bmi1	; Вывод "Нет" для набора инструкций BMI1 
    	mov edx, msg_bmi1_len 
    	int 0x80 
    	mov ecx, msg_bmi2	; Вывод "Нет" для набора инструкций BMI2 
   	 	mov edx, msg_bmi2_len 
   		int 0x80 
    	mov ecx, msg_adx	; Вывод "Нет" для набора инструкций ADX 
    	mov edx, msg_adx_len 
    	int 0x80 
exit: 
    	mov eax, 1 
    	xor ebx, ebx 
    	int 0x80
