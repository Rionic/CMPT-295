.globl sum_float

	# var map:
	#   %xmm0:  total
	#   %rdi:   F[n] (base pointer)
	#   %rsi:   n
	#   %rbp:   endptr
	#	%rdx:	i
	#	%xmm1:  x
	#	%xmm2:	y
	#	%rsp: 	enqueue (tail)
	#	%r9:	dequeue (head)

sum_float:
	push %rbp
	mov	%rsp, %r8				# r8 = rsp
	xorps %xmm0, %xmm0          # total <- 0.0
	leaq (%rdi, %rsi, 4), %rbp  # endptr <- F + n
	xor	%rdx, %rdx
	mov	$1, %rdx				# i = 1
	mov	%rsp, %r9				# r9 = Q.head
loop:
	cmpq %rdx, %rsi				# n ? i
	jl endloop					# mp if n<i
	incq %rdx					# i++
	cmpq %rdi, %rbp				# check if F is empty
	jle	 EmptyF1
	movss (%rdi), %xmm1			# x = F.head
	cmpq %r9, %rsp				# rsp ? r9  
	jg	 EmptyQ1 				# empty queue
	ucomiss (%r9), %xmm1		# if F.head <= Q.head
	jle	EmptyQ1			
	movss (%r9), %xmm1			# x = Q.head
	subq $4, %r9				# move pointer up
	jmp	 NonemptyQ1		
EmptyF1:
	movss (%r9), %xmm1			# x = Q.head
	subq $4, %r9				# move pointer up
	jmp	EmptyF2				
EmptyQ1:
	addq $4, %rdi               # inc F ptr
NonemptyQ1:
	movss (%rdi), %xmm2			# y = F.head
	cmpq %r9, %rsp				# rsp ? r9 
	jg EmptyQ2
	ucomiss (%r9), %xmm2		# F.head <= Q.head
	jle	 EmptyQ2
EmptyF2:
	movss (%r9), %xmm2			# y = Q.head
	subq $4, %r9				# move pointer up
	jmp	NonemptyQ2
EmptyQ2:
	addq $4, %rdi			    # inc F ptr
NonemptyQ2:
	addss %xmm1, %xmm2          # xmm2 += xmm1
	subq $4, %rsp				# move up rsp 
	movss %xmm2, (%rsp)			# xmm2 = rsp
	jmp	loop                        

endloop:
	movss	(%rsp), %xmm0		# put result into rsp
	mov		%r8, %rsp			# rsp = r8 (original value)
	pop		%rbp
	ret
