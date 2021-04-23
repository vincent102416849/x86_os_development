[ORG 0x7c00]

PrintMessage:
	mov ah,0x13
	mov al,1
	mov bx,0xa
	xor dx,dx
	mov bp,Message
	mov cx,MessageLen
	int 0x10

End:
	hlt
	jmp End

Message: db "Hello"
MessageLen: equ $-Message

times (0x200-($-$$)-2) db 0
db 0x55
db 0xaa
