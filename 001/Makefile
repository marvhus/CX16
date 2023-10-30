OUT := MAIN.PRG

.PHONY: all run clean

#
# All
#

all: $(OUT)

$(OUT): main.asm
	cl65 -t cx16 -o $(OUT) -l example.list main.asm

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
	rm -v $(OUT)
	rm -v example.list
	rm -v *.o
