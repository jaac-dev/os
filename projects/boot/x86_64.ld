OUTPUT_FORMAT(binary)
ENTRY(_start)

SECTIONS
{
    . = 0x7C00;

    .stage1 : {
        *.stage1.o(.text);
        *.stage1.o(.data);
        *.stage1.o(*);
    }

    . = 0x8400;

    .stage2 : {
        *.stage2.o(.text);
        *.stage2.o(.data);
        *.stage2.o(*);
    }
}