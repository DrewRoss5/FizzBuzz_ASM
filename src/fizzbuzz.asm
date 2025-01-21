# registers:
# t0: target number
# t1: current itteration number
# t2: the modulo of t0 and either three or five
# t3: the constant 3
# t4: keeps track of if fizz or buzz was printed
# t5: the constant 5

.macro print_int(%reg)
	li a7, 1
	add a0, %reg, x0
	ecall
.end_macro 

.macro print_str(%str)
	li a7, 4
	la a0, %str
	ecall
.end_macro 

.data
prompt: .asciz "Target: "
fizz: .asciz "Fizz"
buzz: .asciz "Buzz"
completed: .asciz "\nCompleted!\n"
newline: .asciz "\n"

.text
addi t3, zero, 3 # t3 = 3
addi t5, zero, 5 # t5 = 5

print_str(prompt)
li a7, 5
ecall # read an integer to a0
addi t0, a0, 1 # t0 = a0 + 1
add t1, x0, x0

loop:  beq t1, t0, exit
	add  t4, x0, x0
	rem t2, t1, t3
	bne t2, x0, check_buzz
	print_str(fizz)
	addi t4, t4, 1 
	check_buzz:
		rem t2, t1, t5
		bnez t2, check_neither
		print_str(buzz)
		addi t4, t4, 1
	check_neither:
		bnez t4, finish_loop
		print_int(t1)
	finish_loop:
		addi t1, t1, 1
		print_str(newline)
		j loop
	
exit:
	print_str(completed)
	li a7, 10
	ecall
		
