.MODEL SMALL
.DATA
somewords db "opamp transistor diode resistor",'$'
                                                                
.code

main proc far  
    
    MOV AX,OFFSET DATA
    MOV DS,AX
    MOV AX,0h
    MOV CX,0h 
    MOV SI,OFFSET SOMEWORDS
      
  Count:
  MOV AL,[SI] 
  INC SI
  INC CX      ;Count the number of chars
  CMP AL,24H  ;Take the chars untill '$' sign
  JNE Count
  
  SUB SI,CX   ;set the SI back to the beginning of the string
  DEC CX
  
  MOV BX,CX   ;Copy the number of chars for the use in 2nd loop
  
    GIVE: 
    MOV AL,[SI]
    PUSH AX     ;give the char to stack
    INC SI
    DEC BX      
    CMP BX,0h   ;continue untill pushing the last char
    JNZ GIVE
    
    SUB SI,CX
    
    TAKE:       
    POP AX      ;take the char from stack
    MOV [SI],AL  
    INC SI
    DEC CX
    CMP CX,0h   ;continue untill poping the last char
    JNZ TAKE 
               
    MOV AH, 09h
    MOV DX, OFFSET SOMEWORDS
    INT 21h
    
    END MAIN