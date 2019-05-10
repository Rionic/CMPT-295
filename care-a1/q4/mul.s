# This algorithm adds a to itself b times and uses the
# register ecx as a manipulable value holder for b
# edi = a, esi = b, eax = return value

	.globl times
times: 	
	movl 	$0, %eax		# eax initialized to 0
	movl 	%esi, %ecx		# ecx used to hold b value

startloop:
	cmpl 	$0, %ecx		# ecx ? 0
	jle 	endloop			# jump to end if ecx <= 0
	addl 	%edi, %eax		# eax = eax + edi
	decl	%ecx			# ecx--
	jmp 	startloop		# jump to startloop

endloop:
	ret

