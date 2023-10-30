; Commander X16 6502 Assembly (cc65)
.org $080D                  ; our code starts at $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

start:
    lda     #1              ; load #1 into register A
    inc                     ; increment register A
    sta     $1000           ; store register A at $1000 in memory
    rts                     ; return from subroutine
