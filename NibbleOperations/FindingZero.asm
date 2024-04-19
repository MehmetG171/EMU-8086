; An assembly code that finds all-zero nibble's offset in AX
; register. It prints the offset of that nibble on the screen.
; Example: AX = 10F7h, second nibble is all-zero, offset is 2 
; (counting from highest nibble).

org 100h 

MOV AX, 10F7h
MOV BX, AX
MOV CH, 0b
 
CALL P1        ; First call

MOV AX, 1DE0h
MOV BX, AX
MOV CH, 0b
 
CALL P1        ; Second call

MOV AX, 2304h
MOV BX, AX
MOV CH, 0b
 
CALL P1        ; Third call

MOV AX, 2334h
MOV BX, AX
MOV CH, 0b
 
CALL P1        ; Forth call

MOV AX, 7012h
MOV BX, AX
MOV CH, 0b

CALL P1        ; Fifth call

HLT            ; End

ret       

P1 PROC
    
MOV DL, 4     ; Set offset = 4
   
SHL AL, 4     ; Check 4th nibble
CMP AL, CH
JZ  PRINT
DEC DL
        
SHR BL, 4     ; Check 3rd nibble
CMP BL, CH
JZ  PRINT
DEC DL  

SHL AH, 4     ; Check 2nd nibble
CMP AH, CH
JZ  PRINT
DEC DL
        
SHR BH, 4     ; Check 1st nibble
CMP BH, CH
JZ  PRINT
DEC DL
        
PRINT:
        MOV AH, 2
        ADD DL, 30h  ; Print the offset         
        INT 21h 
        
        MOV AH, 2
        MOV DL, 20h  ; Space         
        INT 21h            

RET
    
P1 ENDP
