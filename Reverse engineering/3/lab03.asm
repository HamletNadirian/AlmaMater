
include win64a.inc
.data
a1 dd 0,1,1,2,3,5,8,13,21,34,55,89,144,14,15,16,17,18 ;18 �����
b1 dd 1,2,3,4,6,6,7,8,9,10,11,12,13,14,16,17,18,19 ;18 �����
len1 EQU ($-b1)/type b1
res1 dd 18 dup(0),0
res2 dq len1 dup(0),0
buf1 dq len1 dup(0),0
frmt db "������������� ������� VPMINSB",10,
"0,1,1,2,3,5,8,13,21,34,55,89,144,14,15,16,17,18",10,
"1,2,3,4,6,6,7,8,9,10,11,12,13,14,16,17,18,19",10,10,
"MIN:", 10 dup(" %d "),10,10,0
.code
WinMain proc
push rbp ; <� ��� ��� ����������� ���� �� 8
sub rsp,30h ; <� ��� 7-10 ����������
mov rbp,rsp
.data
titl db "�������� ��������������� �� ��������� ������ AVX2",0 ; �������� ����
szInf db "������� AVX ��������������!!!",0 ;
inf db "������� AVX ���������������� �� ��������������",0
.code
; �������� �� ��������� AVX ������
mov EAX,1 ; ��� ������������� 64-��������� ��
cpuid ; �� ����������� eax ������������ ������������� ���������������
and ecx,10000000h ; e�x:= e�x v 1000 0000h (28 ������)
jnz exit1 ; ������� �� exit, ���� �� ����
invoke MessageBox,0,addr inf,addr titl,MB_OK
jmp exit2
exit1:
invoke MessageBox,0,addr szInf,addr titl,MB_ICONINFORMATION
exit2:
.data
tit2 db "�������� ��������������� �� ��������� ������ AVX2",0 ; �������� ����
szInf2 db "������� AVX2 ��������������!!!",0 ;
inf2 db "������� AVX2 ���������������� �� ��������������",0
.code
mov eax,7
mov ecx,0
cpuid ; �� ����������� rax ������������ ������������� ��
and rbx,20h ; (5 ������)
jnz @f ; �������, ���� �� ����
invoke MessageBox,0,addr inf2,addr tit2,MB_OK

@@:
invoke MessageBox,0,addr szInf2,addr tit2,MB_ICONINFORMATION

mov rax,len1 ;
mov rbx,8 ; 32 � 8 = 256
xor rdx,rdx
div rbx ; ����������� ���������� ������ � rax � ������� � rdx
mov rcx,rax
lea rsi,a1
lea rdi,b1
lea rbx,res1
m1: vmovups ymm0,[rsi]
vmovups ymm1,[rdi]
VPMINSB ymm2,ymm0,ymm1
vmovups [rbx],ymm2
add rdi,32 ; 32 � 8 = 256
add rsi,32 ; �������� �� 256
add rbx,32 ; �������� �� 32 ����� = 256
loop m1
cmp rdx,0h ; ��������� ������� � �����
jz exit10 ; �������, ���� ����
mov rcx,rdx ; ��������� ����������� rdx � �������
m2:
loop m2
exit10:
lea rsi,res1
lea rdi,res2
mov rcx,len1 ; ���������� �����, ������� ��������� � ����
m5:
movsxd r15,dword ptr [rsi]
mov qword ptr[rdi],r15
add rsi,4
add rdi,8
dec rcx
jnz m5
invoke wsprintf,ADDR buf1,ADDR frmt,res2,res2[8],res2[16],res2[24],res2[32],res2[40], res2[48],res2[56],res2[64],res2[72];
invoke MessageBox,0,ADDR buf1,ADDR titl,MB_OK
invoke ExitProcess,0
WinMain endp
end