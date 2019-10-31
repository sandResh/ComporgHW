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

