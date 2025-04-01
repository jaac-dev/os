    .file "load.stage2.S"

    .code16
    .text
    .globl _load
_load:
1:
    hlt
    jmp 1b