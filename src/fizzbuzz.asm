# registers:
# t0: target number
# t1: current itteration number
# t2: the modulo of t1 3, 5, or 15
# t3: the constant 3
# t4: keeps track of if fizz or buzz was printed
# t5: the constant 5
# t6: the constant 15

.data
prompt: .asciz "Target: "
fizz: .asciz "Fizz\n"
buzz: .asciz "Buzz\n"
fizzbuzz: .asciz "Fizzbuzz\n"
completed: .asciz "\nCompleted!\n"
newline: .asciz "\n"

.text
addi t3, x9, 3 # t3 = 3
addi t5, x0, 5 # t5 = 5
addi t6, x0, 15 # t6 = 15

li a7, 4
la a0, prompt
ecall # print the initial promp
li a7, 5
ecall # read an integer to a0
addi t0, a0, 1 # t0 = a0 + 1


loop:
	addi t1, t1, 1 # t1++
	beq t0, t1, exit # if (t1 == t2) goto exit
	la a0, fizzbuzz # load "Fizzbuzz" into a0
	rem t2, t1, t6 # t3 = t1 % 15
	beq t2, x0, print_str # if (t2 == 0) goto print_str
	la a0, buzz #load "Buzz" into a0
	rem t2, t1, t5 # t3 = t1 % 5
	beq t2, x0, print_str # if (t3 == 0) goto print_str
	la a0, fizz #load "Fizz" into a0
	rem t2, t1, t3 # t3 = t1 % 5
	beq t2, x0, print_str # if (t3 == 0) goto print_str
	b print_num # print the current number
	
print_str:
	li a7, 4 # load the print string syscall code into a7
	ecall # print whatever string is pointed to by a0 
	b loop
	
print_num:
	li a7, 1 # load the print integer syscall into a7
	add a0, t1, x0 # a0 = t1
	ecall # print the content of t1
	li a7, 4 # load the print string syscall code into a7
	la a0, newline # a0 = newline
	ecall # print the new line
	b loop

exit:
	li a7, 4
	la a0, completed
	ecall
	li a7, 10
	ecall
