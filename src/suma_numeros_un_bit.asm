section .data
    number_add_one db 100
    number_add_second db 100
    number_add_third db 55

section .bss
    result_add resb 5
    counter_result resb 1
    counter_invert_hex resb 1  

section .text
    global _start

_start:
    mov byte [counter_result], 0

    movzx ax, byte [number_add_one]
    add ax, [number_add_second]
    add ax, [number_add_third]  

    call _function_ascii_sum
    call _function_invert_hex

    movzx rdx, byte [counter_result]
    mov rax, 1
    mov rdi, 1
    mov rsi, result_add
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

_function_ascii_sum:
    mov bl, 10
.loop_ascii:
    xor ah, ah
    div bl                  
    movzx rcx, byte [counter_result]
    mov [result_add + rcx], ah
    add byte [result_add + rcx], '0'
    inc byte [counter_result]
    cmp al, 0
    jnz .loop_ascii
    ret

_function_invert_hex:
    movzx rcx, byte [counter_result]
    dec rcx                 
    xor rbx, rbx            

.invert_loop:
    cmp rbx, rcx
    jge .end_invert
    mov al, [result_add + rbx]
    mov ah, [result_add + rcx]
    mov [result_add + rbx], ah
    mov [result_add + rcx], al

    inc rbx
    dec rcx
    jmp .invert_loop

.end_invert:
    ret


    