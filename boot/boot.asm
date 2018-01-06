	org 07c00h		;告诉编译器程序加载到7c00处
	jmp short LABEL_START
	nop
	
	OEM 					db "MSDOS5.0"	;8Bytes
	Bytes_per_sector 		dw 512
	Sectors_per_cluster 	db 16
	Reserved_sectors		dw 2400
	Number_of_FATs			db 2
	Root_entries			dw 0
	Sectors_small			dw 0
	Media_descriptor		db 0F8h
	Sectors_per_FAT_small	dw 0
	Sectors_per_track		dw 63
	Heads					dw 255
	Hidden_sectors			dd 256
	Sectors					dd 31129344
	
	Sectors_per_FAT			dd 15184
	Extended_flags			dw 0
	Version					dw 0
	Root_dir_1st_cluster	dd 2
	FSInfo_sector			dw 1
	Backup_boot_sector		dw 6
	times	12 db 0
	
	BIOS_drive 				db 80h
	db 0
	Ext_boot_signature      db 29h
	Volume_label			db 'CENA_X64FRE'		;11个字节
	File_system				db 'FAT32   '			;8个字节
	
LABEL_START:		
	mov ax, cs		
	mov ds, ax
	mov es, ax 	
	call DispStr	;调用显示字符串例程
	jmp $			;无限循环
DispStr:
	mov ax, BootMessage
	mov bp, ax		;es:bp = 串地址
	mov cx, 29		;cx = 串长度
	mov ax, 01301h	;ah = 13h, al = 01h
	mov bx, 000ch	;页号为0(bh = 0) 黑底红字(bl = 0ch，高亮)
	mov dl, 0
	int 10h			;10h号中断
	ret
BootMessage:	db "Welcome to JockJo's OS world!"
times 510-($-$$) db 0	;填充剩下的空间，使生成的二进制代码恰好为512字节
dw 0xaa55;				;结束标志
