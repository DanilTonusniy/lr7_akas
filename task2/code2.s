SECTION .data
		msg_rnd db "Аппаратная генерация случайных чисел: ", 0
		msg_aes db "Аппаратная поддержка AES: ", 0
		msg_sha db "Аппаратная поддержка SHA: ", 0
		msg_yes db "Да", 0
		msg_no db "Нет", 0

SECTION .text
	global _start

_start:
		mov eax, 1	; Проверка наличия аппаратной генерации случайных чисел
		cpuid
		test ecx, 0x40000000 ; Проверяем бит 30 (RDRAND)
		jz rnd_not_supported

		mov eax, 4	; Вывод сообщения об аппаратной генерации случайных чисел
		mov ebx, 1
		mov ecx, msg_rnd
		mov edx, msg_rnd_len
		int 0x80

		mov eax, 4	; Вывод "Да"
		mov ebx, 1
		mov ecx, msg_yes
		mov edx, msg_yes_len
		int 0x80

rnd_not_supported:
		mov eax, 1	; Проверка наличия аппаратной поддержки AES
		cpuid
		test ecx, 0x2000000 ; Проверяем бит 25 (AES)
		jz aes_not_supported

		mov eax, 4	; Вывод сообщения об аппаратной поддержке AES
    	mov ebx, 1
    	mov ecx, msg_aes
   	 	mov edx, msg_aes_len
   	 	int 0x80

    	mov eax, 4	; Вывод "Да"
    	mov ebx, 1
    	mov ecx, msg_yes
    	mov edx, msg_yes_len
    	int 0x80

aes_not_supported:
    	mov eax, 7	; Проверка наличия аппаратной поддержки SHA
    	xor ecx, ecx
    	cpuid
    	test ebx, 0x200 ; Проверяем бит 9 (SHA)
    	jz sha_not_supported

		mov eax, 4	; Вывод сообщения об аппаратной поддержке SHA
		mov ebx, 1
		mov ecx, msg_sha
		mov edx, msg_sha_len
		int 0x80

		mov eax, 4	; Вывод "Да"
		mov ebx, 1
		mov ecx, msg_yes
		mov edx, msg_yes_len
		int 0x80

sha_not_supported:

    	mov eax, 4	; Вывод "Нет" для всех неподдерживаемых функций
    	mov ebx, 1
    	mov ecx, msg_rnd	; Вывод "Нет" для аппаратной генерации случайных чисел
    	mov edx, msg_rnd_len
    	int 0x80
    	mov ecx, msg_aes	; Вывод "Нет" для аппаратной поддержки AES
    	mov edx, msg_aes_len
    	int 0x80
    	mov ecx, msg_sha	; Вывод "Нет" для аппаратной поддержки SHA
    	mov edx, msg_sha_len
    	int 0x80

exit:
   	 	mov eax, 1
    	xor ebx, ebx
    	int 0x80

SECTION .data
    	msg_rnd_len equ $ - msg_rnd
    	msg_aes_len equ $ - msg_aes
    	msg_sha_len equ $ - msg_sha
    	msg_yes_len equ $ - msg_yes
    	msg_no_len equ $ - msg_no
