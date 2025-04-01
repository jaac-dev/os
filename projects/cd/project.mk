ifeq ($(ARCH),x86_64-elf)

CD_ROOT := projects/cd

CD_TARGET := $(OUT)/$(CD_ROOT)/cd.iso

CD_FOLDER := $(OUT)/$(CD_ROOT)/fs

CD_FOLDER_BOOT := $(CD_FOLDER)/BOOT.BIN
$(CD_FOLDER_BOOT): $(CD_BOOT_TARGET)
	$(V)mkdir -p $(@D)
	$(V)cp $(CD_BOOT_TARGET) $(CD_FOLDER_BOOT)

$(CD_TARGET): $(CD_FOLDER_BOOT)
	$(V)mkdir -p $(@D)
	$(V)$(XORRISO) \
		-outdev $@ \
		-blank as_needed \
		-map $(CD_FOLDER) / \
		-volid CD \
		-boot_image any bin_path=/BOOT.BIN \
		-boot_image any load_size=2048 \
		-boot_image any boot_info_table=on \
		-boot_image any emul_type=no_emulation \
		-commit

.PHONY: cd
cd: $(CD_TARGET)

endif