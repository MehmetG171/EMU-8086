; Mathematical Functions Application
; Menu Item 1: Check if a number entered by user is a Fibonacci number and print all
; Fibonacci numbers upto that number. If it is not a Fibonacci number, this function
; should give the nearest Fibonacci number that is smaller than the input and Fibonacci
; numbers before that.
; Menu Item 2: Calculate the Factorial of a given number and print the result to the user.
; Menu Item 3: Check if a number entered by user is square of an integer and print that
; integer to the user. If not, print the nearest square number that is smaller than the
; user input and print its square root as well.
; Menu Item 4: Check if a number entered by user is a Prime number and print the
; result. If not nd the nearest Prime number that is smaller than the user input and
; print it.

.MODEL SMALL
.DATA

msg1    DB 'Item-1 (Fibonacci), Item-2 (Factorial), Item-3 (Square), Item-4 (Prime) ','$'
msg2    DB 'Press the Item Number or Esc for EXIT or Space for ABOUT SECTION :','$' 
msg3fac DB 'Enter the number: ','$'
msg4    DB 'Programmer: Mehmet Gunduz ','$'
  
.CODE 

MAIN PROC FAR
    
       MOV AX,00H
       MOV DX,00H
BEGIN: MOV AH, 02h          ; Display the messages
       MOV DL, 09h        
       INT 21h
       MOV AX, OFFSET DATA
       MOV DS, AX              
       MOV AH, 09H
       MOV DX, OFFSET msg1    
       INT 21H
       MOV AH, 2
       MOV DL, 09h        
       INT 21h                             
       MOV AH, 09H
       MOV DX, OFFSET msg2 
       INT 21H  
 
INPUT: MOV AH, 01H          ; Direction in the menu
       INT 21H           
       CMP AL, 31h      
       JE  CALL1
       CMP AL, 32h      
       JE  CALL2
       CMP AL, 33h      
       JE  CALL3
       CMP AL, 34h      
       JE  CALL4
       CMP AL, 020h      
       JE  CALL5
       CMP AL, 027d      
       JE  TERMINATE
       JMP INPUT 
       
CALL1: CALL Fibonacci      ; Fibonacci call
       JMP  INPUT
       
CALL2: CALL FAC            ; Factorial call
       JMP  INPUT 
       
CALL3: CALL Square         ; Square call
       JMP  INPUT
       
CALL4: CALL Prime          ; Prime call
       JMP  INPUT
       
CALL5: CALL SEC            ; About section call
       JMP  INPUT  
       
TERMINATE: CALL TER        ; Exit call
           JMP  INPUT
                          
MAIN ENDP


TER PROC                   ; Exit Procedure
    
      HLT           

TER ENDP

NUM PROC                   ;'Enter a number' Display
    
    MOV AH, 02h
    MOV DL, 09h        
    INT 21h 

    MOV AH, 09H
    MOV DX, OFFSET msg3fac    
    INT 21H
    
    CMP AL, 027d      
    JE  TERMINATE
    
    RET 
    
NUM ENDP


FAC PROC                  ; Factorial Procedure
    
    CALL NUM
    
    MOV AH, 01H       
    INT 21H 
    
    SUB AL, 30H
    
    MOV AH,00H
    MOV BH,00H 
    
      MOV BL,AL
      MOV AL,01H
      MOV CX,01H
      MOV DX,00h

     FACTORIAL: MUL  CX
                INC  CX
                CMP  BX,CX
                JNL  FACTORIAL 
                 
     MOV SI,AX
                 
     MOV AH, 02h
     MOV DL, 020h        
     INT 21h 
     
     MOV AX,SI
                              
     CALL PRINT 
          
     MOV AH, 02h
     MOV DL, 09h        
     INT 21h 
      
     JMP  BEGIN           

FAC ENDP


Prime PROC                  ; Prime Procedure
    
MOV SI,00H 

CALL NUM

CALL INP

MOV AX,01H
MOV CX,01H
MOV DX,00H
MOV SI,00H
           
IsPRIME: MOV DX,00H 

         INC CX
         CMP CX,BX
         JE  PRE 
       
         MOV AX,BX
         DIV CX
       
         CMP DX,00H
         JNE IsPrime 
                               
CONT:  DEC BX
       MOV CX,01H
       JMP IsPRIME 
       
PRE:   INC SI
       CMP SI,01H
       JE  LAST
       
LAST:  MOV AX,BX

       MOV SI,AX
                 
       MOV AH, 02h
       MOV DL, 020h        
       INT 21h 
      
       MOV AX,SI
                              
       CALL PRINT 
           
       MOV AH, 02h
       MOV DL, 09h        
       INT 21h
       
       JMP BEGIN

Prime ENDP

                             
Square PROC                  ; Square Procedure
    
MOV SI,00H

CALL NUM 
    
CALL INP

MOV AX,00H
MOV CX,00H
MOV DX,00H

SQUARE1: INC   CX
         MOV   AX,CX
         MUL   AX 
         CMP   AX,BX
         JL    SQUARE1
        
         CMP  AX,BX
         JE   PRE1
         JNE  PRE2
                       
CONT1:   MOV BP,AX
                 
         MOV AH, 02h
         MOV DL, 020h        
         INT 21h 
     
         MOV AX,BP

         CALL PRINT
         
         JMP BEGIN 
        
CONT2:  MOV BP,AX
                 
        MOV AH, 02h
        MOV DL, 020h        
        INT 21h 
     
        MOV AX,BP

        CALL PRINT
        
        MOV BP,AX
                 
        MOV AH, 02h
        MOV DL, 020h        
        INT 21h 
     
        MOV AX,BP

        MOV AH,02H 
        MOV DL,20H
        INT 21h

        MOV AX,SI
        MUL AX

        CALL PRINT
        
        JMP BEGIN 
        
PRE1:   MOV AX,CX 
        JMP CONT1
        
PRE2:   DEC CX
        MOV AX,CX
        MOV SI,CX
        JMP CONT2
           
Square ENDP



Fibonacci PROC                ; Fibonacci Procedure
    
JMP BEGIN
    
mov si,17711d
mov bx,0d
mov cx,1d
mov dx,1d

START: mov dx,bx
       
       mov ax,dx
       
       CALL PRINT

       add bx,cx
       mov cx,dx 
       cmp bx,si
       jb  START 
             
       cmp si,bx
       je START1
       
       mov dx,42h
       int 16h      
       
START1: mov dx,bx
        int 16h   
        
Fibonacci ENDP


PRINT PROC                    ;Print Procedure
    
   MOV BP,AX
    
   MOV AH, 02h
   MOV DL, 020h        
   INT 21h
   
   MOV AX,BP       
    
      MOV CX,0
      MOV DX,0
    
      FIRST:  CMP AX,0
              JE  PRINT1     
         
              MOV BX,10       
              DIV BX                 
        
              PUSH DX             
        
              INC CX             
              MOV DX,0
              
              JMP FIRST

      PRINT1: CMP CX,0
              JE  EXIT

              POP DX
                          
              ADD DX,30H
              MOV AH,02H
              INT 21h
         
              DEC CX
              JMP PRINT1

      EXIT:   
              RET   

PRINT ENDP 


INP PROC                ; Input Procedure
                        ; Press 'Enter' after entering the number
MOV AH,02H 
MOV DL,09H
INT 21h

INPUTTAKE:
  
   MOV AH, 01H       
   INT 21H           
   MOV [0001+SI],AL 
   INC SI
   CMP AL, 027d      
   JE  TERMINATE            
   CMP AL, 0Dh       
   JNE INPUTTAKE
   
   MOV CX,[0001h]    
   SUB CX,030h       
   MOV [0001h],CX
   
   MOV CX,[0002h]    
   SUB CX,030h       
   MOV [0002h],CX
  
   MOV CX,[0003h]   
   SUB CX,030h       
   MOV [0003h],CX
   
   MOV CX,[0004h]    
   SUB CX,030h       
   MOV [0004h],CX     
     
   MOV CX,[0005h]   
   SUB CX,030h       
   MOV [0005h],CX    
     
   DEC  SI                
   CMP  SI,06d       
   JNB  ERROR        
   JB   CALCULATE    

CALCULATE:  
  
   CMP SI,01d        
   JLE  CASE1         
   
   CMP SI,02d       
   JLE  CASE2         
   
   CMP SI,03d       
   JLE  CASE3         
      
   CMP SI,04d        
   JLE  CASE4         
   
   CMP SI,05d        
   JLE  CASE5         
   
CASE5:   MOV AX,10000d 
         MUL [0001h]    
   
         MOV BX,AX     
     
         MOV AX,1000d     
         MUL [0002h]  
         
         ADD BX,AX
         
         MOV AX,100d     
         MUL [0003h]    
         
         ADD BX,AX
         
         MOV AX,10d     
         MUL [0004h]    
         
         ADD AL,[0005h]  
        
         ADD BX,AX       
         
         CMP BX,0FFFFH
         JA  ERROR

         RET
   
CASE4:   MOV AX,1000d     
         MUL [0001h]    
   
         MOV BX,AX      
     
         MOV AX,100d     
         MUL [0002h]    
         
         ADD BX,AX
         
         MOV AX,10d     
         MUL [0003h]   
                                               
         ADD AL,[0004h]
        
         ADD BX,AX      

         RET
   
CASE3:   MOV AX,100d    
         MUL [0001h]    
   
         MOV BX,AX     
     
         MOV AX,10d     
         MUL [0002h] 
         
         ADD AL,[0003h]
         
         ADD BX,AX           

         RET

CASE2:   MOV AX,10d     
         MUL [0001h]    
         ADD AL,[0002h]
         
         MOV BX,AX 
         
         RET

CASE1:   MOV AL,[0001h]
         MOV AH,00H
         
         MOV BX,AX      
         
         RET 
         
ERROR:   JMP BEGIN
         
INP ENDP 

SEC PROC                    ; 'About Section' Procedure
    
    MOV AH, 02h
    MOV DL, 09h        
    INT 21h
    
MOV AH, 09H
MOV DX, OFFSET msg4    
INT 21H  

    MOV AH, 02h
    MOV DL, 09h        
    INT 21h
    
    JMP BEGIN
        
SEC ENDP
