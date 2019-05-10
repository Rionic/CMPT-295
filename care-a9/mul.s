	.file	"mul.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Incompatible multiplication: %d x %d times a %d x %d\n"
	.text
	.p2align 4,,15
	.globl	mul
	.type	mul, @function
mul:
.LFB38:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	movl	%esi, %r14d
	pushq	%rbx
	movl	%edx, %r12d
	movl	%r9d, %r13d
	subq	$56, %rsp
	.cfi_offset 3, -56
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	%r8d, %edx
	jne	.L26
	movq	%rdi, %rbx
	movl	%r9d, %esi
	movl	%r14d, %edi
	movq	%rcx, %r15
	call	newMatrix
	testq	%rax, %rax
	je	.L1
	movslq	%r13d, %rcx
	movslq	%r12d, %rsi
	salq	$2, %rcx
	leaq	0(,%rsi,4), %rdx
	imulq	%rsi, %rcx
	addq	$18, %rcx
	andq	$-16, %rcx
	subq	%rcx, %rsp
	testl	%r12d, %r12d
	movq	%rsp, %r8
	movq	%r8, -80(%rbp)
	jle	.L4
	leal	-1(%r12), %ecx
	leal	-1(%r13), %r9d
	xorl	%edi, %edi
	leaq	4(,%rcx,4), %r10
	addq	$1, %r9
	.p2align 4,,10
	.p2align 3
.L5:
	xorl	%ecx, %ecx
	testl	%r13d, %r13d
	jle	.L8
	.p2align 4,,10
	.p2align 3
.L6:
	movq	(%r15,%rcx,8), %rsi
	movl	(%rsi,%rdi), %esi
	movl	%esi, (%r8,%rcx,4)
	addq	$1, %rcx
	cmpq	%r9, %rcx
	jne	.L6
.L8:
	addq	$4, %rdi
	addq	%rdx, %r8
	cmpq	%r10, %rdi
	jne	.L5
.L4:
	testl	%r14d, %r14d
	jle	.L1
	leal	-1(%r14), %ecx
	movq	%rbx, %r15
	leal	-1(%r12), %esi
	movq	%rax, %r9
	movq	%rax, -88(%rbp)
	leaq	8(%rbx,%rcx,8), %rbx
	leal	-1(%r13), %ecx
	leaq	4(,%rsi,4), %rdi
	movq	%rbx, -72(%rbp)
	leaq	4(,%rcx,4), %rbx
	movq	%rbx, %rax
	.p2align 4,,10
	.p2align 3
.L9:
	testl	%r13d, %r13d
	jle	.L11
	movq	(%r9), %rbx
	movq	-80(%rbp), %r10
	leaq	(%rax,%rbx), %r14
	.p2align 4,,10
	.p2align 3
.L14:
	xorl	%r8d, %r8d
	testl	%r12d, %r12d
	jle	.L13
	movq	(%r15), %r11
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	.p2align 4,,10
	.p2align 3
.L10:
	movl	(%r11,%rcx), %esi
	imull	(%r10,%rcx), %esi
	addq	$4, %rcx
	addl	%esi, %r8d
	cmpq	%rcx, %rdi
	jne	.L10
.L13:
	movl	%r8d, (%rbx)
	addq	$4, %rbx
	addq	%rdx, %r10
	cmpq	%r14, %rbx
	jne	.L14
.L11:
	addq	$8, %r9
	addq	$8, %r15
	cmpq	%r15, -72(%rbp)
	jne	.L9
	movq	-88(%rbp), %rax
.L1:
	movq	-56(%rbp), %rdx
	xorq	%fs:40, %rdx
	jne	.L27
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L26:
	.cfi_restore_state
	movl	%edx, %ecx
	movl	$1, %edi
	movl	%esi, %edx
	movl	$.LC0, %esi
	call	__printf_chk
	orl	$-1, %edi
	call	exit
.L27:
	call	__stack_chk_fail
	.cfi_endproc
.LFE38:
	.size	mul, .-mul
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
