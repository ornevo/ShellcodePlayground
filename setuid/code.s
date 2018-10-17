BITS 64

xor eax, eax
mov al, 0xd5 ; setuid syscall number
xor ebx, ebx
mov bx, 14002 ; the uid to change to
int 0x80
