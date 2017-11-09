.model small                                           ;small model supports one data segment and one code segment,All data and code are near by default.
.stack 100                                        ;creates a stack segment, adjusting the default size of 1K to 100
.data
  array DB 4,2,8,1,16,6,27,18,19,3,0DH, 0AH,'$' ;declare n 1-byte values and initialized
  result DB 10 DUP(0)                                                      ;declare 20 uninitialized words starting at location result
  len DB 10
  count DB 0
 



.code
      MAIN PROC FAR           ;proc as FAR tells the assembler that all Calls to that proc must give both a segment and a 16-bit offset
            MOV AX, @data 	  ;10
            MOV DS, AX		  ;2

 
            ;AL->right AH->left BX->j CL->i DI->i DL->result    DH->loop2 condition  CH->loop1 condition

            MOV DI,0    ;4,     ;i variable
            MOV CL,0   ;4       ;i variable
            MOV CH,[len]  ;8+EA    ;loop1 condition  
Loop_1:     MOV AL,[len] ;10     ;right=len
            SUB AL,CL   ;3      ;right=len-i
            DEC AL   ;3         ;right=len-i-1
            MOV AH,CL ;2        ;left=i
            CMP AL,5  ;4     
            JLE ELSE1 ;16
            MOV AL,5  ;4
ELSE1:      CMP AH,4 ;4
            JLE ELSE2 ;16
            MOV AH,4 ;4
ELSE2:      MOV DL,0 ;4        ;result=0
            MOV BX,DI ;2       ;j=i
            SUB BL,AH ;3        ;j=i-left   loop2 initial condition
            ADD DH,AL ;3        ;right
            ADD DH,AH ;3        ;right+left
            INC DH  ;3         ;right+left+1
            MOV [count],DH  ;9+EA
Loop_2:     MOV SI,BX ;2
            ADD DL,[array+SI] ; 9+EA
            INC BX ;2
            DEC DH ;3
            JZ OUTLOOP ;4
            JMP loop_2 ;15
OUTLOOP:    push AX ;11
            push BX ;11
            mov AX,0000h ;4
            mov BX,0000h ;4
            MOV Al,DL ;3
            MOV Bl,count ;8
            div BL ;144
            mov [result+DI],al ;10
            pop BX ;8
            pop AX ;8
            INC DI ;2
            INC CL ;3
            DEC CH ;3
            JZ END1 ;4
            JMP loop_1 ;15
               
END1:       MOV AH, 4CH ;4  ;to terminate
            INT 21H  ;51
      MAIN ENDP               ; denotes the end of your procedure
END MAIN                      ;marks the end of the file