# Requirments: A shellcode file path passed as first param (.s extension)
# NOTE: Syscall numbers (x64) at /usr/include/x86_64-linux-gnu/asm/unistd_64.h
# NOTE: Syscall numbers (x86) at /usr/include/asm/unistd_32.h
# Params: compile_shellcode.sh <path_to_assembly_file> [ optional -x86 for 32 bit. x64 by default ]

if [ -z "$1" ]; then
    echo -e "[ERROR]\tNo shellcode file path was specified."
    exit
fi

clear
echo -e "Compiling $1..."
python -c "print '='*40"

# assemble shellcode
nasm $1 -o shellcode
# nasm -felf64 $1 -o shellcode.o
# ld -s -o shellcode shellcode.o

# disassamble the result
if [ "$2" == "-x86" ]; then
    echo "((Compiling 32 bit...))"
    ndisasm -b32 ./shellcode
else
    echo "((Compiling 64 bit...))"
    ndisasm -b64 ./shellcode
fi

python -c "print '='*40"

# print hex dump
hexdump -C ./shellcode
python -c "print '='*40"

# print the shellcode for testing in C (in format char shellcode[] = "...")
sh_code=$(echo $(hexdump -vC ./shellcode | egrep -oi "^[^|]*" ) |
    python -c "x=raw_input(); print ''.join(['\\\\x' + a for a in x.split() if len(a) == 2])")
echo "char shellcode[] = \"$sh_code\";"
python -c "print '='*40"

# print the shellcode in python printing format
echo "\$(python -c 'print \"$sh_code\"')"
python -c "print '='*40"

# count null bytes in shellcode
echo "Length: $[ $(echo $sh_code | wc -c) / 4 ] characters"
echo "How many null bytes? $(echo $sh_code | egrep -c '\\x00')"
echo "How many whitespaces? $(echo $sh_code | egrep -c '[\\x09\\x0a\\x0b\\x0c\\x0d\\x20]')"
