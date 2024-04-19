; An assembly code that prints a square or a triangle on the screen if input is letter `S/s' or `T/t', 
; respectively. The program is case insensitive. For the other inputs, the program writes
; `It is not a valid input' message on the screen and asks again. After shape type selection, program 
; takes the height of the shape from user as number of lines to print.

org 100h

Again:                              ; Ask again for Input

       mov AH,09h 
       mov DX,offset ChooseShape
       int 21h      
                                    ; Prompt the user to choose the shape
       mov AH,01h
       int 21h      

cmp AL,'t'
je Tri 
cmp AL,'T'
je Tri                              ; t or T? 

cmp AL,'s'
je Sq   
cmp AL,'S'
je Sq                               ; s or S

jne Invalid  

Tri:                                ; Printing Triangle
call TriDraw  
jmp  finish         

Sq:                                 ; Printing Square
call SqDraw
jmp  finish         

Invalid:    
             mov AH,09h 
             mov DX,offset InvCho   ;'Invalid input' display
             int 21h
             jmp Again              ; jump to ask again

finish:

ret

AskHeight          db 10,13,'What is the height of the shape: ','$'
InvCho             db 10,13,'Invalid input',10,13,'$'
ChooseShape        db 'Choose a shape T/t or S/s: ','$'
TakeHeight         db 10,?, 10 dup(' ')
NOs                db 10 dup()
myheight           dw 10 dup()

TriDraw proc                ; Draw Triangle
       
call height                 ; Take the height
call HDig                   ; Split the height
                           
        mov  CX,DX                  
        dec  CX 
        push CX   
        cmp  CX,0
        je   done1
        mov  AH,2  
        mov  DL,' '
        
loop1:    
        int 21h
        loop loop1
      
        mov AH,2
        mov DL,'X'
        int 21h 

        mov AH,2
        mov DL,10
        int 21h
        mov DL,13
        int 21h
 
        mov BX,0
        mov SI,1 
          
loop4:
      pop  CX
      dec  CX
      push CX   
      cmp  CX,0
      je   done1
      mov  DL,' '
      
loop2:
      int 21h
      loop loop2
      
      mov AH,2
      mov DL,'X'
      int 21h
      mov CX,SI
      mov DL,' '
      
loop3:
      int 21h
      loop loop3

      mov DL,'X'
      int 21h

      add SI,2
      mov AH,2
      mov DL,10
      int 21h
      
      mov dl,13
      int 21h
       
      inc BX

      jmp loop4
      
done1:

      add SI,2
      mov CX,SI

      mov DL,'X'

      loop5:
          int 21h
          loop loop5:
      
      hlt 
      
      ret

TriDraw endp


SqDraw proc                    ; Draw square
    
      call height              ; Take height from the user
      call HDig                ; Split height into digit numbers
                              
                              
      mov myheight,DX
      mov CX,myheight 
      mov AH,02
      mov DL,'X'

loop11:     
      int 21h
      loop loop11:
      
      mov  DL,10
      int  21h 
      mov  DL,13
      int  21h

      mov  BX,myheight
      sub  BX,2
      mov  CX,BX
      push CX

loop33: 
     
      mov AH,02
      mov DL,'X'
      int 21h

      mov CX,BX
      mov DL,' '

loop22:     
      
      int  21h
      loop loop22:

      mov  DL,'X'
      int  21h 
      mov  DL,10
      int  21h 
      
      mov  DL,13
      int  21h 
      
      pop  CX
      dec  CX
      push CX
      jcxz done

      jmp loop33  

done:
      mov  CX,myheight 
      mov  AH,02
      mov  DL,'X'

loop44:     
      int  21h
      loop loop44:

hlt    

ret

SqDraw endp


height proc
      
       mov AH,09h 
       mov DX,offset AskHeight              ; Prompt user to enter the height
       int 21h 
                                 
       mov DX,offset TakeHeight
       mov AH,0ah
       int 21h
                                         
       mov BX,0                             ; Clear
       mov BP,0                             ; Clear Counter
       mov SI,2                             ; SI as a counter starting from 2   
       mov BL,TakeHeight[1]                 ; BL --> Character length of TakeHeight
       mov TakeHeight[BX+2],'$'             ; End TakeHeight with '$' 
       mov AX,0003h
       int 10h                              ; Clean the screen
                        
ret

height endp 


HDig proc                                   ; Split Height into digits

NotFinStr:

           cmp TakeHeight+SI,24h            ; Check if the end of string
           je  FinStr
           sub TakeHeight+SI,30h            ;Convert Ascii to numerical value
           lea BX,TakeHeight      
           mov AX,[BX+SI]                      
           mov [NOs+BP],AL                  ;Numerical values to NOs
           inc SI  
           inc BP
           jmp NotFinStr

FinStr:                           
           mov SI,0                         
           mov DX,0                                     
           dec BP                     ; Remaining Height
           mov AX,1
           mov BL,NOs+BP              ; Assign first digit to BL
           mul BL                     ; Obtain Units
           mov DX,0
           add DX,AX                  ; Reconstruct the number in DX
           cmp BP,0
           je  BPLast                 ; Check whether BP is the last digit

           dec BP 
           mov AX,10 
           mov BL,NOs+BP              ; Assign second digit to BL
           mul BL                     ; Obtain Tens
           add DX,AX
           cmp BP,0                   ; Reconstruct the number in DX
           je  BPLast                 ; Check whether BP is the last digit
  
           dec BP                     ; Assign third digit to BL
           mov AX,100                 ; Obtain Hundreds
           mov BL,NOs+BP
           mul BL  
           add DX,AX                  ; Reconstruct the number in DX
           cmp BP,0
           je  BPLast                 ; Check whether BP is the last digit

BPLast:
    
ret                       

HDig endp 
