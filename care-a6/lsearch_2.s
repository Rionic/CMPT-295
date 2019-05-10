	# var map:
	#   %rdi - int *A
	#   %esi - int n
	# 	%edx - int target
	# 	%rax - return value
	# 	%r9d - tmp
	#	%rcx - i
	#	%r8d - j (i-1 or 0)
	# Commented out things that wouldn't happen/work in C
	.globl	lsearch_2
lsearch_2:
	testl	%esi, %esi				# if(n<=0){
	jle	end							# 	jump end }
	movslq	%esi, %rax				# // rax = n;
	leaq	-4(%rdi,%rax,4), %rax	# // rax = A[n-1];
	movl	(%rax), %r9d			# int tmp = A[n-1];
	movl	%edx, (%rax)			# // &rax = target;
	cmpl	(%rdi), %edx			# if(A[0]==target){
	je	zero_out					# 	jump zero_out }
	movl	$1, %ecx				# int i = 1;
loop:								
	movl	%ecx, %r8d				# while(target!=A[i-1]){
	addq	$1, %rcx				# int j = i;
	cmpl	%edx, -4(%rdi,%rcx,4)	# i++;
	jne	loop						# }
decider:
	movl	%r9d, (%rax)			# // &rax = tmp;
	leal	-1(%rsi), %eax			# // eax = n-1;
	cmpl	%r8d, %eax				# if (n-1>j){
	jg	endtarget					# jump endtarget }
	cmpl	%edx, %r9d				# if(tmp!=target){
	jne	end							# jump end }
	rep ret 						# return n-1; (never seen this)
endtarget:
	movl	%r8d, %eax				# // eax = j;
	ret 							# return j;
zero_out:
	xorl	%r8d, %r8d				# j = 0;
	jmp	decider							# jump decider
end:
	movl	$-1, %eax				# // eax = -1;
	ret 							# return -1;
