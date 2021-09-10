include win64a.inc
IDI_ICON  EQU 1001 
MSGBOXPARAMSA STRUCT
   cbSize          DWORD ?,?
   hwndOwner       QWORD ?
   hInstance       QWORD ?
   lpszText        QWORD ?
   lpszCaption     QWORD ?
   dwStyle         DWORD ?,?
   lpszIcon        QWORD ?
   dwContextHelpId QWORD ?
   lpfnMsgBoxCallback QWORD ?
   dwLanguageId       DWORD ?,?
MSGBOXPARAMSA ENDS
.data

 params MSGBOXPARAMSA <>
DATE1 STRUCT ; ��� ������ ��������� � ������ DATE1
elem1 dq ? ; ��� ������� ���� ���������
elem2 dq ? ; ��� ������� ���� ��������� 
elem3 dq ? ; ��� �������� ���� ��������� 
elem4 dq ? ; ��� ���������� ���� ��������� 
elem5 dq ? ; ��� ���������� ���� ��������� 
elem6 dq ? ; ��� ���������� ���� ��������� 
elem7 dq ? ; ��� ���������� ���� ��������� 
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

max1 dq 0
numstr dq 0

opc db 074h


_c dd 3
Msg db "********",0,10 ;
mem dq ?;
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
str1 DATE1 <2,2,132,12> ; ��������� � ������ str1
str2 DATE1 <514,1,1,1> ; ��������� � ������ str2
str3 DATE1 <2,313,2,11> ; ��������� � ������ str2

titl1 db "����������..",0
buf1 dq 10 dup(0);

ifmt db "������ �������:",0dh,0ah,0ah,\
"2 2 132 12",0dh,0ah,\
"514 1 1 1",0dh,0ah,\
"2 313 2 11",0dh,0ah,\

"������ � ������������ ������ ������������� ���������: � %d C���� ������: %d",0
.code

mov mem,rax

xor r11,r11 ; ���������
xor r15,r15 ; ���������
lea rsi,str1 ; �������� ������ ������ ������ ���������
mov rcx,4 ; ���������� ��������� � ������
@1: mov rax,qword ptr[rsi] ; �������� �������� �� ������ ���������
add r11,rax ; ������������� ����� ���������
add rsi,8 ; ���������� ������ ������ ��������
loop @1 ; r�� := rcx � 1 � ������� �� m3, ���� �� ����
inc r15 ; ������� ��������
cmp r15,1 ; ��� ������ ������?

jle m1
;jz m1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov numstr,1
cmp r15,2 ; ��� ������ ������?


jle m2
;jz m2 ;
mov numstr,2
cmp r15,3 ; ��� ������ ������?


jle m3
;jz m3 ;


m1: mov r10,r11 ; ����� ��������� 1-� ������
xor r11,r11 ; ���������
mov rcx,4 ; ���������� ��������� �� 2-� ������

lea rsi,str2 ; �������� ������ 2-� ������
jmp @1 ;

m2: mov r12,r11 ; ����� ��������� 2-� ������
xor r11,r11 ; ���������
mov rcx,4 ; ���������� ��������� � 3-� ������
lea rsi,str3 ; �������� ������ 3-� ������

jmp @1 ;

m3: mov r13,r11; ����� ��������� 3-� ������
cmp r10,r12
jg @@1 ; ���� ������, �� �� ����� @@1
mov max1,r12

jmp @@2
@@1: mov max1,r10
mov numstr,1
@@2: cmp max1,r13

jg m4
mov numstr,3
mov max1,r13

jmp m4
m4:

lea rdi,m1
invoke WriteProcessMemory,mem,rdi,addr opc,1,0
invoke GetCurrentProcessId
invoke OpenProcess,PROCESS_VM_OPERATION or PROCESS_VM_WRITE, 1, eax
lea rdi,m2
invoke WriteProcessMemory,mem,rdi,addr opc,1,0
invoke GetCurrentProcessId
invoke OpenProcess,PROCESS_VM_OPERATION or PROCESS_VM_WRITE, 1, eax
lea rdi,m3
invoke WriteProcessMemory,mem,rdi,addr opc,1,0
invoke GetCurrentProcessId
invoke OpenProcess,PROCESS_VM_OPERATION or PROCESS_VM_WRITE, 1, eax

invoke wsprintf,ADDR buf1,ADDR ifmt,numstr,max1;
mov params.cbSize,SIZEOF MSGBOXPARAMSA ; ������ ���������
mov params.hwndOwner,0 ; ���������� ���� ���������
invoke GetModuleHandle,0 ; ��������� ����������� ���������
mov params.hInstance,rax ; ���������� ����������� ���������
lea rax, buf1 ; ����� ���������
mov params.lpszText,rax
lea rax,titl1 ;Caption ; ����� �������� ����
mov params.lpszCaption,rax
mov params.dwStyle,MB_USERICON ; ����� ����
mov params.lpszIcon,IDI_ICON ; ������ ������
mov params.dwContextHelpId,0 ; �������� �������
mov params.lpfnMsgBoxCallback,0 ;
mov params.dwLanguageId,LANG_NEUTRAL ; ���� ���������
lea rcx,params
invoke MessageBoxIndirect
.else
invoke MessageBox,0,addr Msg2,addr Title2,MB_ICONWARNING 
.endif
invoke ExitProcess,0
WinMain endp
end