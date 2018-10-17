BITS 64

segment .text
global _start

_start:
	mov rax, 0x00000005
	mov [rbp], eax
