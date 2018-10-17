segment .data
	msg db "Hey there!", 0x0a

segment .text
global _start

_start:
	; write the text
	mov rax, 1 ; the write syscall number
	mov rdi, 1
	mov rsi, msg
	mov rdx, 12
	syscall

	; exit properly
	mov rax, 60
	xor rdi, rdi
	syscall
