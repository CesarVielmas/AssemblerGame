ASM     := nasm
ASMFLAGS:= -f elf64 -g
LD      := ld
LDFLAGS := -m elf_x86_64

main: build/main.o
	$(LD) $(LDFLAGS) -o build/main build/main.o

build/main.o: src/main.asm
	mkdir -p build
	$(ASM) $(ASMFLAGS) -o build/main.o src/main.asm

plus_one_bit: build/suma_numeros_un_bit.o
	$(LD) $(LDFLAGS) -o build/suma_numeros_un_bit build/suma_numeros_un_bit.o

build/suma_numeros_un_bit.o: src/suma_numeros_un_bit.asm
	mkdir -p build
	$(ASM) $(ASMFLAGS) -o build/suma_numeros_un_bit.o src/suma_numeros_un_bit.asm

clean:
	rm -rf build
