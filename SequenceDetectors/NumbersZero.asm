; An assembly code that finds the number of bits
; '0' in a binary number stored in DX register

org 100h
       
mov dx,00101001b  ; 8 digit number 
mov cx,00b        ; Counting number of 1's
mov ax,08d        ; Number of digits            

Work: shr dx,1b   ; Shift dx 1-bit right
      jc Work1    ; Go to 'Work1' if carry
      cmp dx,0d   ; Decide whether dx=0?
      jne Work    ; Go to 'Work' if dx isn't equal to 0
      
      sub ax,cx   ; Number of digits - number of 1's 
                  ; = number of 0's
      
      int 21h     ; End the program
      
Work1: inc cx     ; Increment number of 1's
       jmp Work   ; Go to 'Work'
           
ret
