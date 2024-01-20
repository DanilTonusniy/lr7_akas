SECTION .data
core_count dd 0 ; переменная для хранения количества ядер

format_string db 'Количество ядер: %d', 10, 0

SECTION .text
		global _start
		extern printf, exit
    
_start:
		mov eax, 158     ; номер вызываемой функции для sysconf
		mov edi, 3       ; количество доступных процессоров
		syscall          ; системный вызов
		mov [core_count], eax ; сохранение количества ядер в переменной core_count

		mov rdi, format_string
		mov rsi, [core_count]
		xor rax, rax
		call printf

		xor edi, edi
		call exit
