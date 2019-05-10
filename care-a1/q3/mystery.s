	.globl mystery	#rdi=char *str,%esi=int n,eax=int RV
mystery:
	movl	$0, %eax			#eax=0
	leaq	(%rdi, %rsi), %rcx	#rcx=rdi + rsi
								#rcx=M[M[str[0]]+n]
loop:		
	cmpq	%rdi, %rcx		#rcx ? str | 86 ? 71
	jle		endl			#jmp if rcx<=str
	decq	%rcx			#rcx--
	cmpb	$0x6f, (%rcx)	#*rcx ? 0x6f
	jne		loop			#jmp if M[rcx]!=0x6f
	incl	%eax			#return value++
	jmp		loop			#jmp to loop

endl:						#jmp if rcx<=str
	ret						#return (eax)

