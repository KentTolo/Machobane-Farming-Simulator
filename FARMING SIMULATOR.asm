#=============================================================================
# Authors	•	Liteboho Maseli – 202101659
#		•	Hlalele Manganye – 202101681
#		•	Khoase Hashatsi – 202101671
#		•	Hlalefang Makhasane – 202002398
#		•	Keketso Tolo – 202100092		
# Date: 20 November 2023 
# File Name: MACHOBANE FARMING SYSTEM FINAL APK MIPS
# Fumtionality: This appliciation simulates the Machobane farming system
#=============================================================================


.data
# NewLine
space: .asciiz "\n"
A_Field: .space 20
moisture_sensor: .word 5
acidity_sensor: .word 3
Field_row: .word 20   
Field_col: .word 20   

# The Menu label declarations
menuText1: .asciiz "=============================================="
menuText2: .asciiz "           Machobane Farming System  "
menuText3: .asciiz "============================================="
menuText4: .asciiz "1. Seasonal crop management "
menuText5: .asciiz "2. Manage Soil"
menuText6: .asciiz "3. Calculate Yield"
menuText7: .asciiz "4. Exit"

# seasonal crop management sub-menu
cropmanage0: .asciiz "Seasonal crop Management"
cropmanage1: .asciiz "1. Winter Crops"
cropmanage2: .asciiz "2. Summer Crops"
cropmanage3: .asciiz "3. Relay Crops"
cropmanage4: .asciiz "4. Harvest crops"
cropmanage5: .asciiz "5. Exit"
cropmanage6: .asciiz "Valid"

# plantcrop function labels
plantCrop0: .asciiz "Enter number of lines to plant"
plantCrop1: .asciiz "YOU ARE IN THE SUMMER PLANTING SESSION"
plantCrop2: .asciiz "--------------------------------------"
plantCrop3: .asciiz "Summer Crops: "
plantCrop4: .asciiz "[!] - beans"
plantCrop5: .asciiz "[%] - pumpkin"
plantCrop6: .asciiz "[^] - sorgum"
plantCrop7: .asciiz "[#] - watermelon"
plantCrop8: .asciiz "[0] - ground Nuts"
plantCrop9: .asciiz "[*] - maize"
plantCrop10: .asciiz "YOU ARE IN THE WINTER PLANTING SESSION"
plantCrop11: .asciiz "Winter Crops: "
plantCrop12: .asciiz "[+] - wheat"
plantCrop13: .asciiz "[&] - peas"
plantCrop14: .asciiz "[@] - potatoes"
plantCrop15: .asciiz "Choose symbol that represents crop type"
plantCrop16: .asciiz "Invalid symbol! "
plantCrop17: .asciiz "----------------------------------------"
plantCrop18: .asciiz "Can not plant, not yet time"
plantCrop19: .asciiz "Enter current month:"
plantCrop20: .asciiz "Enter valid option"
plantCrop21: .asciiz "No plants available for harvest"

# harvestCrops labels
harvestCrop1: .asciiz "This function is for harvesting"
harvestCrop2: .asciiz "Enter (1) for winter, (2) for summer crops"
harvestCrop3: .asciiz "winter harvest time"
harvestCrop4: .asciiz "summer session"
harvestCrop5: .asciiz "winter crops not ready for harvest"
harvestCrop6: .asciiz "summer crops not ready for harvest"

# intercropRelaycrop labels
intercrop1: .asciiz "Enter Current Month: "
intercrop2: .asciiz "Enter crop symbol: "
intercrop3: .asciiz "Enter planting Month:"
intercrop4: .asciiz "Enter harvesting start Month:"
intercrop5: .asciiz "Enter harvesting end Month:"

# manageSoil labels
managesoil1: .asciiz "Enter the moisture of the soil:"
managesoil2: .asciiz "Enter the acidity of the soil: "
managesoil3: .asciiz "Soil is fertile."
managesoil4: .asciiz "Adjust soil fertility by adding some fertilizer"
managesoil6: .asciiz "Moisture is good"
managesoil5: .asciiz "Adjust moisture"

# calculateYield labels
calculateYield1: .asciiz "Yield For"
calculateYield2: .asciiz ":"
calculateYield3: .asciiz "tons"

.text
main:
    # Call the menu function
    jal menu
    # Exit program
    li $v0, 10
    syscall

menu:
    # Print menu
    li $v0, 4
    la $a0, menuText1
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, menuText2
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, menuText3
    syscall
    la $a0, space
    syscall

    # Print menu options
    li $v0, 4
    la $a0, menuText4
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, menuText5
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, menuText6
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, menuText7
    syscall
    la $a0, space
    syscall

    # Accept user input
    li $v0, 5
    syscall
    move $t0, $v0

    # Branch based on user input
    beq $t0, 1, seasonalCropManagement
    beq $t0, 2, manageSoil
    beq $t0, 3, calculateYield
    beq $t0, 4, Exit

    jr $ra

Exit:
    li $v0, 10
    syscall

calculateYield:
    
    subu $sp, $sp, 12
    sw $ra, 8($sp)
    sw $s0, 4($sp)
    sw $s1, 0($sp)

    # Input: Enter number of lines to plant
    li $v0, 4        # syscall for print_str
    la $a0, calculateYield1
    syscall

    li $v0, 5        # syscall for read_int
    syscall
    move $s0, $v0      # n

    # Input: Enter number of crops
    li $v0, 4        # syscall for print_str
    la $a0, calculateYield2
    syscall

    li $v0, 5        # syscall for read_int
    syscall
    move $s1, $v0      # numCrops

    # Calculate Yield
    mul $v0, $s0, $s1    # yield = n * numCrops

    # Output: Print yield
    li $v0, 1        # syscall for print_int
    move $a0, $v0
    syscall

    # Function Epilogue
    lw $ra, 8($sp)
    lw $s0, 4($sp)
    lw $s1, 0($sp)
    addu $sp, $sp, 12

    jr $ra

manageSoil:
    # Function Prologue
    subu $sp, $sp, 8
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    # Input: Enter the moisture of the soil
    li $v0, 4
    la $a0, managesoil1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0  # moisture

    # Input: Enter the acidity of the soil
    li $v0, 4
    la $a0, managesoil2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0  # acidity

    # Manage Soil
    bgt $s0, 50, moisture_good
    li $v0, 4
    la $a0, managesoil6
    syscall
    j exit_manageSoil

moisture_good:
    bgt $s1, 7, acidity_good
    li $v0, 4
    la $a0, managesoil4
    syscall
    j exit_manageSoil

acidity_good:
    li $v0, 4
    la $a0, managesoil3
    syscall

exit_manageSoil:
    # Function Epilogue
    lw $ra, 4($sp)
    lw $s0, 0($sp)
    addu $sp, $sp, 8

    jr $ra

seasonalCropManagement:
    # Print crop management sub-menu
    li $v0, 4
    la $a0, cropmanage0
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, cropmanage1
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, cropmanage2
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, cropmanage3
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, cropmanage4
    syscall
    la $a0, space
    syscall

    li $v0, 4
    la $a0, cropmanage5
    syscall
    la $a0, space
    syscall

    # Accept user input
    li $v0, 5
    syscall
    move $t1, $v0

    # Branch based on user input
    beq $t1, 1, plantSummerCrops
    beq $t1, 2, plantWinterCrops
    beq $t1, 3, intercropRelayCrops
    beq $t1, 4, harvestCrops
    beq $t1, 5, menu  # Return to main menu

    j seasonalCropManagement  # Loop back if invalid option

plantSummerCrops:
   li $v0, 4
	la $a0, plantCrop1
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop2
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop3
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop2
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop4
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop5
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop6
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop7
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop8
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop9
	syscall
	la $a0,space
	syscall	
	
	li $v0, 5
    	syscall
    	move $t0, $v0
	
	beq $t0, 8, plantCrop
	beq $t0, 9, plantCrop
	beq $t0, 10, plantCrop
	
	li $v0, 4
	la $a0, plantCrop18
	syscall
	la $a0,space
	syscall
    j seasonalCropManagement  # After completing, return to seasonal crop management menu
    
plantCrops:
    # Function Prologue
    subu $sp, $sp, 20
    sw   $ra, 16($sp)
    sw   $s0, 12($sp)
    sw   $s1, 8($sp)
    sw   $s2, 4($sp)
    sw   $s3, 0($sp)

    # Input: Enter number of lines to plant
    li   $v0, 4        # syscall for print_str
    la   $a0, plantCrop0
    syscall

    li   $v0, 5        # syscall for read_int
    syscall
    move $s0, $v0      # row

    li   $s1, Field_row # Load the number of rows into $s1

    # Iterate through the array
    li   $t0, 0        # i

plant_outer_loop:
    # Check if i >= row, exit loop
    bge  $t0, $s0, end_plantCrops

    li   $t1, 0        # j

plant_inner_loop:
    # Check if j >= Field_col, exit inner loop
    bge  $t1, Field_col, end_inner_plant

    # Calculate index for 2D array
    mul  $s2, $t0, Field_col
    add  $s2, $s2, $t1  # index = i * Field_col + j

    # Check if index is within array bounds
    bge  $s2, Field_size, end_plantCrops

    # Example: Print "Enter crop symbol:"
    li   $v0, 4        # syscall for print_str
    la   $a0, plantCrop1
    syscall

    # Example: Read a string and store in memory (replace with your logic)
    li   $v0, 8        # syscall for read_string
    la   $a0, A_Field($s2)  # Assuming A_Field is a 2D array (crop symbol)
    li   $a1, 4       # Assuming a maximum string length of 4 (crop symbol)
    syscall

    # Example: Print "Enter planting Month:"
    li   $v0, 4        # syscall for print_str
    la   $a0, plantCrop2
    syscall

    # Example: Read an integer and store in register $v0
    li   $v0, 5        # syscall for read_int
    syscall

    # Example: Store the result in memory (replace with your logic)
    sw   $v0, A_Field+4($s2)  # Assuming A_Field is a 2D array (planting Month)

    # Increment j
    addi $t1, $t1, 1
    j    plant_inner_loop

end_inner_plant:
    # Increment i
    addi $t0, $t0, 1
    j    plant_outer_loop

end_plantCrops:
    # Function Epilogue
    lw   $ra, 16($sp)
    lw   $s0, 12($sp)
    lw   $s1, 8($sp)
    lw   $s2, 4($sp)
    lw   $s3, 0($sp)
    addu $sp, $sp, 20
    jr   $ra

plantWinterCrops:
    li $v0, 4
	la $a0, plantCrop10
	syscall
	la $a0,space
	syscall	
	
	li $v0, 4
	la $a0, plantCrop17
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop11
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop17
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop12
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop13
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop14
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop15
	syscall
	la $a0,space
	syscall
	
	li $v0, 4
	la $a0, plantCrop19
	syscall
	la $a0,space
	syscall
	
	li $v0, 5
    	syscall
    	move $t0, $v0
	
	beq $t0, 4, plantCrop
	beq $t0, 5, plantCrop
	
	li $v0, 4
	la $a0, plantCrop18
	syscall
	la $a0,space
	syscall

    j seasonalCropManagement  # After completing, return to seasonal crop management menu

intercropRelayCrop:
    # Function Prologue
    subu $sp, $sp, 16
    sw   $ra, 12($sp)
    sw   $s0, 8($sp)
    sw   $s1, 4($sp)
    sw   $s2, 0($sp)

    # Input: Enter number of lines to plant
    li   $v0, 4        # syscall for print_str
    la   $a0, intercrop1
    syscall

    li   $v0, 5        # syscall for read_int
    syscall
    move $s0, $v0      # row

    # Initialize index variables
    li   $t0, 0        # i
    li   $t1, 0        # j

intercrop_loop:
    # Check if i >= row, exit loop
    bge  $t0, $s0, end_intercropRelayCrop

    # Check if j >= Field_col, reset j to 0
    bge  $t1, Field_col, reset_col_intercrop

    # Calculate index for 2D array
    mul  $s2, $t0, Field_col
    add  $s2, $s2, $t1  # index = i * Field_col + j

    # Check if index is within array bounds
    bge  $s2, Field_size, end_intercropRelayCrop

    # Processing logic for each element in the array during intercropping
    # Example: Print "Enter crop symbol to plant"
    li   $v0, 4        # syscall for print_str
    la   $a0, intercrop2
    syscall

    # Example: Read a string and store in memory (replace with your logic)
    li   $v0, 8        # syscall for read_string
    la   $a0, A_Field($s2)  # Assuming A_Field is a 1D array (crop symbol)
    li   $a1, 4       # Assuming a maximum string length of 4 (crop symbol)
    syscall

    # Processing logic for each element in the array during relay cropping
    # Example: Print "Enter planting Month:"
    li   $v0, 4        # syscall for print_str
    la   $a0, intercrop3
    syscall

    # Example: Read an integer and store in register $v0
    li   $v0, 5        # syscall for read_int
    syscall

    # Example: Store the result in memory (replace with your logic)
    sw   $v0, A_Field+4($s2)  # Assuming A_Field is a 1D array (planting Month)

    # Increment j
    addi $t1, $t1, 1
    j    intercrop_loop

reset_col_intercrop:
    # Reset j to 0
    li   $t1, 0
    # Increment i
    addi $t0, $t0, 1
    j    intercrop_loop

end_intercropRelayCrop:
    # Function Epilogue
    lw   $ra, 12($sp)
    lw   $s0, 8($sp)
    lw   $s1, 4($sp)
    lw   $s2, 0($sp)
    addu $sp, $sp, 16
    jr   $ra
    j seasonalCropManagement  # After completing, return to seasonal crop management menu

harvestCrops:
    # Function Prologue
    subu $sp, $sp, 12
    sw   $ra, 8($sp)
    sw   $s0, 4($sp)
    sw   $s1, 0($sp)

    # Input: Enter (1) for winter, (2) for summer crops
    li   $v0, 4        # syscall for print_str
    la   $a0, harvestCrop2
    syscall

    li   $v0, 5        # syscall for read_int
    syscall
    move $s0, $v0      # current_Month

    # Initialize index variables
    li   $t0, 0        # i
    li   $t1, 0        # j

harvest_loop:
    # Check if i >= Field_row, exit loop
    bge  $t0, Field_row, end_harvestCrops

    # Check if j >= Field_col, reset j to 0
    bge  $t1, Field_col, reset_col

    # Calculate index for 2D array
    mul  $s1, $t0, Field_col
    add  $s1, $s1, $t1  # index = i * Field_col + j

    # Check if index is within array bounds
    bge  $s1, Field_size, end_harvestCrops

    # Processing logic for each element in the array
    # Example: Print crop symbol, planting Month, and current Month
    li   $v0, 4        # syscall for print_str
    la   $a0, A_Field($s1)           # Assuming A_Field is a 1D array (crop symbol)
    syscall
    la   $a0, A_Field+4($s1)         # Assuming A_Field is a 1D array (planting Month)
    syscall
    move $a0, $s0      # current_Month
    li   $v0, 1        # syscall for print_int
    syscall

    # Increment j
    addi $t1, $t1, 1
    j    harvest_loop

reset_col:
    # Reset j to 0
    li   $t1, 0
    # Increment i
    addi $t0, $t0, 1
    j    harvest_loop

end_harvestCrops:
    # Function Epilogue
    lw   $ra, 8($sp)
    lw   $s0, 4($sp)
    lw   $s1, 0($sp)
    addu $sp, $sp, 12
    jr   $ra

    j seasonalCropManagement  # After completing, return to seasonal crop management menu

    j menu
