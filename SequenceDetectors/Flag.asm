; Find two numbers that generate both carry 
; flag and zero flag when they are added.

org 100h

mov al,080h ; assign 128 to al
mov bl,080h ; assign 128 to al
add al,bl   ; add al and bl,store result in al

ret
