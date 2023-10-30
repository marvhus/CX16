; Commander X16 6502 Assembly (cc65)
.org $080D                  ; our code starts at $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

; Pointers to the zero page
ZP_PTR_1 = $30
ZP_PTR_2 = $32
ZP_DATA  = $34

    jmp     start           ; make sure we start where the code begins

data:
    .byte $01,$23,$45,$67,$89,$AB,$CD,$EF

results:
    .byte $00,$00,$00

start:
    lda     data            ; A          = data[0]
    sta     ZP_DATA         ; ZP_DATA[0] = A
    ldx     #1              ; X          = 1
    lda     data,       x   ; A          = data[X]
    sta     ZP_DATA,    x   ; ZP_DATA[X] = A
    txa                     ; A          = X
    tay                     ; Y          = A
    iny                     ; Y++
    lda     data,       y   ; A          = data[Y]
    sta     ZP_DATA,    y   ; ZP_DATA[Y] = A
    ;; What it does:
    ; ZP_DATA[0] = data[0] = 0x01
    ; ZP_DATA[1] = data[1] = 0x23
    ; ZP_DATA[2] = data[2] = 0x45

    lda     #<data          ; A           = low byte of address to data
    sta     ZP_PTR_1        ; ZP_PTR_1[0] = A
    lda     #>data          ; A           = high byte of address to data
    sta     ZP_PTR_1 + 1    ; ZP_PTR_1[1] = A

    lda     #<(data + 4)    ; A           = low byte of address to (data + 4)
    sta     ZP_PTR_2        ; ZP_PTR_2[0] = A
    lda     #>(data + 4)    ; A           = high byte of address to (data + 4)
    sta     ZP_PTR_2 + 1    ; ZP_PTR_2[1] = A
    ;; What it does:
    ; ZP_PTR_1 = address to data[0]
    ; ZP_PTR_2 = address to data[4]

    lda     (ZP_PTR_1)      ; A          = value at address[0] in ZP_PTR_1[0]   data[0]
    sta     results         ; results[0] = A
    inx                     ; X++
    lda     (ZP_PTR_1,x)    ; A          = value at address[0] in ZP_PTR_1[x]   (data+x)[0]
    sta     results + 1     ; results[1] = A
    lda     (ZP_PTR_1), y   ; A          = value at address[y] in ZP_PTR_1[0]   data[y]
    sta     results,    y   ; results[y] = A
    ;; What it does:
    ; results[0] = data[0] = 0x01
    ; results[1] = data[4] = 0x89
    ; results[2] = data[2] = 0x45

    ; X = 2, but this is what we want, since each address is 2 bytes
    jmp (lookup_ptr)        ; jmp to address in lookup_ptr (lookup)
    ;; What it does:
    ; uses jump table to jump to return

lookup_ptr:
    .addr lookup

lookup:
    jmp (jmp_table, x)      ; jump to address[x] in jmp_table

jmp_table:
    .addr start, return

return:
    rts                     ; return from subroutine

