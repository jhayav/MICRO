;**************************************************************************
; SBM 2024. PRACTICA 2
;**************************************************************************
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
	matriz: dw 1, 0, 0, 0, 1, 0, 0, 0, 1 
    resultado dw 0 
DATOS ENDS
;**************************************************************************
; DEFINICION DEL SEGMENTO DE PILA
PILA SEGMENT STACK "STACK"
DB 40H DUP (0) ;ejemplo de inicialización, 64 bytes inicializados a 0
PILA ENDS
;**************************************************************************
; DEFINICION DEL SEGMENTO EXTRA
EXTRA SEGMENT
RESULT DW 0,0 ;ejemplo de inicialización. 2 PALABRAS (4 BYTES)
EXTRA ENDS
;**************************************************************************
; DEFINICION DEL SEGMENTO DE CODIGO
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
MOV SI, 0
MOV DI, 0
jmp vuelta1


bucle1:
    xor SI, SI
    jmp vuelta1
vuelta1:
    cmp SI, 6
    jl bucle2    
bucle2:
    xor DI, DI
    jmp vuelta2
CHICHA:
    MOV AX, matriz[SI][DI]
    cmp SI, DI
    je comprobacion
vuelta2:
    cmp DI, 6
    jl CHICHA
    jmp INK2
comprobacion1:
    cmp SI, DI ;if(j==i)  
    JNE comprobacion2
    cmp AX, 0 ;if(matriz[i][j]!=1)
    jne fin_programa
    jmp INK1
comprobacion2:; AX sea 1
    cmp AX, 1
    je bucle2
    jne fin_programa
    inc INK1
INK1:
    inc DI
    inc DI
    jmp bucle2
INK2:
    inc SI
    inc SI
    jmp bucle1















imprimirMatriz:
    MOV CX, 3
    fila_loop:
        MOV DX, CX
        CALL imprimirSaltoDeLinea

        MOV BX, 3
    columna_loop:
        MOV AL, [SI]
        CALL imprimirNumero
        ADD SI, 1
        jl columna_loop

    LOOP fila_loop
    RET
    
imprimirNumero:
    ADD AL, '0'
    MOV AH, 2
    INT 21h
    RET

imprimirSaltoDeLinea:
    MOV AH, 2
    MOV DL, 13
    INT 21h

    MOV AH, 2
    MOV DL, 10
    INT 21h
    RET

verificarIdentidad:
    mov cx, 3 ; Número de filas
    fila_loop:
        mov bx, 3 ; Número de columnas
    columna_loop:
        cmp word [si], 1 ; Compara con 1
        jne no_identidad ; Si no es igual a 1, no es la matriz identidad
        add si, 1 ; Mueve al siguiente elemento en la fila
        loop columna_loop

    loop fila_loop
    mov resultado, 'S' ; Si ha llegado aquí, es la matriz identidad
    jmp fin_programa

no_identidad:
    mov resultado, 'N' ; Si no es la matriz identidad

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
