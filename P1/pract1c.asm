;**************************************************************************
; SBM 2024. ESTRUCTURA BÁSICA DE UN PROGRAMA EN ENSAMBLADOR
;**************************************************************************
; DEFINICION DEL SEGMENTO DE DATOS
DATOS SEGMENT
    LARGAVIDA_SBM2024 DB 0
    BEBA DW 0CAFEH
    TABLA300 DB 300 DUP (0)
    ERRORTOTAL2 db 1BH,"Este programa se cuelga siempre. $"
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

INICIO PROC
    ; INICIALIZACIONES
    MOV AX, DATOS
    MOV DS, AX
    MOV AX, PILA
    MOV SS, AX
    MOV AX, EXTRA
    MOV ES, AX
    MOV SP, 64

    ; COPIAR EL SEGUNDO CARÁCTER DE ERRORTOTAL2 A LA POSICIÓN 63H DE TABLA300
    MOV SI, OFFSET ERRORTOTAL2 + 1 ; Puntero al segundo carácter de ERRORTOTAL2
    MOV DI, OFFSET TABLA300 + 63H ; Dirección de destino en TABLA300
    MOV CX, 1 ; Número de bytes a copiar
    MOV AL, [SI] ; Obtener el byte
    MOV [DI], AL ; Copiar el byte a ES:DI

    ; COPIAR EL CONTENIDO DE BEBA A PARTIR DE LA POSICIÓN 4 DE TABLA300
    MOV SI, OFFSET BEBA ; Puntero al contenido de BEBA
    MOV DI, OFFSET TABLA300 + 4 ; Dirección de destino en TABLA300
    MOV CX, 2 ; Número de bytes a copiar (BEBA es una palabra de 2 bytes)
    MOV AL, [SI] ; Obtener el primer byte
    MOV [DI], AL ; Copiar el primer byte a ES:DI
    MOV AL, [SI+1] ; Obtener el segundo byte
    MOV [DI+1], AL ; Copiar el segundo byte a ES:DI+1

    ; COPIAR EL BYTE MÁS SIGNIFICATIVO DE BEBA A LARGAVIDA_SBM2024
    MOV SI, OFFSET BEBA + 1 ; Puntero al byte más significativo de BEBA
    MOV DI, OFFSET LARGAVIDA_SBM2024 ; Dirección de destino en LARGAVIDA_SBM2024
    MOV AL, [SI] ; Obtener el byte
    MOV [DI], AL ; Copiar el byte a ES:DI

    ; FIN DEL PROGRAMA
    MOV AX, 4C00H
    INT 21H
INICIO ENDP

CODE ENDS
END INICIO
