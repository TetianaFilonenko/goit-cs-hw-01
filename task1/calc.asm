section .data
    a db 5
    b db 7
    c db 3
    result db 0
    output db "Result: ", 0

section .bss
    res resb 1

section .text
    global _start

_start:
    ; Load b, c, a into 64-bit registers
    movzx rax, byte [rel b]
    movzx rbx, byte [rel c]
    movzx rcx, byte [rel a]

    ; Perform b - c
    sub rax, rbx

    ; Perform (b - c) + a
    add rax, rcx

    ; Store result
    mov [rel result], al

    ; Print result
    mov rax, 0x2000004  ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    lea rsi, [rel output] ; address of string to output
    mov rdx, 8          ; number of bytes
    syscall

    ; Convert result to ASCII and print
    mov al, [rel result]
    add al, '0'
    mov [rel res], al

    mov rax, 0x2000004  ; syscall: write
    mov rdi, 1          ; file descriptor: stdout
    lea rsi, [rel res]  ; address of result
    mov rdx, 1          ; number of bytes
    syscall

    ; Exit
    mov rax, 0x2000001  ; syscall: exit
    xor rdi, rdi        ; exit code 0
    syscall
