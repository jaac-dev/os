    .file "cd.stage1.S"
    .code16

    .text
    .globl _start
_start:
    jmp 1f

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

1:
    cli

    xorl %eax, %eax

    movw %ax, %ds

    movw %ax, %ss
    movw $0x7C00, %sp

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

2:
    hlt
    jmp 2b

    jmp _load

2:
    hlt
    jmp 2b

#
#  Reads 2K
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