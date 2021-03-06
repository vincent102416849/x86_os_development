[BITS 16]
[ORG 0x7e00]

Start:
mov [DriveId],dl

mov eax,0x80000000
cpuid
cmp eax,0x80000001
jb NotSupport

mov eax,0x80000001
cpuid
test edx,(1<<29)
jz NotSupport
test edx,(1<<26)
jz NotSupport

mov ah,0x13
mov al,1
mov bx,0xa
mov dx,dx
mov bp,Message
mov cx,MessageLen
int 0x10

NotSupport:
End:
hlt
jmp End

DriveId: db 0
Message: db "long mode is supported"
MessageLen: equ $-Message
