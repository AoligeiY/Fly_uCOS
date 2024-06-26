RCC_AHB1ENR EQU 0x40023830    
GPIOx_MODER EQU 0x40020000    
GPIOx_OTYPER EQU 0x40020004   
GPIOx_OSPEED EQU 0x40020008   
GPIOx_ODR EQU 0x40020014     
	
	
		AREA EXAMPLE,CODE,READONLY
		EXPORT RCC_init
		EXPORT LED_init
		EXPORT LED_TOGGLE
		EXPORT Delay
			
		ENTRY
		
RCC_init

	PUSH {R0,R1,LR}
	
	LDR R0,=RCC_AHB1ENR
	ORR R0,R0,#0X01
	LDR R1,=RCC_AHB1ENR
	STR R0,[R1]
	
	POP {R0,R1,PC}


LED_init

	PUSH {R0,R1,R2,R3,R4,LR}
	
	LDR R0,=GPIOx_MODER  
	BIC R0,R0,#0xffffffff
	ORR R0,R0,#0x00000400
	LDR R1,=GPIOx_MODER
	STR R0,[R1]
	
	
	LDR R2,=GPIOx_ODR     
	BIC R0,R0,#0xffffffff
	ORR R0,R0,#0x0020
	LDR R2,=GPIOx_ODR
	STR R0,[R2]
	
	LDR R3,=GPIOx_OTYPER  
	BIC R0,R0,#0xffffffff
	ORR R0,#0x0020
	LDR R3,=GPIOx_OTYPER
	STR R0,[R3]
	
	LDR R4,=GPIOx_OSPEED  
	BIC R0,R0,#0xffffffff
	ORR R0,#0x00008000
	LDR R4,=GPIOx_OTYPER
	STR R0,[R4]
	
	POP {R0,R1,R2,R3,R4,PC}
	
LED_TOGGLE

	PUSH {R0,R1,R2,R3,R4,LR}
	
	LDR R1,=GPIOx_ODR
	LDR R0,[R1]
	MOV R1,#(1<<21)
	EOR R0,R0,R1
	LDR R1,=GPIOx_ODR
	STR R0,[R1]
	
	POP {R0,R1,R2,R3,R4,PC}
	
Delay
	PUSH {R0,R1,LR}
	
	MOVS R0,#0
	MOVS R1,#0


DelayLoop0

		ADDS R0,R0,#1
		CMP R0,#330
		BCC DelayLoop0
		
		MOVS R0,#0
		ADDS R1,R1,#1
		CMP R1,#330
		BCC DelayLoop0
		
		MOVS R0, #0
		MOVS R1, #0
		ADDS R2, R2, #1
		CMP R2, #15
		BCC DelayLoop0
		
		POP {R0,R1,PC}
		
		NOP
		END
			
			