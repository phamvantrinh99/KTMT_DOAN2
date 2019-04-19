.data
	
	day: .word 0
	month: .word 0
	year: .word 0
	time: .space 1024
	Temp1: .space 1024
	Temp2: .space 1024
	# prompt
	prompt1: .asciiz "\nNhap ngay DAY: "
	prompt2: .asciiz "\nNhap thang MONTH: "
	prompt3: .asciiz "\nNhap nam YEAR: "
	daysOfWeek: .word cn, t2, t3, t4, t5, t6, t7
	sun: .asciiz " Sun"
	mon: .asciiz " Mon"
	tue: .asciiz " Tue"
	wed: .asciiz " Wed"
	thu: .asciiz " Thu"
	fri: .asciiz " Fri"
	sat: .asciiz " Sat"
	Month_1:
	.asciiz "January"
Month_2:
	.asciiz "February"
Month_3:
	.asciiz "March"
Month_4:
	.asciiz "April"
Month_5:
	.asciiz "May"
Month_6:
	.asciiz "June"
Month_7:
	.asciiz "July"
Month_8:
	.asciiz "August"
Month_9:
	.asciiz "September"
Month_10:
	.asciiz "October"
Month_11:
	.asciiz "November"
Month_12:
	.asciiz "December"
.text
main:
	li $a0,12
	li $a1,2
	li $a2,1213
	la $a3,time
	jal Date
	la $a0,time
	li $a1,67
	jal Convert
	li $v0,4
	la $a0,time 
	syscall
	j KetThuc
#Nhap Ngay
Date:
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	
	li $t0,10
	div $a0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,($a3)
	sb $t1,1($a3)
	li $t0,47
	sb $t0,2($a3)

	li $t0,10
	div $a1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,3($a3)
	sb $t1,4($a3)
	li $t0,47
	sb $t0,5($a3)

	li $t0,1000
	div $a2,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,6($a3)
	li $t0,100
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,7($a3)
	li $t0,10
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,8($a3)
	sb $t1,9($a3)
	move $v0,$a3

	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
#Ham tra ve ngay
Day:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	lb $t0, 0($a0)
	addi $t0, $t0, -48
	li $t1, 10
	mult $t0, $t1
	mflo $t0
	lb  $t1, 1($a0)
	addi $t1, $t1, -48
	add $t0, $t0, $t1
	move $v0, $t0
	
	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	jr $ra
	# --------------------------------------------
Month:
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, 3($a0)
	jal Day
	move $v0, $v0

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra

# --------------------------------------------

Year:
	addi  $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	la $a0, 6($a0)
	jal Day
	move $t0, $v0
	
	li $t1, 100
	mult $t0, $t1
	mflo $t0

	la $a0, 2($a0)
	jal Day
	add $t0, $t0, $v0

	move $v0, $t0

	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
#Nhom ham Convert
Convert:
	addi $sp,$sp,-8
	sw $ra,($sp)
	sw $t0,4($sp)
	li $t0,65
	beq $a1,$t0,Convert_A
	li $t0,66
	beq $a1,$t0,Convert_B
	li $t0,67
	beq $a1,$t0,Convert_C
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8
	jr $ra

Convert_A: #DD/MM/YYYY -> MM/DD/YYYY
	addi $sp,$sp, -24
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	
	lb $t0, 0($a0)		# $t0 = TIME[0]
	lb $t1, 1($a0)		# $t1 = TIME[1]
	lb $t3, 3($a0)		# $t3 = TIME[3]
	lb $t4, 4($a0)		# $t4 = TIME[4]
	# swap
	sb $t3, 0($a0)		# TIME[0] = $t3
	sb $t4, 1($a0)		# TIME[1] = $t4
	sb $t0, 3($a0)		# TIME[3] = $t0
	sb $t1, 4($a0)		# TIME[4] = $t1
	move $v0,$a0
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	addi $sp,$sp, 24
	jr $ra
	
Convert_B: # DD/MM/YYYY -> Month DD, YYYY
	addi $sp,$sp -20
	sw $ra,($sp)
	sw $a0,16($sp)
	sw $a1,12($sp)
	jal Month
	move $a0,$v0
	jal Month_in_String
	sw $v0,4($sp)
	
	lw $a0,16($sp)
	
	la $t0, Temp1
	li $t1,32
	sb $t1,0($t0)
	lb $t1,0($a0)
	sb $t1,1($t0)
	lb $t1,1($a0)
	sb $t1,2($t0)
	li $t1,44
	sb $t1,3($t0)
	li $t1,32
	sb $t1,4($t0)
	lb $t1,6($a0)
	sb $t1,5($t0)
	lb $t1,7($a0)
	sb $t1,6($t0)
	lb $t1,8($a0)
	sb $t1,7($t0)
	lb $t1,9($a0)
	sb $t1,8($t0)
	
	sw $t0,8($sp)
	
	lw $a1,4($sp)
	jal strcpy
	lw $a1,8($sp)
	jal strcat
	
	move $v0,$a0
	
	lw $ra,($sp)
	lw $a0,16($sp)
	lw $a1,12($sp)
	addi $sp,$sp,20
	jr $ra
	
Convert_C: # DD/MM/YYYY -> DD Month, YYYY

	addi $sp,$sp -24
	sw $ra,($sp)
	sw $a0,20($sp)
	sw $a1,16($sp)
	jal Month
	move $a0,$v0
	jal Month_in_String
	sw $v0,4($sp)
	
	lw $a0,20($sp)
	
	la $t0, Temp1
	lb $t1,0($a0)
	sb $t1,0($t0)
	lb $t1,1($a0)
	sb $t1,1($t0)
	li $t1,32
	sb $t1,2($t0)
	
	sw $t0,8($sp)
	
	la $t0,Temp2
	li $t1,44
	sb $t1,0($t0)
	li $t1,32
	sb $t1,1($t0)
	lb $t1,6($a0)
	sb $t1,2($t0)
	lb $t1,7($a0)
	sb $t1,3($t0)
	lb $t1,8($a0)
	sb $t1,4($t0)
	lb $t1,9($a0)
	sb $t1,5($t0)
	
	sw $t0,12($sp)
	
	lw $a1,8($sp)
	jal strcpy
	lw $a1,4($sp)
	jal strcat
	lw $a1,12($sp)
	jal strcat
	
	move $v0,$a0
	
	lw $ra,($sp)
	lw $a0,20($sp)
	lw $a1,16($sp)
	addi $sp,$sp,24
	jr $ra
	
# Ham copy chuoi a1 vào chuoi a0
strcpy:
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	add $s0, $zero, $zero 	
strcpy_loop:
	add $t0, $s0, $a1
	lb $t1, 0($t0) 
	add $t2, $s0, $a0
	sb $t1, 0($t2) 
	beq $t1, $zero, strcpy_exit
	addi $s0, $s0, 1
	j strcpy_loop
strcpy_exit:
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham noi cuoi a1 vào chuoi a0
strcat:
	# save to stack
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	add $s0, $zero, $zero		# $s0 la i = 0
	add $s1, $zero, $zero 		# $s1 la j = 0
strcat_findEndLoop:
	add $t3, $a0, $s0
	lb $t4, 0($t3) 			# $t4 = x[i]
	beq $t4, $zero, appendLoop	# neu x[i] == '\0'
	addi $s0, $s0, 1  		# i += 1
	j strcat_findEndLoop
appendLoop:
	add $t4, $a1, $s1 		# $t4 = &y[j]
	lb $t5, 0($t4) 			# $t5 = y[j]
	add $t3, $a0, $s0 		# $t3 = &x[i]
	sb $t5, 0($t3) 			# x[i] = y[j]
	beq $t5, $zero, strcat_exit	# neu x[i] == '\0'
	addi $s0, $s0, 1		# i += 1
	addi $s1, $s1, 1		# j += 1
	j appendLoop
strcat_exit:
	# restore from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra
	
Month_in_String:
	slti $t0, $a0, 2 	# if month < 2 => month == 1
	bne $t0, 0, Jan 	# jump to January

	slti $t0, $a0, 3 	# if month < 3 => month == 2
	bne $t0, 0, Feb 	# jump to February

	slti $t0, $a0, 4	# if month < 4 => month == 3
	bne $t0, 0, Mar 	# jump to March

	slti $t0, $a0, 5 	# if month < 5 => month == 4
	bne $t0, 0, Apr 	# jump to April

	slti $t0, $a0, 6 	# if month < 6 => month == 5
	bne $t0, 0, May 	# jump to May

	slti $t0, $a0, 7 	# if month < 7 => month == 6
	bne $t0, 0, Jun 	# jump to June

	slti $t0, $a0, 8 	# if month < 8 => month == 7
	bne $t0, 0, Jul 	# jump to July

	slti $t0, $a0, 9 	# if month < 9 => month == 8
	bne $t0, 0, Aug 	# jump to August

	slti $t0, $a0, 10 	# if month < 10 => month == 9
	bne $t0, 0, Sep 	# jump to September

	slti $t0, $a0, 11 	# if month < 11 => month == 10
	bne $t0, 0, Oct 	# jump to October

	slti $t0, $a0, 12 	# if month < 12 => month == 11
	bne $t0, 0, Nov 	# jump to November

	j Dec 			# jump to December
Jan:
	la $v0, Month_1
	j Month_in_Year_exit
Feb:
	la $v0, Month_2
	j Month_in_Year_exit
Mar:
	la $v0, Month_3
	j Month_in_Year_exit
Apr:
	la $v0, Month_4
	j Month_in_Year_exit
May:
	la $v0, Month_5
	j Month_in_Year_exit
Jun:
	la $v0, Month_6
	j Month_in_Year_exit
Jul:
	la $v0, Month_7
	j Month_in_Year_exit
Aug:
	la $v0, Month_8
	j Month_in_Year_exit
Sep:
	la $v0, Month_9
	j Month_in_Year_exit
Oct:
	la $v0, Month_10
	j Month_in_Year_exit
Nov:
	la $v0, Month_11
	j Month_in_Year_exit
Dec:
	la $v0, Month_12
Month_in_Year_exit:
	jr $ra
#Ham LeapYear
LeapYear:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)
		
	jal Year
	move $t0, $v0
	
	li $t1, 400
	div $t0, $t1
	mfhi $t1
	beq $t1, $0, true	# nam chia het cho 100
	
	li $t1, 4
	div $t0, $t1
	mfhi $t1
	bne  $t1, $0, false	# nam khong chia het cho 4	
	
	li $t1, 100
	div $t0, $t1
	mfhi $t1
	beq $t1, $0, false	# nam chia het cho 4 va khong chia het cho 100
	
	
true:
	li $v0, 1
	j break
false:
	li $v0, 0
	j break
break:
	
	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	
	addi $sp, $sp, 12

	jr $ra
	
#Ham GetTime
GetTime:
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)

	jal Year
	move $t0, $v0

	la $a0, ($a1)
	jal Year
	move $t1, $v0

	sub $v0, $t1, $t0

	slt $t0, $v0, $0
	beq $t0, $0, EOG
	li $t0, -1
	mult $v0, $t0
	mflo $v0
EOG:
	
	lw $ra, 12($sp)
	lw $t0, 8($sp)
	lw $t1, 4($sp)
	lw $t2, 0($sp)

	addi $sp, $sp, 16

	jr $ra
Weekday:
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $t0, 20($sp)
	sw $t1, 16($sp)
	sw $t2, 12($sp)
	sw $t3, 8($sp)
	sw $t4, 4($sp)
	sw $s0, 0($sp)
	
	
	jal Year
	move $t2, $v0

	lw $a0, 24($sp)
	jal Day
	move $t0, $v0
	
	lw $a0, 24($sp)
	jal Month
	move $t1, $v0

	li $t3, 3
	slt $t3, $t1, $t3
	beq $t3, $0, congthuc
	addi $t1, $t1, 12
	addi $t2, $t2, -1
	j 	congthuc
congthuc:
	move $s0, $t0	# $s0 = ngay
	
	li $t4, 2
	mult $t1, $t4	# thang * 2
	mflo $t0		# $t0 = thang * 2

	add $s0, $s0, $t0	# $s0 = ngay + 2* thang

	addi $t1, $t1, 1	# $t1 = thang + 1

	li $t4, 3		
	mult $t1, $t4	# (thang + 1) * 3
	mflo $t1		# $t1 = (thang + 1) * 3

	li $t4, 5
	div $t1, $t4	# ((thang + 1) * 3) div 5
	mflo $t1		# $t1 = ((thang + 1) * 3) div 5

	add $s0, $s0, $t1  	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5
	
	add $s0, $s0, $t2	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam
	li $t4, 4
	div $t2, $t4	# nam div 4
	mflo $t2	# $t2 = nam div 4
	
	add $s0, $s0, $t2 	# $s0 = ngay + 2* thang + ((thang + 1) * 3) div 5 + nam + nam div 4

	li $t4, 7
	div $s0, $t4
	mfhi $s0	# $s0 = (ngay + 2* thang + ((thang + 1) * 3) div 5 + nam + nam div 4) mod 7

	sll $s0, $s0, 2
	la $t0, daysOfWeek
	add $t0, $t0, $s0
	lw $t0, ($t0)
	jr $t0
cn:	
	la $v0, sun
	j  EOW
t2:
	la $v0, mon
	j EOW
t3:
	la $v0, tue
	j EOW
t4:
	la $v0, wed
	j EOW
t5:
	la $v0, thu
	j EOW
t6:
	la $v0, fri
	j EOW
t7:
	la $v0, sat
	j EOW
EOW:
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $t0, 20($sp)
	lw $t1, 16($sp)
	lw $t2, 12($sp)
	lw $t3, 8($sp)
	lw $t4, 4($sp)
	lw $s0, 0($sp)
	addi $sp, $sp, 32
	
	jr $ra
KetThuc:

