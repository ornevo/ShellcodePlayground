BITS 64

global _start
jmp short t

_start:
	; write the text
	; mov rax, 1
	xor rax, rax
	inc rax ; the write syscall number

	; mov rdi, 1
	xor rdi, rdi
	inc rdi

	pop rsi

	xor rdx, rdx
	mov dl, 12
	syscall

	; exit properly
	mov al, 60
	xor rdi, rdi
	syscall

t:
	call _start
	msg db "Hey there!", 0x0a
