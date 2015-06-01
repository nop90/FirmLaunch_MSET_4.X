

.nds
.create "build/arm9_code.bin", 0x23F00000
.arm
.align 4
;.code 32
;.text

;.global arm9_start
arm9_start:
	B               skipvars

;	@ offs 4, to be filled during runtime
	pa_arm9_entrypoint_backup: .word 0
	
.align 4
skipvars:
	STMFD           SP!, {R0-R12,LR}

    ldr r0, =0x20000000
    ldr r1, =0x21000000
    ldr r2, =0xffffffff
loop:
    str r2, [r0]
    add r0, r0, #4
    cmp r0, r1
    blt loop

	ldr r0,	=0x080549C4
	ldr r1, =0xE03B2000
	str r1, [r0]
	
	ldr r0,	=0x0804239C
	ldr r1, =0xE0082000
	str r1, [r0]
	
exit:
	LDMFD           SP!, {R0-R12,LR}
	
	LDR             PC, [pa_arm9_entrypoint_backup]
	
;.global arm9_end
arm9_end:
.pool
.close
