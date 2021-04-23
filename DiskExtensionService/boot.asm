[BITS 16]
[ORG 0x7c00]

Start:
xor ax,ax
mov ds,ax
mov es,ax
mov ss,ax
mov sp,0x7c00

TestDiskExtension:
mov [DriveId],dl
mov ah,0x41
mov bx,0x55aa
int 0x13
jc NotSupport1
cmp bx,0xaa55
jne NotSupport2

PrintDriveId:
mov ah,0x13
mov al,1
mov bx,0xa
xor dx,dx
mov bp,DeviceIdMessage
mov cx,DeviceIdMessageLen
int 0x10
mov dl,DeviceIdMessageLen+1
add byte [DriveId],48
mov bp,DriveId
mov cx,1
int 0x10

jmp End

NotSupport1:
mov ah,0x13
mov al,1
mov bx,0xa
xor dx,dx
mov bp,NotSupport1Msg
mov cx,NotSupport1MsgLen
int 0x10

jmp End

NotSupport2:
mov ah,0x13
mov al,1
mov bx,0xa
xor dx,dx
mov bp,NotSupport2Msg
mov cx,NotSupport2MsgLen
int 0x10

End:
hlt
jmp End

DriveId: db 0
DeviceIdMessage: db "Device Id:"
DeviceIdMessageLen: equ $-DeviceIdMessage
NotSupport1Msg: db "Not support 1"
NotSupport1MsgLen: equ $-NotSupport1Msg
NotSupport2Msg: db "Not support 2"
NotSupport2MsgLen: equ $-NotSupport2Msg

times (0x1be-($-$$)) db 0
db 80h
db 0,2,0
db 0f0h
db 0ffh,0ffh,0ffh
dd 1
dd (20*16*63-1)

times (16*3) db 0

db 0x55
db 0xaa
