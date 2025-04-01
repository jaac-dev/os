#
#  x86_64-elf Configuration
#

ARCH_PREFIX := x86_64-elf

CC      := $(ARCH_PREFIX)-gcc
CCFLAGS :=

LD      := $(ARCH_PREFIX)-gcc
LDFLAGS :=

QEMU := qemu-system-x86_64

GDB := $(ARCH_PREFIX)-gdb