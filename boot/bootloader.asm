; Project Lumen Bootloader - Stage 1
; This is loaded by BIOS at 0x7C00
; It loads the Stage 2 bootloader from disk

[BITS 16]
[ORG 0x7C00]

start:
    ; Set up segments
    cli                     ; Disable interrupts
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00         ; Stack grows downward from bootloader
    sti                     ; Enable interrupts

    ; Save boot drive
    mov [boot_drive], dl

    ; Print loading message
    mov si, msg_loading
    call print_string

    ; Load Stage 2 bootloader (next sectors)
    ; For now, we'll jump directly to kernel loading
    ; In a full implementation, Stage 2 would handle this

    ; Load kernel from disk
    ; Reset disk
    mov ah, 0x00
    mov dl, [boot_drive]
    int 0x13
    jc disk_error

    ; Read kernel sectors
    mov ah, 0x02           ; BIOS read sector function
    mov al, 0x20           ; Number of sectors to read (32 sectors = 16KB)
    mov ch, 0x00           ; Cylinder 0
    mov cl, 0x02           ; Start from sector 2 (sector 1 is bootloader)
    mov dh, 0x00           ; Head 0
    mov dl, [boot_drive]
    mov bx, 0x1000         ; Load kernel at 0x1000
    int 0x13
    jc disk_error

    ; Print success message
    mov si, msg_loaded
    call print_string

    ; Enter protected mode
    call enable_a20
    cli
    lgdt [gdt_descriptor]
    
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    
    jmp CODE_SEG:protected_mode

disk_error:
    mov si, msg_disk_error
    call print_string
    jmp $

; Print string function (16-bit real mode)
print_string:
    pusha
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0E
    mov bh, 0x00
    int 0x10
    jmp .loop
.done:
    popa
    ret

; Enable A20 line
enable_a20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

; Messages
msg_loading db 'Loading Project Lumen...', 13, 10, 0
msg_loaded db 'Kernel loaded, entering protected mode...', 13, 10, 0
msg_disk_error db 'Disk read error!', 13, 10, 0

boot_drive db 0

; GDT
gdt_start:
    ; Null descriptor
    dd 0x0
    dd 0x0

    ; Code segment descriptor
    dw 0xFFFF       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10011010b    ; Access byte
    db 11001111b    ; Flags + Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

    ; Data segment descriptor
    dw 0xFFFF       ; Limit (bits 0-15)
    dw 0x0          ; Base (bits 0-15)
    db 0x0          ; Base (bits 16-23)
    db 10010010b    ; Access byte
    db 11001111b    ; Flags + Limit (bits 16-19)
    db 0x0          ; Base (bits 24-31)

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

CODE_SEG equ 0x08
DATA_SEG equ 0x10

[BITS 32]
protected_mode:
    ; Set up segments
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    
    ; Set up stack
    mov ebp, 0x90000
    mov esp, ebp
    
    ; Jump to kernel
    jmp 0x1000

; Boot signature
times 510-($-$$) db 0
dw 0xAA55
