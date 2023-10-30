OUT := MEMORY.PRG
SRC := memory.asm

.PHONY: all run clean

#
# All
#

all: $(OUT)

$(OUT): $(SRC)
	cl65 -t cx16 -o $(OUT) -l memory.list $(SRC)

#
# Run
#

# Norsk Bokmål keyboard layout
KEYMAP := nb

run: all
	x16emu -debug -keymap $(KEYMAP)

#
# Clean
#

clean:
	rm -v *.PRG
	rm -v *.list
	rm -v *.o
