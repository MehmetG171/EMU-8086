org 100h 

MOV  AX,0B007H  
CALL P1         ;First call
PUSH AX

MOV  AX,03008H  
CALL P1         ;Second call
PUSH AX

MOV  AX,0D003H  
CALL P1         ;Third call
PUSH AX

MOV  AX,0A00BH  
CALL P1         ;Forth call
PUSH AX

MOV  AX,0C009H  
CALL P1         ;Fifth call
PUSH AX 

JMP Exit2
 
P1  PROC
    
PUSH AX         ;Store AX
SHL  AX,4       ;Check if middle nibbles
SHR  AX,8       ;are zero?
JNZ  Exit 
               
POP   AX        ;Take back AX
XCHG  AH,AL     ;Exchange AH and AL
ROR   AL,4      ;Change the nibbles in AL
ROR   AH,4      ;Change the nibbles in AX 

Exit: 

RET

P1  ENDP  

Exit2:

END