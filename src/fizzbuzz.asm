# registers:
# t0: target number
# t1: current itteration number
# t2: the modulo of t0 and either three or five
# t3: the constant 3
# t4: keeps track of if fizz or buzz was printed
# t5: the constant 5


.data
prompt: .asciz "Target: "
fizz: .asciz "Fizz"
buzz: .asciz "Buzz"
completed: .asciz "\nCompleted!\n"
newline: .asciz "\n"

.text
addi t3, zero, 3 # t3 = 3
addi t5, zero, 5 # t5 = 5

li a7, 4
la a0, prompt
ecall # print the initial promp
li a7, 5
ecall # read an integer to a0
addi t0, a0, 1 # t0 = a0 + 1


init_loop: 
	addi t1, t1, 1 # t1++
	beq t0, t1, exit # if (t1 == t2) goto exit
	li a7, 4
	la a0, newline
	ecall # print a new line 
	add t4, x0, x0 # t4 = 0
	rem t2, t1, t3 # t2 = t1 % 3
	beq t2, x0, print_fizz # if (!t3) goto print_fizz
	check_buzz:
		rem t2, t1, t5 # t2 = t1 % 5
		beq t2, x0, print_buzz # if (!t2) 
	beq t4, x0, print_num # if (!t4) goto print_num 
	b init_loop

print_fizz:
	li a7, 4
	la a0, fizz
	ecall
	addi t4, t4, 1
	b check_buzz
	
print_buzz: 
	li a7, 4
	la a0, buzz
	ecall
	b init_loop
	
print_num:
	li a7, 1
	add a0, t1, x0
	ecall
	b init_loop
	
exit:
	li a7, 4
	la a0, completed
	ecall
	li a7, 10
	ecall