.globl sum_float
	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer) (F.tail)
	#   %rsi:   n
	#   %rbp:   endptr (F.tail)
	# 	%rbx:	i
	#	%xmm0:	x
	#	%xmm1:	y
	#	%r10:	Q.head ptr (largest)
	#	%rsp	Q.tail ptr (smallest)
sum_float:
	pushq %rbp
	pushq %rbx
	movq %rsp, %r8
	movq %rsp, %r10				# r10 = Q head ptr
	xorps %xmm0, %xmm0			# total <- 0.0
	leaq (%rdi, %rsi, 4), %rbp  # endptr <- F + n
	xor %rdx, %rdx
	movq $1, %rbx				# i = 1
loop:
	cmpq %rbx, %rsi 		# n ? i          
	jle	endloop				# jump if n<=i
	cmpq %rsp, %r10			# check if Q is empty
	je Q_empty_xy
	movq (%rdi), %xmm0		# xmm0 = F.tail
	movq (%rsp), %xmm1		# xmm1 = Q.tail
	ucomiss %xmm0, %xmm1	# Q(tail) ? F(tail)
	jle Q_dequeue_x			# jump if we dequeue from Q
	ucomiss %xmm0, %xmm1	# Q(tail) ? F(tail)
	jg	F_dequeue_x			# jump if we dequeue from F
y_value:
	cmpq %rsp, %r10			# check if Q is empty
	je Q_empty_y
	movq (%rdi), %xmm2		# xmm2 = F.tail
	movq (%rsp), %xmm3		# xmm3 = Q.tail
	ucomiss %xmm2, %xmm3	# Q(tail) ? F(tail)
	jle Q_dequeue_y			# jump if we dequeue from Q
	ucomiss %xmm2, %xmm3	# Q(tail) ? F(tail)
	jg	F_dequeue_y			# jump if we dequeue from F
F_dequeue_x:
	incq %rbx				# i++
	movq (%rdi), %xmm0		# xmm0 = F.tail
	addq $4, %rdi			# inc F.tail ptr
	jmp y_value				
Q_dequeue_x:
	incq %rbx				# i++	
	movq (%rsp), %xmm0		# xmm0 = Q.tail
	subq $8, %rsp			# inc Q.tail ptr
	jmp y_value
F_dequeue_y:
	movq (%rdi), %xmm1		# xmm1 = F.tail
	addq $4, %rdi			# inc F.tail ptr
	jmp addition
Q_dequeue_y:
	movq (%rsp), %xmm1		# xmm1 = Q.tail
	subq $8, %rsp			# inc Q.tail ptr
	jmp addition
Q_empty_xy:				
	incq %rbx				# inc rbx 
	movq (%rdi), %xmm0		# xmm0 = F.tail
	addq $4, %rdi			# inc F.tail ptr
	movq (%rdi), %xmm1		# xmm1 = F.tail
	addq $4, %rdi			# inc F.tail ptr
	jmp addition
Q_empty_y:
	incq %rbx				# inc rbx
	movq (%rdi), %xmm1		# xmm1 = F.tail 
	addq $4, %rdi			# inc F.tail ptr
	jmp addition
addition:
	addss %xmm0, %xmm1		# xmm0 += xmm1
	movq %xmm0, (%r10)		# add xmm0 to queue
	subq $8, %r10			# dec head
	jmp loop
endloop:
	movq (%rsp), %xmm0
	movq %r8, %rsp
	popq %rbx
	pop	%rbp
	ret