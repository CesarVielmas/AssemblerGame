section .data
    number_sub_one db 10
    number_sub_two db 20
    number_sub_three db 30
    number_sub_forth db 40

section .bss
    result_sub resb 5
    counter_result resb 1
    counter_invert_hex resb 1  

section .text
    global _start

_start:
    mov byte [counter_result], 0

    movzx ax, byte [number_sub_one]
    sub ax, [number_sub_two]
    sub ax, [number_sub_three]  
    sub ax, [number_sub_forth]

    call _function_ascii_sub
    call _function_invert_hex

    movzx rdx, byte [counter_result]
    mov rax, 1
    mov rdi, 1
    mov rsi, result_sub
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall

_function_ascii_sub:
    mov bl, 10
.loop_ascii:
    xor ah, ah
    div bl                  
    movzx rcx, byte [counter_result]
    mov [result_sub + rcx], ah
    add byte [result_sub + rcx], '0'
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
    mov al, [result_sub + rbx]
    mov ah, [result_sub + rcx]
    mov [result_sub + rbx], ah
    mov [result_sub + rcx], al

    inc rbx
    dec rcx
    jmp .invert_loop

.end_invert:
    ret


    