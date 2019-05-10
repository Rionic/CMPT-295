	#Calculates the reverse dot product of two arrays
	.globl conv
conv:
	movq $0, %r8		#r8 = 0 (counter)
	movq $0, %r11 		#r11 = 0 (dot product)
	addq %rdx, %rsi 	#rsi = rsi + rdx
	decq %rsi			#ptr is at H[N-1]
loop:	
	cmpq %rdx, %r8		#counter ? len
	jge	end				#jump end if counter>=len
	movq (%rdi), %r9	#r9 = *rdi (X[N])
	movq (%rsi), %r10	#r10 = *rsi (H[M])
	imulq %r9, %r10		#r10 = r10*r9 (product)
	addq %r10, %r11		#r11=r11+r9 (adding products)
	incq %r8			#counter++
	decq %rsi			#rsi--
	incq %rdi			#rdi++
	jmp loop
end:	
	movb %r11b, %al		#al = r11b
	ret