# Mario Story ACE Practice
This is a simple modification intended to allow for more consistent practice of the current RTA "Stop 'n' Swop" ACE setup on the Japanese version of Paper Mario.

## Features
Replicates hypothetical OOT ACE -> Stop 'n' Swop setup.
- Expansion memory is cleared on boot.
- JAL to file names is stored at 0x807C0000.

Displays useful information with the C-Up menu.
- This menu is displayed at all times.
- Max HP is used to display an effects counter. For the RTA setup, this should be at 80 after a spin in place and 75 hammers.
- Max FP is used to display the player flag which needs to be manipulated by jumping. For the RTA setup, this should be 3 when the game crashes.
- Star Points and Coins are used to display the AFK timer. For the RTA setup, star points should be at 8 and coins should be between 16 - 31 when the game crashes.

## Building
### Windows
Prebuilt Windows Binaries are included.
1. Place an unmodified, Big Endian (.z64) Mario Story ROM in the roms directory, rename it to "original.z64"
2. Run build.bat

### Other Operating Systems
These tools are required to build:
- bass: https://github.com/jordanbarkley/bass
- n64crc: http://n64dev.org/n64crc.html

A makefile isn't included, but building should be pretty straight forward.