; An assembly code that finds the position of bit '0' starting from
; LSB as 1st position in a binary number with only single '0' in it.

org 100h

mov bx,10111111b ;8-bit number  
mov ax,0         ;set ax as position

Work: inc ax     ;increment position
      shr bx,1   ;shift bx to the right
      jc  Work   ;finish the process if carry flag is 0.
      
ret
