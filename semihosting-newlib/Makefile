CC:=arm-none-eabi-gcc
CFLAGS:=-g -mcpu=cortex-a7
LDFLAGS:=-T main.ld --specs=nano.specs --specs=rdimon.specs
OBJCOPY:=arm-none-eabi-objcopy
QEMU:=../qemu/build/qemu-system-arm
TMUX:=tmux
TMUX_SESSION:=qemu
TMUX_MAIN_WINDOW:=qemu-main
TMUX_TERM_WINDOW:=qemu-term

all: main.bin

soc_term:
	$(MAKE) -C ../soc_term

run: main.bin soc_term
	$(TMUX) \
		new-session -d -s $(TMUX_SESSION) -n $(TMUX_MAIN_WINDOW) sh \; \
		split-window -h arm-none-eabi-gdb -q \; \
		new-window -n $(TMUX_TERM_WINDOW) ../soc_term/soc_term 54320 \; \
		split-window -h -d ../soc_term/soc_term 54321 \; \
		select-window -t $(TMUX_MAIN_WINDOW) \; \
		send-keys -t .left \
			"$(QEMU) \
				-nographic \
				-serial tcp:localhost:54320 \
				-serial tcp:localhost:54321 \
				-s \
				-S \
				-machine virt \
				-cpu cortex-a7 \
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
