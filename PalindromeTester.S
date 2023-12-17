.globl _start

.text
_start:
    addi a0, zero, msg
    jal palindrome
    ebreak

// arguments:
//   a0: address of first byte of string
// returns:
//   a0: length of string
strlen:
    // load palindrome address in a0 into t0
    add t0, zero, a0

    // str len
    add t2, zero, zero

    // load last char into t1
    lb t1, 0(t0)  

    jal zero, checkWhileDone  

    while:
        // move address
        addi t0, t0, 1
        // increment len
        addi t2, t2, 1
        // load last char into t1
        lb t1, 0(t0)    

    checkWhileDone:
        beq t1, zero, done
        jal zero, while

    done:
        add a0, zero, t2

    jalr zero, 0(ra)


// arguments:
// 	a0: begin address of string
// 	a1:  length of string
// returns:
//	a0: 1 if string is palindrome, 0 otherwise
palindrome_helper:
    // 1 helper for subtraction
    addi t6, zero, 1

    // left pointer
    addi t0, zero, 0
    add t1, zero, a1
    sub t1, t1, t6

    jal zero, checkWhileDoneP
    
    whileP:
        // load left word address
        add t3, a0, t0
        // load left char
        lb t4, 0(t3)

        // load right char address
        add t3, a0, t1
        // load right char
        lb t5, 0(t3)

        // move left pointer to right
        addi t0, t0, 1
        // move right pointer to left
        sub t1, t1, t6

        // check if left pointer eqal right pointer
        beq t4, t5, checkWhileDoneP
        // left and right do not match, break
        jal zero, isNotPalindrome
        
    checkWhileDoneP:
        // if left pointer > right pointer
        blt t0, t1, whileP
        jal zero, isPalindrome

    isNotPalindrome:
        addi a0, zero, 0
        jalr zero, 0(ra)
    isPalindrome:
        addi a0, zero, 1
        jalr zero, 0(ra)


// arguments:
// 	a0: begin address of string
// returns:
//	a0: 1 if string is palindrome, 0 otherwise
palindrome:
    // save return address in a3
    add a3, ra, zero

    // save word address in a4
    add a4, a0, zero

    // get word length
    jal strlen
    
    // move word len in a1
    add a1, a0, zero

    // move word address in a0
    add a0, a4, zero

    // check if palindrome
    jal palindrome_helper

    jalr zero, 0(a3)

.data
msg: 
.asciz "abeccba"
