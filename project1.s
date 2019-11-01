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
		
		# Print new line.
		jal printNewLine

	    # Store input string in $s0.
	    la $s0, input

		# Store the result in $s2 and byte offset value in $s1.
	   	li $s2, 0   # The final result.
	   	li $s1, 0   # The offset byte value.
		
		# Loop through every character in the input string.
		loop1:

	   		# Add byte offset to get the current character and load the byte value.
	   		add $t0, $s0, $s1
	   		lb $t1, ($t0)

			# Exit the loop if we encounter endline or newline characters.
			beq $t1, 10, exitLoop1
	   		beq $t1, 0, exitLoop1

			# Load the argument and get ready to call the function getNumberFromByte.
			add $a0, $t1, $0
	   		jal getNumberFromByte

			# The add the returned value from the above function to our final result.
	   		add $s2, $s2, $v1

			# Add 1 to the byte offset and repeat the loop.
	   		addu $s1, $s1, 1
	   		b loop1

		exitLoop1:
	   	
		# Print the integer.
	   	li $v0, 1
	   	add $a0, $s2, $0
	   	syscall
		
		# Exit the program
	    li $v0, 10
	    syscall

	getNumberFromByte:
		# Initialize the return value to 0.
		li $v1, 0

		# If the chars are out of boud exit the function after returning.
		blt $a0, 48, exitNFB
		bgt $a0, 116, exitNFB

		# If the char is less than 58, the char is a number
		slti $t8, $a0, 58		
		beq $t8, 1, numbers

		# If the char falls betweeen 58 and 64, it is invalid.
		blt $a0, 65, exitNFB

		# If the char is less than 'T' and greater than 'A', it is a valid capital letter.
		slti $t8, $a0, 85
		beq $t8, 1, capital

		# If the char falls between 'U' and 'a', it is invalid.
		blt $a0, 97, exitNFB 
		
		# If the char is less than 't', and greater than 'a', the char is valid small letter.
		slti $t8, $a0, 117	
		beq $t8, 1, small
		
		# Subtract 48 from the numbers to get the decimal value.
		numbers:
			addi $v1, $a0, -48
			b exitNFB
		
		# Subtract 55 from the capital letters to get the decimal value
		capital:
			addi $v1, $a0, -55
			b exitNFB
		
		# Subtract 87 from the small letters to get the decimal value.
		small:
			addi $v1, $a0, -87	
		exitNFB:
			jr $ra

	printNewLine:  # Function to call newLine
		li $v0, 4
		la $a0, newLine
		syscall

		jr $ra





				


