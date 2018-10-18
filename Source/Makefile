boot.bin: bootloader.asm
	nasm $^ -f bin -o $@

test: boot.bin
	qemu-system-i386 -hda boot.bin
