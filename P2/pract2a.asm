;**************************************************************************
; SBM 2024. PRACTICA 2
;**************************************************************************
; DEFINICION DEL SEGMENTO DE DATOS
;**************************************************************************

DATOS SEGMENT
	matriz: dw 1, 0, 0, 0, 1, 0, 0, 0, 1 
    resultado dw 0 
    TEXTO1 DB " La matriz NO es I",13,10,"$"
    TEXTO2 DB " La matriz es I ",13,10,"$"
	CLR_PANT 	DB 	1BH,"[2","J$"
DATOS ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO DE PILA
;**************************************************************************

PILA SEGMENT STACK "STACK"
DB 40H DUP (0) ;ejemplo de inicialización, 64 bytes inicializados a 0
PILA ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO EXTRA
;**************************************************************************
EXTRA SEGMENT
EXTRA ENDS

;**************************************************************************
; DEFINICION DEL SEGMENTO DE CODIGO
;**************************************************************************
CODE SEGMENT
ASSUME CS: CODE, DS: DATOS, ES: EXTRA, SS: PILA
; COMIENZO DEL PROCEDIMIENTO PRINCIPAL
INICIO PROC
; INICIALIZA LOS REGISTROS DE SEGMENTO CON SU VALOR
MOV AX, DATOS
MOV DS, AX
MOV AX, PILA
MOV SS, AX
MOV AX, EXTRA
MOV ES, AX
MOV SP, 64 ; CARGA EL PUNTERO DE PILA CON EL VALOR MAS ALTO
; FIN DE LAS INICIALIZACIONES
; COMIENZO DEL PROGRAMA

MOV BX, 0 ; indice al numero de filas
MOV DI, 0 ; indidce al nuemro de columnas
bfilas: 
    CMP BX, 6
    JGE fin
    JMP bcolumnas
bcolumnas:
    CMP DI, 6
    JGE b1
    MOV AX, matriz[BX][DI]
    CMP DI, BX
    JE diagonal
    JMP resto
diagonal: ; if (di == BX) ==> tabla[di][BX] == 1
    CMP AX, 01
    JNE noexito
    JMP b2
resto: ; if (di != BX) ==> tabla[di][BX] == 0
    CMP AX, 00
    JNE noexito
    JMP b2
b2: 
    ADD DI, 2 ; di++
    JMP bcolumnas
b1:
    MOV DI, 0 
    ADD BX, 2 ; si++
    jmp bfilas


noexito:
    MOV AH,9	; BORRA LA PANTALLA
	MOV DX, OFFSET CLR_PANT
	INT 21H
   
    MOV DX, OFFSET TEXTO2		; La matriz NO es I ...
	MOV AH,9
	INT 21H
fin: 
    MOV AH,9	; BORRA LA PANTALLA
	MOV DX, OFFSET CLR_PANT
	INT 21H

    MOV DX, OFFSET TEXTO2		; La matriz es I ...
	MOV AH,9
	INT 21H


;imprimirMatriz:
;    MOV CX, 3
;    fila_loop:
;        MOV DX, CX
;        CALL imprimirSaltoDeLinea
;
;        MOV BX, 3
;    columna_loop:
;        MOV AL, [SI]
;        CALL imprimirNumero
;        ADD SI, 1
;        jl columna_loop
;
;    LOOP fila_loop
;    RET
;    
;imprimirNumero:
;    ADD AL, '0'
;    MOV AH, 2
;    INT 21h
;    RET
;
;imprimirSaltoDeLinea:
;    MOV AH, 2
;    MOV DL, 13
;    INT 21h
;
;    MOV AH, 2
;    MOV DL, 10
;    INT 21h
;    RET
;
;verificarIdentidad:
;    mov cx, 3 ; Número de filas
;    fila_loop:
;        mov bx, 3 ; Número de columnas
;    columna_loop:
;        cmp word [si], 1 ; Compara con 1
;        jne no_identidad ; Si no es igual a 1, no es la matriz identidad
;        add si, 1 ; Mueve al siguiente elemento en la fila
;        loop columna_loop
;
;    loop fila_loop
;    mov resultado, 'S' ; Si ha llegado aquí, es la matriz identidad
;    jmp fin_programa
;
;no_identidad:
;    mov resultado, 'N' ; Si no es la matriz identidad

fin_programa:
    ret

; FIN DEL PROGRAMA
MOV AX, 4C00H
INT 21H
INICIO ENDP
; FIN DEL SEGMENTO DE CODIGO
CODE ENDS
; FIN DEL PROGRAMA INDICANDO DONDE COMIENZA LA EJECUCION
END INICIO
