.model small                                           ;small model supports one data segment and one code segment,All data and code are near by default.
.stack 100                                        ;creates a stack segment, adjusting the default size of 1K to 100
.data
  array DB 4,2,8,1,16,6,27,18,19,3,0DH, 0AH,'$' ;declare n 1-byte values and initialized
  result DB 10 DUP(0)                                                      ;declare 20 uninitialized words starting at location result
  len DB 10
  count DB 0
 



.code
      MAIN PROC FAR           ;proc as FAR tells the assembler that all Calls to that proc must give both a segment and a 16-bit offset
            MOV AX, @data
            MOV DS, AX

         

            ;AL->right AH->left BX->j CL->i DI->i DL->result    DH->loop2 condition  CH->loop1 condition

            MOV DI,0          ;i variable
            MOV CL,0          ;i variable
            MOV CH,[len]      ;loop1 condition  
Loop_1:     MOV AL,[len]      ;right=len
            SUB AL,CL         ;right=len-i
            DEC AL            ;right=len-i-1
            MOV AH,CL         ;left=i
            CMP AL,5          
            JLE ELSE1
            MOV AL,5
ELSE1:      CMP AH,4
            JLE ELSE2
            MOV AH,4
ELSE2:      MOV DL,0          ;result=0
            MOV BX,DI         ;j=i
            SUB BL,AH         ;j=i-left   loop2 initial condition
            ADD DH,AL         ;right
            ADD DH,AH         ;right+left
            INC DH            ;right+left+1
            MOV [count],DH
Loop_2:     MOV SI,BX
            ADD DL,[array+SI]
            INC BX
            DEC DH
            JZ OUTLOOP
            JMP loop_2
OUTLOOP:    push AX
            push BX
            mov AX,0000h
            mov BX,0000h
            MOV Al,DL
            MOV Bl,count
            div BL
            mov [result+DI],al
            pop BX
            pop AX
            INC DI
            INC CL
            DEC CH
            JZ END1
            JMP loop_1
               
END1:       MOV AH, 4CH   ;to terminate
            INT 21H  
      MAIN ENDP               ; denotes the end of your procedure
END MAIN                      ;marks the end of the file
