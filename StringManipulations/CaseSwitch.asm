; An assembly code that takes 10 characters of input
; from user and switches the case of characters 
; (lowercase to uppercase, uppercase to lowercase)

.MODEL SMALL
.DATA    

output db 10 dub(?) ; Reserving place from memory for inputs    
                                                                
.code

main proc far  

mov si, offset output
 
InputTake:     
  mov ah,01h 
  int 021h      ; Take the input chars from user
  cmp al,0dh    ; Continue untill 'ENTER' button
  je  Display   ; Go to 'Display' if 'ENTER' is typed
  cmp al,05Bh   ; Compare with '[' whether char is Uppercase in ASCII 
  jb  Upper
  jnb Lower
  
Continue:
  mov [si],al   ; Continue to take input
  inc si        ; And store to [si]
  jmp InputTake
   
Display:
  mov al, '$'   ; End the string with '$' sign
  mov [si],al
  mov ah,09h
  mov dx,offset output
  int 21h       ; Display the result
  jmp Terminate

Upper:
  add al,032d  ; Convert to uppercase if the char is lowercase
  jmp Continue

Lower:
  sub al,032d  ; Convert to lowercase if the char is uppercase
  jmp Continue
  
Terminate:  
             
MAIN ENDP
