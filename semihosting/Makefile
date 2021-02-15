CC:=arm-none-eabi-gcc
CFLAGS:=-g
LDFLAGS:=-nostdlib -T main.ld
OBJCOPY:=arm-none-eabi-objcopy
QEMU:=qemu-system-arm
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
		split-window -h -d arm-none-eabi-gdb \; \
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
			"b main" \
			ENTER \
			"c" \
			ENTER \; \
		attach

main.bin: main.elf
	$(OBJCOPY) -O binary $< $@

main.elf: start.o main.o
	$(CC) $(LDFLAGS) $(LOADLIBES) $(LDLIBS) $^ -o $@

clean:
	@rm -rf *.o main.elf main.bin
