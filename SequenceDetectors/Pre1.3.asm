org 100h
       
mov dx,00101001b  ;8 digit number 
mov cx,00b        ;counting number of 1's
mov ax,08d        ;Number of digits            

Work: shr dx,1b   ;shift dx 1-bit right
      jc Work1    ;go to 'Work1' if carry
      cmp dx,0d   ;decide whether dx=0?
      jne Work    ;go to 'Work' if dx isn't equal to 0
      
      sub ax,cx   ;number of digits - number of 1's 
                  ;= number of 0's
      
      int 21h     ;end the program
      
Work1: inc cx     ;increment number of 1's
       jmp Work   ;go to 'Work'
           
ret





