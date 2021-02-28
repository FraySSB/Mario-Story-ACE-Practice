// main.asm

// general setup
arch    n64.cpu
endian  msb
include "src/OS.asm"

// copy fresh rom
origin  0x0
insert  "roms/original.z64"

// change ROM name
origin  0x20
db  "ACE PRACTICE"
fill 0x34 - origin(), 0x20

// add source files
origin  0x02800000
base    0x80400000
b   DMA_END // adding this branch so a jump to 0x80400000 is valid for the ACE entrypoint
nop
include "src/Boot.asm"
include "src/Display.asm"

OS.align(8)
DMA_END:

// rom size = 48MB
origin 0x2FFFFFF
db 0x00