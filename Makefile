include make/root.mk

all: $(CD_TARGET)

# QEMU emulation target.
.PHONY: qemu
qemu: $(CD_TARGET)
	$(V)$(QEMU) -cdrom $(CD_TARGET)

# QEMU debug emulation target.
.PHONY: qemu-d
qemu-d: $(CD_TARGET)
	$(V)$(QEMU) -s -S -cdrom $(CD_TARGET)

# GDB remote target.
.PHONY: gdb
gdb:
	$(V)$(GDB) -ex "target remote localhost:1234"