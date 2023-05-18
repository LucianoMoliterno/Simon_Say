	ORG   0      		;DIRECTIVA Origen del programa
	bsf   STATUS,5  	;CAMBIO DE BANCO para configurar el Micro
	clrf   TRISA      	;Todo en 0(8 bit)
	clrf   TRISB      	;Todo en 0(8 bit)
	movlw   b'1000111'
	movwf   option	         
	bsf   PORTA,0      	;para precionar entradas
	bsf   PORTA,1      	;para precionar
	bsf   PORTA,2      	;para precionar
	bsf   PORTA,3      	;para precionar 
	bsf   PORTA,4      	;para precionar  
       
	bcf   PORTB,0      	;Salidas
	bcf   PORTB,1
	bcf   PORTB,2
	bcf   PORTB,3
	bcf   PORTB,4

	bcf   STATUS,5   	;CAMBIO DE BANCO
   	movlw	.7
	movwf	CMCON
	;cierro el terminal de datos-------------------------------------------
	clrf   PORTA      ;TODO EN 0
	clrf   PORTB      ;TODO EN 0

	;comandos para la Funcion velocidad----------------------------------------
	movlw   .1
	movwf   2ah
	movlw   .2
	movwf   2bh
	movlw   .3
	movwf   2ch
	movlw   .4
	movwf   2dh
	movlw   .5
	movwf   2eh

	;configuraciones de los colores a prender--------------------------------------
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	call	demora1

	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0  
	call	demora1  
      
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0    
	call	demora1
       
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	call	demora1

	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0
	call	demora1

inicio  btfss   porta,0		;Empesando con el sistema de velocidades, a elegir velocidad por colores--------  
	goto   	NO      		;Sigue preguntando por los otros      
	call   	demora1     	;Si es si va por una velocidad de 1 segundo
no1     btfsc   porta,0      	;Pregunto si solto el boton.
	goto   	no1     		;pregunto cuando lo suelto
	movlw   .1      	;pongo .1 para indentificar la velocidades en la funcion de velocidad
	movwf   31H      	;variable entre .1 a .5
	goto   	F30      		;Funcion velocidad
  
NO      btfss   porta,1      	;pregunto por la segunda velocidad de 0,8 seg----------------------------------
	goto   NO2
	CALL   demora1      	;Si es si
NO3     btfsc   porta,1
	goto   	NO3      	;pregunto cuando lo suelto
	movlw   .2
	movwf   31H
	goto   	F30     		;Funcion velocidad

NO2     btfss   porta,2      	;pregunto por la tercera velocidad que es 0,6 seg------------------------------
	goto   	NO4
	call   	demora1
no5     btfsc   porta,2
	goto   	no5
	movlw   .3
	movwf   31H
	goto  	F30

NO4     btfss   porta,3      	;pregunto por la tercera velocidad que es 0,5 seg-------------------------------  
	goto   	no6
	call    demora1
no7     btfsc   porta,3
	goto  	no7
	movlw   .4
	movwf   31H
	goto   	F30
     
no6   	btfss   porta,4      	;pregunto por la tercera velocidad que es 0,4 seg-------------------------------
	goto   	no9      	;Me vuelvo para el principio (no se toco nada)
	call    demora1
no8     btfsc   porta,4
	goto   	no8
	movlw   .5
	movwf   31H
	goto   	F30

no9	movlw	.1
	addwf	49h,f
	movlw	.2
	addwf	48h,f
	call	demora3
	goto	inicio

	;Funcion aleatorio de desconteo de 49H-----------------------------------------------------------	
F30	clrf   PORTB      	;TODO EN 0
	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no209
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	aah		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	a9h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	f12		;funcion de saber si se preciono bien o no

no209	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no219
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	aah		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	a9h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	f12		;funcion de saber si se preciono bien o no
	
no219	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no229
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	aah		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	a9h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	f12		;funcion de saber si se preciono bien o no

no229	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no239
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	aah		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	a9h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	f12		;funcion de saber si se preciono bien o no

no239	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	F30
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	aah		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	a9h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	f12		

f12	;Segunda pregunta para la otra secuencia------------------------------------------------------
	bsf   portb,0      	;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      	;TODO EN 0 
	bsf   portb,1      	;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      	;TODO EN 0         
	bsf   portb,2      	;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      	;TODO EN 0           
	bsf   portb,3      	;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      	;TODO EN 0
	bsf   portb,4      	;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      	;TODO EN 0

Fram	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no119
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	abh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	a8h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p11		;funcion de saber si se preciono bien o no

no119	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no129
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	abh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	a8h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p11		;funcion de saber si se preciono bien o no
	
no129	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no139
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	abh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	a8h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p11		;funcion de saber si se preciono bien o no

no139	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no149
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	abh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	a8h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p11		;funcion de saber si se preciono bien o no

no149	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	fram
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	abh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	a8h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p11		
	       	
p11    ;Fin de la desconteo para lo aleatorio, empiesa el comando de velocidad---------------- 
	movfw   2AH  		   
	subwf   31H,W		;.1 - .1 deberia dar cero si se preciono porta,0
	btfss   status,2   	;Z = 1   el resultado dio cero
	goto   	NO99     	;Z no vale 0, pregunto por los otros
	movlw   .20      	;.20 es que repite 20 veses 50mseg, Si el resultado da cero la velocidad es de 1seg
	movwf   30h      	;Donde pongo el dato de .20, variable del timer
	movlw   .61      	;50 mseg
	movwf   31h      	;Donde pongo el dato de .61=50mseg, variable del timer
	goto   juego      	;Empiesa el juego

NO99    movfw   2BH      	;.2 - .1 deberia dar cero si se preciono porta,0----------------------------------
	subwf   31H,W
	btfss   status,2   	;Z = 1   el resultado dio cero
	goto   NO10      	;Z no vale 0, pregunto por los otros
	movlw   .16      	;.16 es que repite 16 veses 50mseg, Si el resultado da cero la velocidad es de 0,8seg
	movwf   30h      	;Donde pongo el dato de .16, variable del timer
	movlw   .61      	;50 mseg
	movwf   31h      	;Donde pongo el dato de .61=50mseg, variable del timer
	goto   juego      	;Empiesa el juego
   	
NO10    movfw   2CH  		;Comando de velocidad numero 3---------------------------------------------    
	subwf   31H,W		;.3 - .1 deberia dar cero si se preciono porta,0
	btfss   status,2   	;Z = 1   el resultado dio cero
	goto   NO11      	;Z no vale 0, pregunto por los otros
	movlw   .12      	;.12 es que repite 12 veses 50mseg, Si el resultado da cero la velocidad es de 0,6seg
	movwf   30h      	;Donde pongo el dato de .12, variable del timer
	movlw   .61      	;50 mseg
	movwf   31h      	;Donde pongo el dato de .61=50mseg, variable del timer
	goto   juego      	;Empiesa el juego
	
NO11    movfw   2DH		;Comando de velocidad numero 4---------------------------------------------
	subwf   31H,W		;.4 - .1 deberia dar cero si se preciono porta,0
	btfss   status,2   	;Z = 1   el resultado dio cero
	goto   NO12      	;Z no vale 0, pregunto por los otros
	movlw   .10      	;.10 es que repite 10 veses 50mseg, Si el resultado da cero la velocidad es de 0,5seg
	movwf   30h      	;Donde pongo el dato de .10, variable del timer
	movlw   .61      	;50 mseg
	movwf   31h      	;Donde pongo el dato de .61=50mseg, variable del timer
	goto   juego      	;Empiesa el juego
           	
NO12    movfw   2EH		;Comando de velocidad numero 5-------------------------------------------	
	subwf   31H,W		;.5 - .1 deberia dar cero si se preciono porta,0
	btfss   status,2   	;Z = 1   el resultado dio cero
	goto   inicio      	;Z no vale 0, pregunto por los otros
	movlw   .8      	;.8 es que repite 8 veses 50mseg, Si el resultado da cero la velocidad es de 0,4seg
	movwf   30h      	;Donde pongo el dato de .8, variable del timer
	movlw   .61      	;50 mseg
	movwf   31h      	;Donde pongo el dato de .61=50mseg, variable del timer
	goto   juego      	;Empiesa el juego
        	            	        
	;Inicio del juego-----------------------------------------------------------------------------------------        
juego   clrf   	portb    	;EMPIESA EL JUEGO Codigo de muestreo-------------------------------------  
	call	demora2
	movfw	aah
	movwf	portb
	call   	demorav      	;Demora variable
	clrf	portb     	;Apaga el verde
	call	demora2
	movfw	abh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movlw	.2
	movwf	20h

	bsf   portb,0      	;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      	;TODO EN 0 
	bsf   portb,1      	;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      	;TODO EN 0         
	bsf   portb,2      	;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      	;TODO EN 0           
	bsf   portb,3      	;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      	;TODO EN 0
	bsf   portb,4      	;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      	;TODO EN 0
j1	
	btfss   porta,0		;Primera pregunta--------------------------------------------------------	
	goto   no13		;si es no me voy a preguntar por los otros puertos
	movlw   .1		;si es si
	movwf   40h		;variable para restar despues
	bsf   portb,0		;Prende el color del puertob,0
      	call   demora1		;Anti rebote de 50mseg
w1	btfsc   porta,0		;primera pregunta aleatoria
	goto	w1
	goto	r11		;es la parte donde se le resta para hacer lo de aleatorio
				     	
no13    btfss   porta,1   	;pregunta por el otro pulsador------------------------------------------   
	goto    no14      	;si es no me voy a preguntar por los otros puertos
	movlw   .2      	;si es si
	movwf   40h      	;variable para restar despues
	bsf	portb,1      	;Prende el color del puertob,1
      	call	demora1		;Anti rebote de 50mseg
w2	btfsc   porta,1		;primera pregunta aleatoria
	goto	w2
	goto	r11         	

no14    btfss   porta,2      	;pregunta por el otro pulsador------------------------------------------
	goto   no15      	;si es no me voy a preguntar por los otros puertos
	movlw   .3      	;si es si
	movwf   40h      	;variable para restar despues
	bsf   portb,2      	;Prende el color del puertob,2
     	call   demora1      ;Anti rebote de 50mseg
w3	btfsc   porta,2      ;primera pregunta aleatoria
	goto	w3
	goto	r11
	
no15    btfss   porta,3      ;pregunta por el otro pulsador------------------------------------------
	goto   no16      ;si es no me voy a preguntar por los otros puertos
	movlw   .4      ;si es si
	movwf   40h      ;variable para restar despues
	bsf   portb,3      ;Prende el color del puertob,3         
      	call   demora1      ;Anti rebote de 50mseg
w4	btfsc   porta,3      ;primera pregunta aleatoria
	goto	w4
	goto	r11	   	

no16	btfss   porta,4      ;pregunta por el otro pulsador------------------------------------------
	goto    k1      ;si es no me voy a preguntar por los otros puertos
	movlw   .5      ;si es si
	movwf   40h      ;variable para restar despues
	bsf	portb,4      ;Prende el color del puertob,4 
	;Primera pregunta de la funcion aleatoria---------------------------------------------------------
	call   demora1      ;Anti rebote de 50mseg
w5	btfsc   porta,4      ;primera pregunta aleatoria
	goto	w5
	goto	r11
	
k1	movlw	.2		;para hacer el tiempo de aleatorio
	addwf	48h,f		;Se le suma .1 al 49h que es una memoria
	movlw	.1		;para hacer el tiempo de aleatorio
	addwf	49h,f		;Se le suma .1 al 49h que es una memoria
	call	demora3
	goto	j1		

	;Funcion aleatorio de desconteo de 49H-----------------------------------------------------------------
r11	call	demora1	
	clrf 	portb
R1	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no22
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	5ch		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	4ch		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp		;funcion de saber si se preciono bien o no

no22	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no23
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	5ch		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	4ch		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp		;funcion de saber si se preciono bien o no	

no23	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no24
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	5ch		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	4ch		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp		;funcion de saber si se preciono bien o no

no24	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no25
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	5ch		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	4ch		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp		;funcion de saber si se preciono bien o no

no25	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R1
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	5ch		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	4ch		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp		;funcion de saber si se preciono bien o no

	;configuraciones de los colores a prender
pp	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0

R2	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no26
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	5dh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	4dh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p		;funcion de saber si se preciono bien o no

no26	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no27
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	5dh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	4dh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p		;funcion de saber si se preciono bien o no
	
no27	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no28
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	5dh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	4dh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p		;funcion de saber si se preciono bien o no

no28	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no29
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	5dh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	4dh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p		;funcion de saber si se preciono bien o no

no29	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R2
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	5dh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	4dh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p		;funcion de saber si se preciono bien o no	

p   	movlw	.1		;Empiesa a preguntar si el pulsador presioado es el correcto--------------------
	subwf	20h,f
	btfss	status,2
	goto	no30
	movfw	40h
	subwf	a8h,w
	btfss	status,2
	goto	perdi
	goto	bien1

no30	movfw	40h		;varia dependiendo que boton precione (.1 deberia ser)
	subwf	a9h,w		;mantiene en forma permanente el .1
	btfss	status,2	;pregunta si da cero
	goto	Perdi		
	goto	j1
	
	;Segunda fase del simon say---------------------------------------------------------------------	
bien1	clrf   	portb      ;limpia el puerto b por las dudas
	movfw	aah
	movwf	portb
	call   	demorav      	;Demora variable
	clrf	portb     	;apaga el verde
	call	demora2
	movfw	abh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2		
	movfw	5ch
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5dh
	movwf	portb
	call	demorav
	clrf	portb
	movlw	.2
	movwf	20h
	movlw	.3
	movwf	6ch
	movlw	.4
	movwf	6dh

	;configuraciones de los colores a prender-----------------------------------------------
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0

	;Primera pregunta--------------------------------------------------------
j2	btfss   porta,0		;aprete el puerto A,0?
	goto   no31		;si es no me voy a preguntar por los otros puertos
	movlw   .1		;si es si
	movwf   40h		;variable para restar despues
	bsf   portb,0		;Prende el color del puertob,0
       	;Empiesa la funcion aleatoria--------------------------------------------
      	call   demora1		;Anti rebote de 50mseg
w6	btfsc   porta,0		;primera pregunta aleatoria
	goto	w6
	goto	r12		;es la parte donde se le resta para hacer lo de aleatorio		
		     
	;pregunta por el otro pulsador------------------------------------------
no31    btfss   porta,1      ;aprete el puerto A,1?
	goto    no32      ;si es no me voy a preguntar por los otros puertos
	movlw   .2      ;si es si
	movwf   40h      ;variable para restar despues
	bsf	portb,1      ;Prende el color del puertob,1
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call	demora1		;Anti rebote de 50mseg
w7	btfsc   porta,1		;primera pregunta aleatoria
	goto	w7
	goto	r12      

	;pregunta por el otro pulsador------------------------------------------
no32    btfss   porta,2      ;aprete el puerto A,2?
	goto   no33      ;si es no me voy a preguntar por los otros puertos
	movlw   .3      ;si es si
	movwf   40h      ;variable para restar despues
	bsf   portb,2      ;Prende el color del puertob,2
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      ;Anti rebote de 50mseg
w8	btfsc   porta,2      ;primera pregunta aleatoria
	goto	w8
	goto	r12
	                 
	;pregunta por el otro pulsador------------------------------------------
no33    btfss   porta,3     	 ;aprete el puerto A,3?
	goto   no787      	 ;si es no me voy a preguntar por los otros puertos
	movlw   .4     		 ;si es si
	movwf   40h      	;variable para restar despues
	bsf   portb,3      	;Prende el color del puertob,3         
	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      	;Anti rebote de 50mseg
w9	btfsc   porta,3      	;primera pregunta aleatoria
	goto	w9
	goto	r12	
   
	;pregunta por el otro pulsador------------------------------------------
no787	btfss   porta,4      ;aprete el puerto A,4?
	goto    k2      ;si es no me voy a preguntar por los otros puertos
	movlw   .5      ;si es si
	movwf   40h      ;variable para restar despues
	bsf	portb,4      ;Prende el color del puertob,4 
	;Primera pregunta de la funcion aleatoria---------------------------------------------------------
	call   demora1      ;Anti rebote de 50mseg
w10	btfsc   porta,4      ;primera pregunta aleatoria
	goto	w10
	goto	r12
	
k2	movlw	.2		;para hacer el tiempo de aleatorio
	addwf	48h,f		;Se le suma .1 al 49h que es una memoria
	movlw	.1		;para hacer el tiempo de aleatorio
	addwf	49h,f		;Se le suma .1 al 49h que es una memoria
	call	demora3
	goto	j2
	
	;Funcion aleatorio de desconteo de 49H-------------------------------------------------------------
r12	call	demora1	
	clrf 	portb
R3	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no35
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	5eh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	4eh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp2		;funcion de saber si se preciono bien o no

no35	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no36
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	5eh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	4eh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp2		;funcion de saber si se preciono bien o no
	
no36	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no37
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	5eh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	4eh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp2		;funcion de saber si se preciono bien o no

no37	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no38
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	5eh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	4eh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp2		;funcion de saber si se preciono bien o no

no38	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R3
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	5eh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	4eh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp2		;funcion de saber si se preciono bien o no

	;Es par la segunda variable que se pondra en la segunda fase---------------------------------------------
pp2	;configuraciones de los colores a prender
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0

R4	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no39
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	5fh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	4fh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p2		;funcion de saber si se preciono bien o no

no39	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no40
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	5fh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	4fh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p2		;funcion de saber si se preciono bien o no
	
no40	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no41
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	5fh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	4fh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p2		;funcion de saber si se preciono bien o no

no41	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no42
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	5fh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	4fh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p2		;funcion de saber si se preciono bien o no

no42	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R4
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	5fh		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	4fh		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p2		;funcion de saber si se preciono bien o no

	;Empiesa a preguntar si el pulsador presioado es el correcto-----------------------------------------------
p2   	movlw	.1
	subwf	6dh,f		;.3
	btfss	status,2
	goto	no43
	movfw	40h
	subwf	4dh,w
	btfss	status,2
	goto	perdi
	goto	bien2
		
no43	movlw	.1
	subwf	6ch,f
	btfss	status,2
	goto	no44
	movfw	40h
	subwf	4ch,w
	btfss	status,2
	goto	perdi
	goto	j2
		
no44	movlw	.1
	subwf	20h,f		;vale.2
	btfss	status,2
	goto	no45
	movfw	40h
	subwf	a8h,w
	btfss	status,2
	goto	perdi
	goto	j2

no45	movfw	40h		;varia dependiendo que boton precione (.1 deberia ser)
	subwf	a9h,w		;mantiene en forma permanente el .1
	btfss	status,2	;pregunta si da cero
	goto	Perdi		
	goto	j2	


	;tercera fase del simon say---------------------------------------------------------------------	
bien2	clrf   	portb      ;limpia el puerto b por las dudas
	movfw	aah
	movwf	portb
	call   	demorav      	;Demora variable
	clrf	portb     	;apaga el verde
	call	demora2
	movfw	abh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2		
	movfw	5ch
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5dh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2

	movfw	5eh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5fh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2	
	movlw	.2
	movwf	20h
	movlw	.3
	movwf	6ch
	movlw	.4
	movwf	6dh
	movlw	.5
	movwf	6eh
	movlw	.6
	movwf	6fh	

	;configuraciones de los colores a prender-----------------------------------------------
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0     

	;Primera pregunta--------------------------------------------------------
j3	btfss   porta,0		;aprete el puerto A,0?
	goto   no46		;si es no me voy a preguntar por los otros puertos
	movlw   .1		;si es si
	movwf   40h		;variable para restar despues
	bsf   portb,0		;Prende el color del puertob,0
       	;Empiesa la funcion aleatoria--------------------------------------------
      	call   demora1		;Anti rebote de 50mseg
w11	btfsc   porta,0		;primera pregunta aleatoria
	goto	w11
	goto	r13		;es la parte donde se le resta para hacer lo de aleatorio		
		     
	;pregunta por el otro pulsador------------------------------------------
no46    btfss   porta,1      ;aprete el puerto A,1?
	goto    no47      ;si es no me voy a preguntar por los otros puertos
	movlw   .2      ;si es si
	movwf   40h      ;variable para restar despues
	bsf	portb,1      ;Prende el color del puertob,1
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call	demora1		;Anti rebote de 50mseg
w12	btfsc   porta,1		;primera pregunta aleatoria
	goto	w12
	goto	r13
         
	;pregunta por el otro pulsador------------------------------------------
no47    btfss   porta,2      ;aprete el puerto A,2?
	goto   no48	     ;si es no me voy a preguntar por los otros puertos
	movlw   .3      ;si es si
	movwf   40h      ;variable para restar despues
	bsf   portb,2      ;Prende el color del puertob,2
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      ;Anti rebote de 50mseg
w13	btfsc   porta,2      ;primera pregunta aleatoria
	goto	w13
	goto	r13
	                 
	;pregunta por el otro pulsador------------------------------------------
no48    btfss   porta,3      	;aprete el puerto A,3?
	goto   no49      	;si es no me voy a preguntar por los otros puertos
	movlw   .4      	;si es si
	movwf   40h      	;variable para restar despues
	bsf   portb,3      	;Prende el color del puertob,3         
	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      	;Anti rebote de 50mseg
w14	btfsc   porta,3      	;primera pregunta aleatoria
	goto	w14
 	goto	r13	
  
	;pregunta por el otro pulsador------------------------------------------
no49	btfss   porta,4      	;aprete el puerto A,4?
	goto    k3      	;si es no me voy a preguntar por los otros puertos
	movlw   .5      	;si es si
	movwf   40h      	;variable para restar despues
	bsf	portb,4      	;Prende el color del puertob,4 
	;Primera pregunta de la funcion aleatoria---------------------------------------------------------
	call   demora1      	;Anti rebote de 50mseg
w15	btfsc   porta,4     	;primera pregunta aleatoria
	goto	w15
	goto	r13
	
k3	movlw	.2		;para hacer el tiempo de aleatorio
	addwf	48h,f		;Se le suma .1 al 49h que es una memoria
	movlw	.1		;para hacer el tiempo de aleatorio
	addwf	49h,f		;Se le suma .1 al 49h que es una memoria
	call	demora3
	goto	j3	

	;Funcion aleatorio de desconteo de 49H-------------------------------------------------------------
r13	call	demora1	
	clrf 	portb
R5	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no50
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	60h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	41h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp3		;funcion de saber si se preciono bien o no

no50	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no51
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	60h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	41h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp3		;funcion de saber si se preciono bien o no
	
no51	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no52
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	60h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	41h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp3		;funcion de saber si se preciono bien o no

no52	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no53
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	60h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	41h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp3		;funcion de saber si se preciono bien o no

no53	movlw	.1		;Repite la operacion hasta dar cero
	subwf	49h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R5
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	60h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	41h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	pp3		;funcion de saber si se preciono bien o no

	;Funcion aleatorio de desconteo de 49H-------------------------------------------------------------
pp3	;configuraciones de los colores a prender
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0

R6	clrf	portb
	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no59
	movfw	3ah		;mantiene el color adentro (verde)
	movwf	61h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.1		;el .1 equivale al color
	movwf	42h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p4		;funcion de saber si se preciono bien o no

no59	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no60
	movfw	3bh		;mantiene el color adentro (verde)
	movwf	61h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.2		;el .1 equivale al color
	movwf	42h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p4		;funcion de saber si se preciono bien o no
	
no60	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no61
	movfw	3ch		;mantiene el color adentro (verde)
	movwf	61h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.3		;el .1 equivale al color
	movwf	42h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p4		;funcion de saber si se preciono bien o no

no61	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	no62
	movfw	3dh		;mantiene el color adentro (verde)
	movwf	61h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.4		;el .1 equivale al color
	movwf	42h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p4		;funcion de saber si se preciono bien o no

no62	movlw	.1		;Repite la operacion hasta dar cero
	subwf	48h,f
	btfss	status,2	;pregunta si la cuenta dio cero
	goto	R6
	movfw	3eh		;mantiene el color adentro (verde)
	movwf	61h		;lo usara despues para mostrarlo en la segunda fase
	movlw	.5		;el .1 equivale al color
	movwf	42h		;se guardara en 4bh para luego en la resta se dira si fue correcto o no
	goto	p4		;funcion de saber si se preciono bien o no

	;Empiesa a preguntar si el pulsador presioado es el correcto-----------------------------------------------
p4	movlw	.1
	subwf	6fh,f		;.6
	btfss	status,2
	goto	no54
	movfw	40h
	subwf	4fh,w
	btfss	status,2
	goto	perdi
	goto	bien3

no54	movlw	.1
	subwf	6eh,f		;.5
	btfss	status,2
	goto	no55
	movfw	40h
	subwf	4eh,w
	btfss	status,2
	goto	perdi
	goto	j3

no55	movlw	.1
	subwf	6dh,f		;.4
	btfss	status,2
	goto	no56
	movfw	40h
	subwf	4dh,w
	btfss	status,2
	goto	perdi
	goto	j3
			
no56	movlw	.1
	subwf	6ch,f		;.3
	btfss	status,2
	goto	no57
	movfw	40h
	subwf	4ch,w
	btfss	status,2
	goto	perdi
	goto	j3
		
no57	movlw	.1
	subwf	20h,f		;vale.2
	btfss	status,2
	goto	no58
	movfw	40h
	subwf	a8h,w		;vale .4 que es el color rojo
	btfss	status,2
	goto	perdi
	goto	j3

no58	movfw	40h		;varia dependiendo que boton precione (.1 deberia ser)
	subwf	a9h,w		;mantiene en forma permanente el .1
	btfss	status,2	;pregunta si da cero
	goto	Perdi		
	goto	j3	

	;cuarta fase del simon say---------------------------------------------------------------------	
bien3	clrf	portb
	movfw	aah
	movwf	portb
	call   	demorav      	;Demora variable
	clrf	portb     	;apaga el verde
	call	demora2
	movfw	abh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2		
	movfw	5ch
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5dh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5eh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	5fh
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2

	movfw	60h		;Variable nueva
	movwf	portb
	call	demorav
	clrf	portb
	call	demora2
	movfw	61h		;variable nueva
	movwf	portb
	call	demorav
	clrf	portb

	movlw	.2
	movwf	20h
	movlw	.3
	movwf	6ch
	movlw	.4
	movwf	6dh
	movlw	.5
	movwf	6eh
	movlw	.6
	movwf	6fh

	movlw	.7
	movwf	62h		;nueva! para restar alfinal
	movlw	.8
	movwf	63h		;nueva! para restar alfinal
		
	;configuraciones de los colores a prender----------------------------------------------------------------
	bsf   portb,0      ;Verde prende
	movfw   portb
	movwf   3ah
	clrf   PORTB      ;TODO EN 0 
	bsf   portb,1      ;Amarillo prende
	movfw   portb
	movwf   3bh
	clrf   PORTB      ;TODO EN 0          
	bsf   portb,2      ;Azul prende
	movfw   portb
	movwf   3ch
	clrf   PORTB      ;TODO EN 0           
	bsf   portb,3      ;Rojo prende
	movfw   portb
	movwf   3dh
	clrf   PORTB      ;TODO EN 0
	bsf   portb,4      ;Blanco prende
	movfw   portb
	movwf   3eh
	clrf   PORTB      ;TODO EN 0 
    
	;Primera pregunta--------------------------------------------------------
j4	btfss   porta,0		;aprete el puerto A,0?
	goto   no591		;si es no me voy a preguntar por los otros puertos
	movlw   .1		;si es si
	movwf   40h		;variable para restar despues
	bsf   portb,0		;Prende el color del puertob,0
       	;Empiesa la funcion aleatoria--------------------------------------------
      	call   demora1		;Anti rebote de 50mseg
w16	btfsc   porta,0		;primera pregunta aleatoria
	goto	w16
	goto	p5		;es la parte donde se le resta para hacer lo de aleatorio		
		     
	;pregunta por el otro pulsador------------------------------------------
no591    btfss   porta,1      	;aprete el puerto A,1?
	goto    no601      	;si es no me voy a preguntar por los otros puertos
	movlw   .2      	;si es si
	movwf   40h      	;variable para restar despues
	bsf	portb,1      ;Prende el color del puertob,1
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call	demora1		;Anti rebote de 50mseg
w17	btfsc   porta,1		;primera pregunta aleatoria
	goto	w17
	goto	p5
         
	;pregunta por el otro pulsador------------------------------------------
no601    btfss   porta,2      ;aprete el puerto A,2?
	goto   no611	     ;si es no me voy a preguntar por los otros puertos
	movlw   .3      ;si es si
	movwf   40h      ;variable para restar despues
	bsf   portb,2      ;Prende el color del puertob,2
      	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      ;Anti rebote de 50mseg
w18	btfsc   porta,2      ;primera pregunta aleatoria
	goto	w18
	goto	p5
	                 
	;pregunta por el otro pulsador------------------------------------------
no611    btfss   porta,3      	;aprete el puerto A,3?
	goto   no622      	;si es no me voy a preguntar por los otros puertos
	movlw   .4      	;si es si
	movwf   40h      	;variable para restar despues
	bsf   portb,3      	;Prende el color del puertob,3         
	;Primera pregunta de la funcion aleatoria-------------------------------
      	call   demora1      	;Anti rebote de 50mseg
w19	btfsc   porta,3      	;primera pregunta aleatoria
	goto	w19
	goto	p5	
  
	;pregunta por el otro pulsador------------------------------------------
no622	btfss   porta,4      	;aprete el puerto A,4?
	goto    k4      	;si es no me voy a preguntar por los otros puertos
	movlw   .5      	;si es si
	movwf   40h      	;variable para restar despues
	bsf	portb,4      	;Prende el color del puertob,4 
	;Primera pregunta de la funcion aleatoria---------------------------------------------------------
	call   demora1      	;Anti rebote de 50mseg
w20	btfsc   porta,4     	;primera pregunta aleatoria
	goto	w20
	goto	p5
	
k4	movlw	.2		;para hacer el tiempo de aleatorio
	addwf	48h,f		;Se le suma .1 al 49h que es una memoria
	movlw	.1		;para hacer el tiempo de aleatorio
	addwf	49h,f		;Se le suma .1 al 49h que es una memoria
	call	demora3
	goto	j4

	;Empiesa a preguntar si el pulsador presioado es el correcto-----------------------------------------------
p5	clrf	portb
	call	demora1	
	movlw	.1
	subwf	63h,f		;.8
	btfss	status,2
	goto	no72
	movfw	40h
	subwf	42h,w
	btfss	status,2
	goto	perdi
	goto	win

no72	movlw	.1
	subwf	62h,f		;.7
	btfss	status,2
	goto	no73
	movfw	40h
	subwf	41h,w
	btfss	status,2
	goto	perdi
	goto	j4

no73	movlw	.1
	subwf	6fh,f		;.6
	btfss	status,2
	goto	no74
	movfw	40h
	subwf	4fh,w
	btfss	status,2
	goto	perdi
	goto	j4

no74	movlw	.1
	subwf	6eh,f		;.5
	btfss	status,2
	goto	no75
	movfw	40h
	subwf	4eh,w
	btfss	status,2
	goto	perdi
	goto	j4

no75	movlw	.1
	subwf	6dh,f		;.4
	btfss	status,2
	goto	no76
	movfw	40h
	subwf	4dh,w
	btfss	status,2
	goto	perdi
	goto	j4
		
no76	movlw	.1		;.3
	subwf	6ch,f
	btfss	status,2
	goto	no788
	movfw	40h
	subwf	4ch,w
	btfss	status,2
	goto	perdi
	goto	j4
		
no788	movlw	.1		;Descuenta .1
	subwf	20h,f		;vale.2
	btfss	status,2
	goto	no79
	movfw	40h
	subwf	a8h,w
	btfss	status,2
	goto	perdi
	goto	j4

no79	movfw	40h		;varia dependiendo que boton precione (.1 deberia ser)
	subwf	a9h,w		;mantiene en forma permanente el .1
	btfss	status,2	;pregunta si da cero
	goto	Perdi		
	goto	j4	

	;Perdiste (Game Over)----------------------------------------------------------------------------------------
Perdi	bsf	portb,0		;prende todos los led
	bsf	portb,1
	bsf	portb,2
	bsf	portb,3
	bsf	portb,4
	call 	demora2
	clrf	portb		;apagar todos los led
	call 	demora2
	bsf	portb,0		;prende todos los led
	bsf	portb,1
	bsf	portb,2
	bsf	portb,3
	bsf	portb,4
	call 	demorav
	clrf	portb		;apagar todos los led
	call 	demora2
	bsf	portb,0		;prende todos los led
	bsf	portb,1
	bsf	portb,2
	bsf	portb,3
	bsf	portb,4
	call 	demora2
	clrf	portb		;apagar todos los led
	goto	inicio
	;Ganaste (Win)------------------------------------------------------------
win	bsf	portb,0
	call	demorav
	bsf	portb,1
	call	demorav
	bsf	portb,2
	call	demorav
	bsf	portb,3
	call	demorav
	bsf	portb,4
	call	demorav
	clrf	portb
	call 	demorav
	bsf	portb,0
	bsf	portb,1
	bsf	portb,2
	bsf	portb,3
	bsf	portb,4
	call 	demorav
	clrf	portb
	goto	inicio
	;Demoras de tiempos------------------------------------------------------
demorav	
	clrf	TMR0      	;TMR0=0 limpio el timer
	movfw   30h		;va 30H
	movwf   7FH      	;permanente
pipa    bcf	intcon,2
	movlw	.61		;variable (tengo .61 = 50mseg) ESTABA 31H
	movwf   TMR0		;Permanente, 31h le pasa el .61 al timer
ni      btfss   intcon,2	;cuenta hasta llegar a cero
	goto	ni		;repite hasta llegar a cero
	goto	si9		;llego a cero intcon,2
si9     decfsz	7FH,f		;es la variable que se resta
	goto	pipa
	return          	;vuelve de donde vino----------------------------
demora1	
	clrf	TMR0      	;TMR0=0 limpio el timer
	movlw   .3		;con esto hace un demora de 500 mseg
	movwf   78H      	;permanente
pipa2   bcf	intcon,2
	movlw	.61		;variable (tengo .61 = 50mseg) ESTABA 31H
	movwf   TMR0		;Permanente, 31h le pasa el .61 al timer
niii19	btfss   intcon,2	;cuenta hasta llegar a cero
	goto	niii19		;repite hasta llegar a cero
	goto	sizzz		;llego a cero intcon,2
sizzz	decfsz	78H,f		;es la variable que se resta
	goto	pipa2                                            
	return	
	return			;;vuelve de donde vino----------------------------
demora2	
	clrf	TMR0      	;TMR0=0 limpio el timer
	movlw   .4		;con esto hace un demora de 500 mseg
	movwf   78H      	;permanente
pipa9   bcf	intcon,2
	movlw	.61		;variable (tengo .61 = 50mseg) ESTABA 31H
	movwf   TMR0		;Permanente, 31h le pasa el .61 al timer
niii2   btfss   intcon,2	;cuenta hasta llegar a cero
	goto	niii2		;repite hasta llegar a cero
	goto	siz		;llego a cero intcon,2
siz     decfsz	78H,f		;es la variable que se resta
	goto	pipa9
	return			
demora3		
	clrf	TMR0      	;TMR0=0 limpio el timer
	movlw   .1		;con esto hace un demora de 500 mseg
	movwf   47H      	;permanente
pipa3   bcf	intcon,2
	movlw	.255		;variable (tengo .61 = 50mseg) ESTABA 31H
	movwf   TMR0		;Permanente, 31h le pasa el .61 al timer
niiii   btfss   intcon,2	;cuenta hasta llegar a cero
	goto	niiii		;repite hasta llegar a cero
	goto	sizz		;llego a cero intcon,2
sizz    decfsz	47H,f		;es la variable que se resta
	goto	pipa3
	return
	;vuelve de donde vino-----------------------------------------------------------