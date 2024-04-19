; An n assembly code that draws (using pixel operations) a square or a triangle on the screen
; if input is letter `S/s' or `T/t', respectively. Shapes are drawn as centered on the screen horizontally
; and vertically in graphics mode 12h (i.e. 640x480 pixels). The program is case insensitive.
; For the other inputs, the program writes `It is not a valid input' message on the screen and
; ask again. After shape type selection, program takes the height of the shape from user as number 
; of horizontal pixel lines.

org 100h 

AskHeight       db 10,13,'What is the height of the shape:','$'
InvCho          db 10,13,'It is not a valid input',10,13,'$'
ChooseShape     db 'Choose a shape T/t or S/s:','$'
TakeHeight      db 10,?, 10 dup(' ')
center          dw 10 dup(?)
height          dw 10 dup(?)

Again:                            ; Ask again for Input

       mov AH,09h 
       mov DX,offset ChooseShape
       int 21h      
                                  ; Prompt the user to choose the shape
       mov AH,01h
       int 21h 
       
       cmp AL,'s'
       je Sq   
       cmp AL,'S'                 ; s or S?
       je Sq 
       cmp AL,'t'
       je Tri 
       cmp AL,'T'
       je Tri                     ; t or T? 
       jne Invalid               

Tri:
        call TriDraw                ; Printing Triangle
        jmp finish                        

Sq:                                 ; Printing Square
        call SqDraw
        jmp  finish                    

Invalid:                            ; Print Invalid
        mov AH,09h 
        mov DX,offset InvCho        
        int 21h
        jmp Again                        

finish: ret

TriDraw proc
        
           call hconvert
           mov height,DX
           mov DX,0
           mov AX,height
           mov BX,2
           idiv BX
           mov center,AX
           mov SI,320
           sub SI,center 
           mov BP,320
           add BP,center
           mov AX,012h
           int 10h
           int 10h 
           mov CX,320
           mov DX,240
           sub DX,center  
          
FirstL:

         mov AL,4  
         mov AH,0ch
         dec CX
         inc DX
         int 10h
         inc DX
         int 10h 
         cmp SI,CX 
         jne FirstL
  
SecondL: 

         mov AL,4  
         mov AH,0ch
         inc CX
         int 10h 
         cmp CX,BP
         jne SecondL
 
ThirdL:

         mov AL,4  
         mov AH,0ch
         dec CX
         dec DX
         int 10h
         dec DX
         int 10h
         cmp CX,320
         jne ThirdL  

ret
 
TriDraw endp 

SqDraw proc
    
         call hconvert
         mov  height,DX 
         mov  DX,0    
         mov  AX,height
         mov  BX,2
         idiv BX
         mov center,AX
         mov SI,320
         sub SI,center 
         mov BP,320
         add BP,center
         mov AX,012h
         int 10h 
         int 10h
         mov CX,SI
         mov DX,240
         sub DX,center
         int 10h
         mov BX,0
 
UpperLine:

         mov AL,4  
         mov AH,0ch
         inc CX
         int 10h
         inc BX 
         cmp BX,height 
         jne UpperLine  
         mov BX,0

RightLine:

         mov AL,4  
         mov AH,0ch
         inc DX
         int 10h
         inc BX 
         cmp BX,height
         jne RightLine
         mov BX,0

LowerLine:

         mov AL,4  
         mov AH,0ch
         dec CX
         int 10h
         inc BX
         cmp BX,height
         jne LowerLine
         mov BX,0
 
LeftLine:

        mov AL,4  
        mov AH,0ch
        dec DX
        int 10h
        inc BX
        cmp BX,height
        jne LeftLine

ret

SqDraw endp


hconvert proc
    
         mov DX,offset AskHeight 
         mov AH,09h
         int 21h      
         mov DX,offset TakeHeight
         mov AH,0ah
         int 21h
         mov BX,0
         mov BP,0
         mov SI,2       
         mov BL,TakeHeight[1]
         mov TakeHeight[bx+2],'$'
  
AsciiNo: 
                                 
         cmp TakeHeight+SI,24h                   
         je  Converted 
         sub TakeHeight+SI,30h
         inc SI  
         jmp AsciiNo 

Converted:

         dec SI
         mov DX,0 
         mov AX,1
         mov BL,TakeHeight+SI   
         mul BL                   
         add DX,AX              
         cmp SI,2
         je  highd
         dec SI             
         mov AX,10 
         mov BL,TakeHeight+SI
         mul BL
         add DX,AX             
         cmp SI,2
         je  highd  
         dec SI
         mov AX,100
         mov BL,TakeHeight+SI
         mul BL  
         add DX,AX
         cmp SI,2
         je  highd
 
highd:   

ret

hconvert endp    
