DATOS SEGMENT
    ; Definición de la matriz 3x3
    matriz DW 1, 0, 0, 0, 1, 0, 0, 0, 1
    ; Variable para almacenar el resultado ("SI" o "NO")
    resultado DB 3 DUP ('$')
    ; Constantes para imprimir la matriz en formato correcto
    formato DB "| %4d %4d %4d |", 13, 10, "| %4d %4d %4d |", 13, 10, "| %4d %4d %4d |", 13, 10, "C= |", 13, 10, "$"
    ; Constantes para el mensaje de resultado
    mensajeSI DB "ES IDENTIDAD", 13, 10, "$"
    mensajeNO DB "NO ES IDENTIDAD", 13, 10, "$"
DATOS ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATOS

INICIO PROC
    MOV AX, DATOS
    MOV DS, AX
    
    ; Imprimir la matriz original
    MOV SI, OFFSET matriz
    MOV DI, OFFSET formato
    CALL imprimirMatriz
    
    ; Llamar a la subrutina para verificar si la matriz es identidad
    CALL verificarIdentidad
    
    ; Imprimir el mensaje de resultado
    MOV DX, OFFSET resultado
    MOV AH, 9
    INT 21H
    
    ; Salir del programa
    MOV AX, 4C00H
    INT 21H
INICIO ENDP

imprimirMatriz PROC
    ; Imprimir cada elemento de la matriz
    MOV CX, 9 ; Número total de elementos en la matriz
    imprimir_elemento:
        MOV AX, [SI] ; Cargar el elemento en AX
        PUSH CX ; Guardar el contador de elementos
        CALL imprimirNumero ; Imprimir el elemento
        POP CX ; Restaurar el contador de elementos
        ADD SI, 2 ; Mover al siguiente elemento
        DEC CX ; Decrementar el contador
        CMP CX, 0 ; ¿Se han impreso todos los elementos?
        JNZ imprimir_elemento ; Si no, continuar imprimiendo
    RET
imprimirMatriz ENDP

imprimirNumero PROC
    ; Convertir el número en ASCII y almacenar la cadena en resultado
    MOV BX, 10 ; Base para la división
    MOV DI, OFFSET resultado ; Puntero al resultado
    imprimir_digito:
        XOR DX, DX ; Limpiar DX para dividir
        DIV BX ; Dividir AX por 10
        ADD DL, '0' ; Convertir el resto en dígito ASCII
        MOV [DI], DL ; Almacenar el dígito en el resultado
        INC DI ; Avanzar al siguiente byte
        TEST AX, AX ; ¿Se ha terminado de dividir?
        JNZ imprimir_digito ; Si no, continuar
    ; Invertir la cadena de resultado
    MOV SI, OFFSET resultado ; Puntero al principio de la cadena
    MOV DI, OFFSET resultado + 2 ; Puntero al final de la cadena
    reverso:
        CMP SI, DI ; ¿Los punteros se cruzaron?
        JAE imprimir_cadena ; Si sí, terminar
        MOV AL, [SI] ; Intercambiar los caracteres
        MOV AH, [DI]
        MOV [SI], AH
        MOV [DI], AL
        INC SI ; Avanzar hacia adelante
        DEC DI ; Retroceder hacia atrás
        JMP reverso ; Repetir el proceso
    imprimir_cadena:
        MOV DX, OFFSET resultado ; Puntero al resultado
        MOV AH, 9 ; Función de escritura en pantalla
        INT 21H ; Llamar a la interrupción de DOS
    RET
imprimirNumero ENDP

verificarIdentidad PROC
    ; Comparar cada elemento con la matriz identidad
    MOV SI, OFFSET matriz ; Puntero a la matriz
    MOV CX, 9 ; Número total de elementos en la matriz
    verificar_elemento:
        CMP WORD PTR [SI], 1 ; ¿El elemento es igual a 1?
        JNE no_es_identidad ; Si no, la matriz no es identidad
        ADD SI, 2 ; Mover al siguiente elemento
        DEC CX ; Decrementar el contador
        CMP CX, 0 ; ¿Se han verificado todos los elementos?
        JNZ verificar_elemento ; Si no, continuar verificando
        ; Si todos los elementos son 1, la matriz es identidad
        MOV DX, OFFSET mensajeSI ; Puntero al mensaje de resultado
        JMP imprimirMensaje ; Imprimir el mensaje y salir
    no_es_identidad:
        MOV DX, OFFSET mensajeNO ; Puntero al mensaje de resultado
    imprimirMensaje:
        MOV AH, 9 ; Función de escritura en pantalla
        INT 21H ; Llamar a la interrupción de DOS
    RET
verificarIdentidad ENDP

CODE ENDS
END INICIO
