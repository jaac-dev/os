BOOT_ROOT := projects/boot
BOOT_OBJ :=

ifeq ($(ARCH),x86_64-elf)

BOOT_OBJ += $(OUT)/$(BOOT_ROOT)/src/arch/x86_64/load.stage2.o

CD_BOOT_OBJ := $(BOOT_OBJ)
CD_BOOT_OBJ += $(OUT)/$(BOOT_ROOT)/src/arch/x86_64/cd.stage1.o

CD_BOOT_TARGET := $(OUT)/$(BOOT_ROOT)/cd-boot-x86_64.bin

$(CD_BOOT_OBJ): $(OUT)/%.o: %.S
	$(V)mkdir -p $(@D)
	$(V)$(CC) $(CCFLAGS) -c $^ -o $@

$(CD_BOOT_TARGET): $(CD_BOOT_OBJ)
	$(V)mkdir -p $(@D)
	$(V)$(LD) \
  		$(LDLFAGS) \
  		-nostartfiles \
  		-nolibc \
  		-T $(BOOT_ROOT)/x86_64.ld \
  		$^ \
  		-o $@

.PHONY: cd-boot
cd-boot: $(CD_BOOT_TARGET)

endif