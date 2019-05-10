	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Original signal:  "
.LC1:
	.string	"%4d"
.LC2:
	.string	"Convolved signal: "
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	$.LC0, %edi
	movl	$signal, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	puts
	.p2align 4,,10
	.p2align 3
.L2:
	movsbl	(%rbx), %edx
	xorl	%eax, %eax
	movl	$.LC1, %esi
	movl	$1, %edi
	addq	$1, %rbx
	call	__printf_chk
	cmpq	$signal+20, %rbx
	jne	.L2
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	movl	$2, %ebp
	call	_IO_putc
	movl	$.LC2, %edi
	call	puts
	.p2align 4,,10
	.p2align 3
.L3:
	cmpl	$2, %ebx
	movl	%ebp, %edx
	movl	%ebx, %edi
	cmovle	%ebx, %edx
	movl	$h, %esi
	addl	$1, %ebx
	addl	$1, %edx
	subl	%edx, %edi
	movslq	%edi, %rdi
	addq	$signal+1, %rdi
	call	conv
	movl	$.LC1, %esi
	movsbl	%al, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	cmpl	$20, %ebx
	jne	.L3
	movq	stdout(%rip), %rsi
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movl	$10, %edi
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	jmp	_IO_putc
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	h
	.data
	.type	h, @object
	.size	h, 3
h:
	.byte	1
	.byte	-2
	.byte	2
	.globl	signal
	.align 16
	.type	signal, @object
	.size	signal, 20
signal:
	.byte	0
	.byte	0
	.byte	0
	.byte	4
	.byte	8
	.byte	6
	.byte	5
	.byte	6
	.byte	7
	.byte	4
	.byte	1
	.byte	-2
	.byte	-5
	.byte	-7
	.byte	-4
	.byte	-2
	.byte	0
	.byte	1
	.byte	2
	.byte	7
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
