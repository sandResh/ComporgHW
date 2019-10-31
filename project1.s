.data # Data section begins here.
	input: 	    	.space		11       # Input contains 10 chars plus an endline char.
    inputPrompt:    .asciiz     "Input 10 charactered alphanumeric string: "
    newLine: 		.asciiz 	"\n"
.text # Text section begins here. 
  	main:
	# Prompt the user to input a 10 char aplhanumeric string.
	    li $v0, 4
	    la $a0, inputPrompt
	    syscall
	# Input the string.
	    li $v0, 8
	    la $a0, input
	    li $a1, 11
	    syscall

		jal printNewLine #jumps and links to printnewline

	    # Store input string in $s0.
	    la $s0, input
		# Store the result in $s2 and offset in $s1.
	   		li $s2, 0
	   		li $s1, 0
			
			loop1:
	   			# changing byte offset.
	   			add $t0, $s0, $s1
	   			lb $t1, ($t0)

				beq $t1, 10, exitLoop1 #branches to exitloop1 if t1 is equal to 10
	   			beq $t1, 0, exitLoop1

				add $a0, $t1, $0
	   			jal getNumberFromByte

	   			add $s2, $s2, $v1

				


