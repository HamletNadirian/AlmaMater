include win64a.inc
.data
DATE1 STRUCT ; ��� ������ ��������� � ������ DATE1
elem1 dd ? ; ��� ������� ���� ���������
elem2 dd ? ; ��� ������� ���� ��������� 
elem3 dd ? ; ��� �������� ���� ��������� 
elem4 dd ? ; ��� ���������� ���� ��������� 
elem5 dd ? ; ��� ���������� ���� ��������� 
elem6 dd ? ; ��� ���������� ���� ��������� 
elem7 dd ? ; ��� ���������� ���� ��������� 
DATE1 ENDS
Password db "nadirian" ; �������� ������ ������ ���� ��������
len1 equ ($-Password)/type Password
Buf dq 8 ;
Err1 dq 0
Msg1 db "������ ������",0
Msg2 db "������ �� ���������",0
Title1 db "�������� ������",0
Title2 db "���,������ ������� (�� �������� � ������ ��������)",0
stdout dq 0  ;
stdin dq 0  ;
cRead dq 0  ;
cWritten dq 0 ;
_a dd 0;
_b dd 0;
Msg db "********",10,0 ;
.code
Pas1 proc
lea rsi,Password   ; ����� ������� �������� ������
lea rdi,Buf  ; ����� ������� �������� ������
mov rcx,len1
repe cmpsb   ; �������� ����������� len ���
jz m2    ;
inc Err1   ; ������� ������������
m2:
ret
Pas1 endp
WinMain proc
sub rsp,28h;
mov rbp,rsp
invoke GetStdHandle,STD_OUTPUT_HANDLE
mov stdout,rax
invoke GetStdHandle,STD_INPUT_HANDLE
mov stdin,rax
invoke WriteConsole,stdout,ADDR Msg,sizeof Msg,ADDR cWritten,0
invoke ReadConsole,stdin,ADDR Buf,8,ADDR cRead,0
invoke Pas1
.if (Err1==0);
invoke MessageBox,0,addr Msg1,addr Title1,MB_OK
.data
dir db 256 dup(0) ;���������� ��� �������� ���� � ������� ����������
align 8 ; ������������ ������ �� �������, ������� 8 ������
str1 DATE1 <2,2,2,2,1,1,1> ; ��������� � ������ str1
str2 DATE1 <0,0,0,1,1,1,1> ; ��������� � ������ str2
str3 DATE1 <2,2,2,1,1,1,0> ; ��������� � ������ str2
str4 DATE1 <0,0,0,0,0,0,0> ; ��������� � ������ str2
titl1 db "����������..",0
buf1 dq 10 dup(0);
ifmt db "������ �������:",0dh,0ah,0ah,\
"2 2 2 2 1 1 1",0dh,0ah,\
"0 0 0 1 1 1 1",0dh,0ah,\
"2 2 2 1 1 1 0",0dh,0ah,\
"0 0 0 0 0 0 0",0dh,0ah,0ah,\
"��������� �������� ������ ��������� ������ �1 ������� =%d",0dh,0ah,\
"��������� �������� �������� ��������� ������ �3 = %d",0ah,\
"���� � ����� %s ",0
.code 

xor edi,edi ; ���������� ������
mov ebx,1 ; �������� ���������� �����
lea rsi,str1 ; �������� ������ ������ ������ ���������
m5: mov ecx,7 ; ���������� ��������� � ������
m3: mov eax,dword ptr[rsi] ; �������� �������� �� ������ ���������
test eax,1 
je m1
jnz m2
m1: add edi,eax
    mov _a,edi     ; �������� �������� ��������� ������ ���������
m2: add rsi,4 ; ���������� ������ ������ ��������
loop m3
dec ebx ; ebx := ebx 1
jz m9
;jz m4 ; ���� ebx = 0 (z = 1), �� ������� � ����������
jmp m5 ; ������� �� ����� ���� 
;m4:

m9:
xor edi,edi
xor ebx,ebx
xor rsi,rsi
xor ecx,ecx
xor eax,eax
mov ebx,1 ; �������� ���������� �����
lea rsi,str3 ; �������� ������ ������ ������ ���������
m15: mov ecx,7 ; ���������� ��������� � ������
m13: mov eax,dword ptr[rsi] ; �������� �������� �� ������ ���������
test eax,1
jnz m11
jz m12
m11: add edi,eax
    mov _b,edi     ; �������� �������� ��������� ������ ���������
m12: add rsi,4 ; ���������� ������ ������ ��������
loop m13
dec ebx ; ebx := ebx 1
jz m4

m4:
invoke GetCurrentDirectory,255,addr dir; ��������� ����������
invoke wsprintf,ADDR buf1,ADDR ifmt,_a,_b,addr dir
invoke MessageBox,0,addr buf1,addr titl1,MB_OK 
.else
invoke MessageBox,0,addr Msg2,addr Title2,MB_ICONWARNING 
.endif
invoke ExitProcess,0
WinMain endp
end