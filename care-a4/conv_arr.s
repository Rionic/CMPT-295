	.globl conv_arr
conv_arr:
	leaq (%rsi, %rcx), %r12	# r12 = n+m
	subq $1, %r12			# r12 = (n+m-2)
	movq $0, %r13			# r13 = 0 (counter AKA i)
loop:
	cmpq %r12, %r13		# i ? n+m-2 
	jge end				#jump if i >= n+m-2
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbx
	pushq %rdi
	pushq %rsi 			# stack: <rdi, rsi>
	movq %r13, %rdi 	# temp var rdi = i
	incq %rdi			# temp var rdi = i+1
	movq %rcx, %rsi 	# temp var rsi = m
	call min 			# this uses rdi and rsi
##########################Next function########################
	movq %rax, %r14		# (r14) ladj = min(i+1,m)
	popq %rsi
	leaq (%rsi, %rcx), %r15 # r15 = n+m
	subq %rdi, %r15		# r15 = n+m-(i+1)
	movq %r15, %rdi		# rdi = r15
	pushq %rsi			# rsi back on stack
	movq %rcx, %rsi		# rsi = m
	call min
#########################Next function#########################
	movq %rcx, %rbx		# (radj) rbx = rcx
	subq %rax, %rbx		# (radj) rbx = rbx - min(rdi,rsi)
	pushq %r14			# save ladj
	subq %rbx, %r14		# ladj = ladj - radj	(arg 3)
	addq %rdx, %rbx		# radj = radj + h 		(arg 2) PROBLEM?
	movq %r13, %r15		# r15 = i
	incq %r15			# r15 = i+1
	popq %rsi			# ladj popped into rsi  stack: <rdi, rsi>
	subq %rsi, %r15		# r15 = (i+1) - ladj
	popq %rsi
	popq %rdi			# stack empty
	addq %rdi, %r15		# r15 = r15 + signal 	(arg 1) PROBLEM?
	pushq %rsi
	pushq %rdi
	pushq %rdx			 
	pushq %rcx			
	pushq %r8 			# stack <rsi, rdi, rdx, rcx, r8>
	movq %r15, %rdi		#
	movq %rbx, %rsi		# moving values to appropriate registers
	movq %r14, %rdx		#
	call conv
#########################Next function########################
	popq %r8			#
	popq %rcx			#
	popq %rdx 			#
	popq %rdi			# restoring values into appropriate regs
	popq %rsi 			#
	popq %rbx
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	movb %al, (%r8)		# *r8 = al
	incq %r13			# i++		
	incq %r8			# 8++
	jmp loop
end:
	ret
