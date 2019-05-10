	.file	"main.c"
	.text
	.p2align 4,,15
	.globl	get_byte_by_order
	.type	get_byte_by_order, @function
get_byte_by_order:
.LFB23:
	.cfi_startproc
	testl	%esi, %esi
	jne	.L2
	movzbl	%dil, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	cmpl	$1, %esi
	movl	%edi, %eax
	jne	.L4
	movzbl	%ah, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	cmpl	$2, %esi
	jne	.L5
	sarl	$16, %eax
	movzbl	%al, %eax
	ret
.L5:
	cmpl	$3, %esi
	jne	.L1
	shrl	$24, %eax
.L1:
	ret
	.cfi_endproc
.LFE23:
	.size	get_byte_by_order, .-get_byte_by_order
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"x = %x\n"
.LC1:
	.string	"x = %d\n"
.LC2:
	.string	"y = %x\n"
.LC3:
	.string	"y = %d\n"
.LC4:
	.string	"x = "
.LC5:
	.string	"%02x"
.LC6:
	.string	"y = "
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	movl	x(%rip), %edx
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$.LC0, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	call	__printf_chk
	movl	x(%rip), %edx
	movl	$.LC1, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movl	y(%rip), %edx
	movl	$.LC2, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	movl	y(%rip), %edx
	movl	$.LC3, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	xorl	%eax, %eax
	movl	$.LC4, %esi
	movl	$1, %edi
	call	__printf_chk
	testq	%rbx, %rbx
	movl	x(%rip), %edx
	je	.L28
.L10:
	cmpl	$1, %ebx
	je	.L29
	cmpl	$2, %ebx
	je	.L30
	cmpl	$3, %ebx
	je	.L31
.L11:
	xorl	%eax, %eax
	movl	$.LC5, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$3, %ebx
	je	.L15
.L14:
	addq	$1, %rbx
	movl	x(%rip), %edx
	testq	%rbx, %rbx
	jne	.L10
.L28:
	movzbl	%dl, %edx
	jmp	.L11
.L31:
	shrl	$24, %edx
	movl	$.LC5, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	.p2align 4,,10
	.p2align 3
.L15:
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	call	_IO_putc
	movl	$.LC4, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
.L16:
	movl	%ebx, %esi
	movl	$x, %edi
	addl	$1, %ebx
	call	get_byte_by_addr
	movl	$.LC5, %esi
	movl	%eax, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	cmpl	$4, %ebx
	jne	.L16
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	call	_IO_putc
	xorl	%eax, %eax
	movl	$.LC6, %esi
	movl	$1, %edi
	call	__printf_chk
	testq	%rbx, %rbx
	movl	y(%rip), %edx
	je	.L32
.L18:
	cmpl	$1, %ebx
	je	.L33
	cmpl	$2, %ebx
	je	.L34
	cmpl	$3, %ebx
	je	.L35
.L19:
	xorl	%eax, %eax
	movl	$.LC5, %esi
	movl	$1, %edi
	call	__printf_chk
	cmpl	$3, %ebx
	je	.L23
.L22:
	addq	$1, %rbx
	movl	y(%rip), %edx
	testq	%rbx, %rbx
	jne	.L18
.L32:
	movzbl	%dl, %edx
	jmp	.L19
.L35:
	shrl	$24, %edx
	movl	$.LC5, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	.p2align 4,,10
	.p2align 3
.L23:
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	xorl	%ebx, %ebx
	call	_IO_putc
	movl	$.LC6, %esi
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
.L24:
	movl	%ebx, %esi
	movl	$y, %edi
	addl	$1, %ebx
	call	get_byte_by_addr
	movl	$.LC5, %esi
	movl	%eax, %edx
	movl	$1, %edi
	xorl	%eax, %eax
	call	__printf_chk
	cmpl	$4, %ebx
	jne	.L24
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	movq	stdout(%rip), %rsi
	movl	$10, %edi
	jmp	_IO_putc
.L34:
	.cfi_restore_state
	sarl	$16, %edx
	movl	$.LC5, %esi
	movl	$1, %edi
	movzbl	%dl, %edx
	xorl	%eax, %eax
	call	__printf_chk
	jmp	.L22
.L29:
	movzbl	%dh, %edx
	jmp	.L11
.L30:
	sarl	$16, %edx
	movl	$.LC5, %esi
	movl	$1, %edi
	movzbl	%dl, %edx
	xorl	%eax, %eax
	call	__printf_chk
	jmp	.L14
.L33:
	movzbl	%dh, %edx
	jmp	.L19
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.globl	y
	.data
	.align 4
	.type	y, @object
	.size	y, 4
y:
	.long	233876875
	.globl	x
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	2908479998
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~16.04~ppa1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
