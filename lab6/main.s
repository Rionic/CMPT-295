	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Error:  sum mismatch"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"Sample %d completed in %d cycles.\n"
	.section	.rodata.str1.1
.LC2:
	.string	"Average of %ld cycles.\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB38:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	xorl	%eax, %eax
	movl	$A, %ebx
	call	time
	movl	%eax, %edi
	call	srand
	movl	$0, Q(%rip)
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand
	cltd
	shrl	$22, %edx
	addl	%edx, %eax
	andl	$1023, %eax
	subl	%edx, %eax
	subl	$512, %eax
	testl	%eax, %eax
	movl	%eax, (%rbx)
	jle	.L2
	addl	%eax, Q(%rip)
.L2:
	addq	$4, %rbx
	cmpq	$A+1000, %rbx
	jne	.L3
	movl	$cycles, %ebp
	movl	$cycles+80, %r12d
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L4:
	subl	start_time(%rip), %esi
	addq	$4, %rbp
	movl	%esi, -4(%rbp)
	cmpq	%rbp, %r12
	je	.L13
.L5:
#APP
# 39 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	movl	$A, %edi
	movl	%esi, start_time(%rip)
	movl	$250, %esi

	call	sum_plus

	movl	%eax, %edi
	movl	%eax, P(%rip)
#APP
# 48 "main.c" 1
	cpuid
	rdtscp
	movl %eax, %esi
	
# 0 "" 2
#NO_APP
	cmpl	Q(%rip), %edi
	movl	%esi, end_time(%rip)
	je	.L4
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	movl	$.LC0, %edi
	jmp	perror
.L13:
	.cfi_restore_state
	movq	$0, total(%rip)
	movl	$1, %ebx
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L6:
	addq	$1, %rbx
	cmpq	$21, %rbx
	je	.L14
.L7:
	movl	cycles-4(,%rbx,4), %ecx
	cmpl	$4000, %ecx
	jg	.L6
	movl	%ebx, %edx
	xorl	%eax, %eax
	movl	$.LC1, %esi
	movl	$1, %edi
	call	__printf_chk
	movslq	cycles-4(,%rbx,4), %rax
	addq	$1, %rbx
	addq	%rax, total(%rip)
	cmpq	$21, %rbx
	jne	.L7
.L14:
	movq	total(%rip), %rax
	movl	$20, %ecx
	movl	$.LC2, %esi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	cqto
	movl	$1, %edi
	idivq	%rcx
	popq	%r12
	.cfi_def_cfa_offset 8
	movq	%rax, %rdx
	xorl	%eax, %eax
	jmp	__printf_chk
	.cfi_endproc
.LFE38:
	.size	main, .-main
	.globl	end_time
	.data
	.align 4
	.type	end_time, @object
	.size	end_time, 4
end_time:
	.long	125
	.globl	start_time
	.align 4
	.type	start_time, @object
	.size	start_time, 4
start_time:
	.long	150
	.comm	total,8,8
	.comm	cycles,80,32
	.comm	Q,4,4
	.comm	P,4,4
	.comm	A,1000,32
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
