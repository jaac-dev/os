    .file "cd.stage1.S"
    .code16

    .text
    .globl _start
# Initial Entrypoint
_start:
    jmp $0x0, $next

# Boot Information Table
    .org 8
bi_pvd:
    .long 0
bi_file:
    .long 0
bi_length:
    .long 0
bi_checksum:
    .long 0
bi_reserved:
    .space (10 * 4)

# Main Entrypoint
next:
    cli

    xorl %eax, %eax

    movw %ax, %ds

    movw %ax, %ss
    movw $0x7C00, %sp

    # Load the file position and size (translated to blocks) onto the stack.
    movw (bi_file), %ax
    incw %ax
    pushw %ax

    movw (bi_length), %ax
    movw $0x800, %bx
    divw %bx

    xor %ah, %ah
    pushw %ax

    pushw $0x840
    pushw $0x0
    call read_sectors
    add $0x8, %sp

    # Check if the drive is a floppy.
    cmpb $0x80, %dl
    jl read_disk

    # Try and get the geometry.
    movb $0x08, %ah
    int $0x13
    jnc got_drive_geometry

    # Reset the floppy drive.
    movb $0x00, %ah
    int $0x13
    jc reset_failed

    # Try and get the geometry, again.
    movb $0x08, %ah
    int $0x13
    jnc got_drive_geometry

    # Use defaults.
    movw $0x2, (disk_heads)
    movw $0x50, (disk_cylinders)
    movw $0x12, (disk_sectors)

    jmp read_floppy

got_drive_geometry:
    movb %ch, %al
    movb %cl, %ah
    xorb %ch, %ch
    andb $0x3f, %cl
    movw %cx, (disk_sectors)

    shrb $0x6, %ah
    movw %ax, (disk_cylinders)

    xor %ax, %ax
    mov %dh, %al
    mov %ax, (disk_heads)

read_floppy:

read_disk:

reset_failed:

1:
    hlt
    jmp 1b


#
#  Reads 2KiB sectors using INT 13H, AH=42.
#
read_sectors:
    pushw %bp
    mov %sp, %bp

    push %ax

    movw 10(%bp), %ax
    movw %ax, (dap_start)

    movw 8(%bp), %ax
    movw %ax, (dap_n_blocks)

    movw 6(%bp), %ax
    movw %ax, (dap_segment)

    movw 4(%bp), %ax
    movw %ax, (dap_offset)

    leaw dap_size, %si

    movb $0x42, %ah
    int $0x13

    popw %ax

    popw %bp
    ret

    .align 8
dap_size:
    .byte 0x10
dap_null:
    .byte 0
dap_n_blocks:
    .word 0
dap_offset:
    .word 0
dap_segment:
    .word 0
dap_start:
    .quad 0

disk_heads:
    .word 0

disk_cylinders:
    .word 0

disk_sectors:
    .word 0