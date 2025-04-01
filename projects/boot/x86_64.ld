OUTPUT_FORMAT(binary)
ENTRY(_start)

SECTIONS
{
    . = 0x7C00;

    .stage1 : {
        *.stage1.S(.text);
        *.stage1.S(.data);
        *.stage1.S(*);
    }

    . = 0x8400;

    .stage2 : {
        *.stage2.S(.load);
        *.stage2.S(.text);
        *.stage2.S(.data);
        *.stage2.S(*);
    }
}