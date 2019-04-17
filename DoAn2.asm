.data
	
	day: .word 0
	month: .word 0
	year: .word 0
	time: .space 10
	convert_time: .space 11
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
.text
main:
	jal NhapNgay
	li $v0,4
	la $a1,time
	syscall
	j KetThuc
#Nhap Ngay
Time:
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	
	la $t0, time
	lw $s0,day
	li $t0,10
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,($a0)
	sb $t1,1($a0)
	li $t0,47
	sb $t0,2($a0)

	lw $s0,month
	li $t0,10
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,3($a0)
	sb $t1,4($a0)
	li $t0,47
	sb $t0,5($a0)

	lw $s0,year
	li $t0,1000
	div $s0,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,6($a0)
	li $t0,100
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	sb $t0,7($a0)
	li $t0,10
	div $t1,$t0
	mflo $t0
	mfhi $t1
	addu $t0,$t0,48
	addu $t1,$t1,48
	sb $t0,8($a0)
	sb $t1,9($a0)
	move $v0,$a0

	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	addi $sp,$sp,20
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
	li $t0,65
	beq $a1,$t0,Convert_A
	li $t0,66
	beq $a1,$t0,Convert_B
	li $t0,67
	beq $a1,$t0,Convert_C
Convert_A: #MM/DD/YYYY
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

Convert_B: #MM DD,YYYY
	addi $sp,$sp, -8
	sw $ra,($sp)
	sw $t0,4($sp)
	
	
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp, 8
	jr $ra
	
Convert_C:
	addi $sp,$sp, -8
	sw $ra,($sp)
	sw $t0,4($sp)
	
	la $a2,convert_time
	lb $t0, 0($a0)
	sw $t0,0($a2)	#[covert_time[3]=D1
	lb $t0,1($a0)
	sw $t0,1($a2)	#[covert_time[4]=D2
	lb $t0,3($a0)
	sw $t0,3($a2)	#[covert_time[0]=M1
	lb $t0,4($a0)
	sw $t0,4($a2)	#[covert_time[1]=M2
	li $t0,32
	sw $t0,2($a2)	#[covert_time[2]=' '
	li $t0,44
	sw $t0,5($a2)	#[covert_time[5]=','
	li $t0,32
	sw $t0,6($a2)	#[covert_time[6]=' '
	lb $t0,6($a0)
	sw $t0,7($a2)	#[covert_time[7]=Y1
	lb $t0,7($a0)
	sw $t0,8($a2)	#[covert_time[8]=Y2
	lb $t0,8($a0)
	sw $t0,9($a2)	#[covert_time[9]=Y3
	lb $t0,9($a0)
	sw $t0,10($a2)	#[covert_time[10]=Y4
	
	move $v0,$a2
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp, 8
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

