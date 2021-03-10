CC:=arm-none-eabi-gcc
CFLAGS:=-g -mcpu=cortex-a15
LDFLAGS:=-T main.ld --specs=nano.specs --specs=rdimon.specs
OBJCOPY:=arm-none-eabi-objcopy
QEMU:=../qemu/build/qemu-system-arm
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
				-semihosting-config enable=on,target=native,arg=yes,arg=you,arg=can,arg=even,arg=pass,arg=arguments \
				-bios main.bin" \
			ENTER \; \
		send-keys -t .right \
			"target remote :1234" \
			ENTER \
			"symbol-file main.elf" \
			ENTER \
			"layout asm" \
			ENTER \
			"b main" \
			ENTER \
			"c" \
			ENTER \; \
		attach

main.bin: main.elf
	$(OBJCOPY) -O binary $< $@

main.elf: main.o reset.o
	$(CC) $(LDFLAGS) $(LOADLIBES) $(LDLIBS) $^ -o $@

clean:
	@rm -rf *.o main.elf main.bin
