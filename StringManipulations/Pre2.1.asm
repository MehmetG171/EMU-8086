.MODEL SMALL
.DATA    

output db 10 dub(?) ;Reserving place from memory for inputs    
                                                                
.code

main proc far  

mov si, offset output
 
InputTake:     
  mov ah,01h 
  int 021h      ;take the input chars from user
  cmp al,0dh    ;continue untill 'ENTER' button
  je  Display   ;go to 'Display' if 'ENTER' is typed
  cmp al,05Bh   ;compare with '[' whether char is Uppercase in ASCII 
  jb  Upper
  jnb Lower
  
Continue:
  mov [si],al   ;continue to take input
  inc si        ;and store to [si]
  jmp InputTake
   
Display:
  mov al, '$'   ;end the string with '$' sign
  mov [si],al
  mov ah,09h
  mov dx,offset output
  int 21h       ;display the result
  jmp Terminate

Upper:
  add al,032d  ;convert to uppercase if the char is lowercase
  jmp Continue

Lower:
  sub al,032d  ;convert to lowercase if the char is uppercase
  jmp Continue
  
Terminate:  
             
MAIN ENDP