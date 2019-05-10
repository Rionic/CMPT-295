	.file	"rank.c"
	.text
	.p2align 4,,15
	.globl	compute_ranks
	.type	compute_ranks, @function
compute_ranks:
.LFB0:
	.cfi_startproc
	testl	%esi, %esi
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	jle	.L18
	leal	-1(%rsi), %eax
	pxor	%xmm3, %xmm3
	pxor	%xmm2, %xmm2
	movq	%rdi, %r11
	leaq	4(%rdi,%rax,4), %r12
	leal	-3(%rsi), %eax
	xorl	%ebp, %ebp
	shrl	%eax
	movl	%eax, %r10d
	leal	2(%rax,%rax), %ebx
	leaq	8(%rdi,%r10,8), %r10
	.p2align 4,,10
	.p2align 3
.L15:
	cmpl	$2, %esi
	movl	$1, (%rdx)
	movss	(%r11), %xmm0
	jle	.L19
	movq	%rdi, %rax
	.p2align 4,,10
	.p2align 3
.L8:
	movss	(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L4
	addl	$1, (%rdx)
.L4:
	movss	4(%rax), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L6
	addl	$1, (%rdx)
.L6:
	addq	$8, %rax
	cmpq	%r10, %rax
	jne	.L8
	cmpl	%ebx, %esi
	movslq	%ebx, %rax
	jle	.L9
.L12:
	movss	(%rdi,%rax,4), %xmm1
	ucomiss	%xmm0, %xmm1
	jbe	.L10
	addl	$1, (%rdx)
.L10:
	addq	$1, %rax
	cmpl	%eax, %esi
	jg	.L12
.L9:
	ucomiss	.LC1(%rip), %xmm0
	addss	%xmm0, %xmm2
	jb	.L13
	addss	%xmm0, %xmm3
	addl	$1, %ebp
.L13:
	addq	$4, %r11
	addq	$4, %rdx
	cmpq	%r11, %r12
	jne	.L15
	pxor	%xmm0, %xmm0
	cvtsi2ss	%esi, %xmm0
	divss	%xmm0, %xmm2
.L2:
	testq	%r9, %r9
	je	.L17
	pxor	%xmm0, %xmm0
	cvtsi2ss	%ebp, %xmm0
	divss	%xmm0, %xmm3
.L17:
	movl	%ebp, (%r9)
	movss	%xmm2, (%rcx)
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movss	%xmm3, (%r8)
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L19:
	.cfi_restore_state
	xorl	%eax, %eax
	jmp	.L12
.L18:
	pxor	%xmm3, %xmm3
	xorl	%ebp, %ebp
	pxor	%xmm2, %xmm2
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	compute_ranks, .-compute_ranks
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC1:
	.long	1112014848
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
