#rdi/edi = x, rax/eax = return value
	.globl sqrt
sqrt:
	mov $0, %rax		# result
	mov $15, %rcx		# largest current bit
	mov $0x8000, %rdx	# bit 15
	jmp loop
loop:
	xor %rdx, %rax		# set rax's kth bit to 1
	mov %rax, %rsi		# rsi = rax
	imul %rax, %rsi		# rsi = rsi*rax (rsi^2)
	cmp %rdi, %rsi		# rsi ? result
	jg bitflip			# if rsi>result jump to bitflip
	dec %rcx			# rcx--
	shr $1, %rdx		# rdx shifted right by 1
	cmp $0, %rcx		# rcx ? 0
	jge loop			# if rcx>=0 jump to loop
	jmp endloop			#	jump to end
bitflip:
	xor %rdx, %rax		# flip kth bit back to 0
	dec %rcx			# rcx--
	shr $1, %rdx		# rdx shifted right by 1
	jmp loop			# jump back to loop
endloop:
	ret
