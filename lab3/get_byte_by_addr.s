	.globl get_byte_by_addr
get_byte_by_addr:
	movl $0, %eax   
	
	# place your code for Part 3 here
	#and $0xff, %rdi
	#shr %rsi, %rdi
	#movq %rdi, %rax
	movl (%esi, %edi), %edi
	movb %dil, %al
	# end of Part 3

	ret
