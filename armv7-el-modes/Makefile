CC:=arm-none-eabi-gcc
CFLAGS:=-g -mcpu=cortex-a15
LDFLAGS:=-nostdlib -T main.ld
OBJCOPY:=arm-none-eabi-objcopy
QEMU:=qemu-system-arm
TMUX:=tmux
TMUX_SESSION:=qemu
TMUX_MAIN_WINDOW:=qemu-main

all: main.bin

run: main.bin
	$(TMUX) \
		new-session -d -s $(TMUX_SESSION) -n $(TMUX_MAIN_WINDOW) sh \; \
		split-window -h arm-none-eabi-gdb -q \; \
		send-keys -t .left \
			"$(QEMU) \
				-nographic \
				-s \
				-S \
				-machine virt \
				-cpu cortex-a15 \
				-d unimp \
				-semihosting-config enable=on,target=native \
				-m 1057 \
				-bios main.bin" \
			ENTER \; \
		send-keys -t .right \
			"target remote :1234" \
			ENTER \
			"symbol-file main.elf" \
			ENTER \
			"b _start" \
			ENTER \
			"si" \
			ENTER \
			"layout asm" \
			ENTER \
			\; \
		attach

main.bin: main.elf
	$(OBJCOPY) -O binary $< $@

main.elf: main.o
	$(CC) $(LDFLAGS) $(LOADLIBES) $(LDLIBS) $^ -o $@

clean:
	@rm -rf *.o main.elf main.bin
