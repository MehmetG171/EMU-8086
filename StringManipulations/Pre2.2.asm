.MODEL SMALL
.DATA
somewords db " opamp transistor diode resistor",'$' 
                                                                
.code

main proc far  
    
    MOV AX,OFFSET DATA
    MOV DS,AX
    MOV AX,0h
    MOV CX,0h  ;clear the registers
    MOV SI,OFFSET SOMEWORDS  ;set si to the beginning of string
      
  Count:      ;count the number of chars in string
  MOV AL,[SI] 
  INC SI
  INC CX     
  CMP AL,024H  
  JNE Count
  
  SUB SI,CX   ;set the
  DEC CX
     
    PRINT: 
    MOV AL,[SI]   ;check the chars one by one
    DEC CX        ;decrease the number of checked chars
    CMP AL,020h   ;check if 'Space' is encountered
    JE  UPPERCASE
    INC SI  
    CMP CX,00h 
    JNE PRINT
    JZ  DISPLAY   
            
    UPPERCASE:       
    MOV BL,[SI+1]
    SUB BL,20H  
    MOV [SI+1],BL ;convert to uppercase 
    INC SI
    DEC CX        ;decrease the number of checked chars
    CMP CX,0h     ;check whether this is end of string 
    JZ  DISPLAY   ;go to display if string ends
    JMP PRINT     ;go to check further chars 
    
    DISPLAY:
    MOV AH, 09h
    MOV DX, OFFSET SOMEWORDS
    INT 21h  ;display the string
    MAIN ENDP
    
END MAIN