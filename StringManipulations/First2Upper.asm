; An assembly code that converts only the 
; first letter of each word to uppercase.

.MODEL SMALL
.DATA
somewords db " opamp transistor diode resistor",'$' 
                                                                
.code

main proc far  
    
    MOV AX,OFFSET DATA
    MOV DS,AX
    MOV AX,0h
    MOV CX,0h  ; Clear the registers
    MOV SI,OFFSET SOMEWORDS  ; Set si to the beginning of string
      
  Count:      ; Count the number of chars in string
  MOV AL,[SI] 
  INC SI
  INC CX     
  CMP AL,024H  
  JNE Count
  
  SUB SI,CX   ;set the
  DEC CX
     
    PRINT: 
    MOV AL,[SI]   ; Check the chars one by one
    DEC CX        ; Decrease the number of checked chars
    CMP AL,020h   ; Check if 'Space' is encountered
    JE  UPPERCASE
    INC SI  
    CMP CX,00h 
    JNE PRINT
    JZ  DISPLAY   
            
    UPPERCASE:       
    MOV BL,[SI+1]
    SUB BL,20H  
    MOV [SI+1],BL ; Convert to uppercase 
    INC SI
    DEC CX        ; Decrease the number of checked chars
    CMP CX,0h     ; Check whether this is end of string 
    JZ  DISPLAY   ; Go to display if string ends
    JMP PRINT     ; Go to check further chars 
    
    DISPLAY:
    MOV AH, 09h
    MOV DX, OFFSET SOMEWORDS
    INT 21h  ; Display the string
    MAIN ENDP
    
END MAIN

