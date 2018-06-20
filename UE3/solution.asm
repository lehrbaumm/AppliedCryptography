;Baby Step Giant Step Algorithm in x86 ASM
;Maximilian Lehrbaum - 2017
;
;

extern printf
extern malloc
extern exit


SECTION .data
msg:		db	"%llu",10, 0
;log_num:	equ	37
log_num: 	equ	1059878588
;class:		equ	131
class:		equ	3696837919
;base:		equ	6
base:		equ	3116701003


SECTION .bss
num:		resq	1
M:		resq	1
TMP:		resq	1
SQRT_TMP:	resq	1
i:		resq	1
INV_M:		resq	1
J:		resq	1
LIST_I:		resq	1
I:		resq	1
old:		resw	1


SECTION	.text
	global main
	print_num:
		ENTER 40, 0
		mov rsi, [num]
		mov rdi, msg
		call printf
		LEAVE
		ret
	main:
	get_m:
		mov RCX, class
		DEC RCX
		MOV [TMP], RCX
		FSTCW [old]
		OR word [old], 0x0800
		FLDCW [old]
		FILD qword [TMP]
		FSQRT
		FRNDINT
		FISTTP qword [SQRT_TMP] 
		mov RCX, [SQRT_TMP]
		mov [M], RCX
	baby_step:
		MOV RAX, [M]
		INC RAX
		MOV RCX,  8
		MUL RCX
		MOV RDI, RAX
		call malloc
		TEST RAX, RAX
		JZ exit
		MOV [LIST_I], RAX
		MOV R9, RAX
		MOV R8, 0
		MOV QWORD [R9+8*R8], 1
		INC R8
		MOV R11, base
		MOV [R9+8*R8], R11
		MOV RCX, [M]
		DEC RCX
		MOV RAX, base
		step_loop:
			MOV [i], RCX
			INC R8
			MOV RBX, base
			MUL RBX
			MOV RBX, class
			DIV RBX
			MOV [R9+8*R8], RDX
			MOV RAX, RDX
			MOV RCX, [i]
			LOOP step_loop
	giant_step:
	get_inv:
	;Need to implement small version of euklid
		XOR RDX, RDX
		MOV RAX, class
		MOV RBX, base
		MOV qword R8, 0
		MOV qword R9, 1
		inv_loop:
			CMP RBX, 1
			JE end_inv
			DIV RBX
			MOV R10, RDX
			MUL R9
			ADD R8, RAX
			XCHG R8, R9
			XOR RDX, RDX
			MOV RAX, R10
			XCHG RAX, RBX
			JMP inv_loop
	end_inv:
		MOV [INV_M], R9
		power_12:
			MOV RAX, 1
			MOV RCX, [M]
			power_loop:
				MOV RBX, [INV_M]
				MUL RBX
				MOV RBX, class
				DIV RBX
				XOR RAX, RAX
				XCHG RAX, RDX
				loop power_loop
			MOV [INV_M], RAX
		giant_loop_prepare:
			MOV RBX, 1
			MOV RAX, log_num
			XOR RDX, RDX
			MOV RCX, 0
			MOV R9, class
			giant_loop:
				MUL RBX
				DIV R9
				MOV RAX, RDX
				XOR RDX, RDX
				search:
				MOV [J], RCX ;Save J counter
				MOV RCX, [M]
				DEC RCX, 
				MOV R10, [LIST_I]
				search_loop:
					MOV [I], ECX
					MOV RBX, RAX
					MOV RDX, [R10+8*RCX]
					CMP RBX, RDX
					JE found
					MOV RAX, RBX
					DEC RCX
					JNS search_loop
				MOV RCX, [J]
				INC RCX
				MOV RBX, [INV_M]
				XOR RDX, RDX
				jmp giant_loop
		found:
				MOV RAX, [J]
				MOV RBX, [M]
				MUL RBX
				MOV RBX, [I]
				ADD RAX, RBX
				MOV [num], RAX
				call print_num
	exit_process:
		MOV RSI, 0
		call exit
