include make/root.mk

all: $(CD_TARGET)

# Bochs Emulation
.PHONY: bochs
bochs: $(CD_TARGET)
	$(V)bochs -q \
		'ata0: enabled=1, ioaddr1=0x1f0, ioaddr2=0x3f0, irq=14' \
		'ata0-slave: type=cdrom, path=$(CD_TARGET), status=inserted' \
		'boot: cdrom'
