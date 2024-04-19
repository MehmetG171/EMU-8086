; An assembly code that exchanges the high nibble of AH with the low nibble of AL 
; when the middle nibbles of AX are zero, using only shift, rotate and exchange(XCHG)  
; operations, no MOV except setting AX for the rst time, no AND-OR-XOR operations either.
; Example: AX = B007h, after calling the procedure, AX = 700Bh.

org 100h 

MOV  AX,0B007H  
CALL P1         ; First call
PUSH AX

MOV  AX,03008H  
CALL P1         ; Second call
PUSH AX

MOV  AX,0D003H  
CALL P1         ; Third call
PUSH AX

MOV  AX,0A00BH  
CALL P1         ; Forth call
PUSH AX

MOV  AX,0C009H  
CALL P1         ; Fifth call
PUSH AX 

JMP Exit2
 
P1  PROC
    
PUSH AX         ; Store AX
SHL  AX,4       ; Check if middle nibbles
SHR  AX,8       ; are zero?
JNZ  Exit 
               
POP   AX        ; Take back AX
XCHG  AH,AL     ; Exchange AH and AL
ROR   AL,4      ; Change the nibbles in AL
ROR   AH,4      ; Change the nibbles in AX 

Exit: 

RET

P1  ENDP  

Exit2:

END
