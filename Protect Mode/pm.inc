; 描述符
; usage:Descriptor Base, Limit, Attr
;		Base:  dd
;		Limit: dd(low 20 bits available)
;		Attr:  dw(lower 4 bits of heigh byte are always 0)
%macro Descriptor 3
	dw %2 & 0FFFFh				;段界限1				（2字节）
	dw %1 & 0FFFFh				;段基址1				（2字节）
	db (%1 >> 16) & 0FFh		;段基址2				（1字节）
	dw ((%2 >> 8) & 0F00h) | (%3 & 0F0FFh)
								;属性1 + 段界限2 + 属性2（2字节）
	db (%1 >> 24) & 0FFh		;段基址3
%endmacro ; 共8字节