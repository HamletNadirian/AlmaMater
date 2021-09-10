include win64a.inc
include kernel32.inc

.data
CmdCommand db "avxtest.exe",0
mas1 real8 8.,18.,32.,50. ; ������ ����� B
len2 equ ($-mas1)/type mas1
mas2 real8 256.,2.,2.,2.         ; a, c, d,e
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
invoke WinExec,addr CmdCommand,SW_SHOW  ; ����� SW_HIDE � ���� ����� ������
invoke WriteConsole,stdout,ADDR Msg,sizeof Msg,ADDR cWritten,0
invoke ReadConsole,stdin,ADDR Buf,8,ADDR cRead,0
invoke Pas1
.if (Err1==0);
invoke MessageBox,0,addr Msg1,addr Title1,MB_OK
.data

titll db "��������� ���������� ��������� sqrt(a) � cd � sqrt(eb) .",0
res dq len1 DUP(0),0  ;
buf1 dd len1 DUP(0),0  ; ����� ������ ���������
ifmt db "Masm64 ������ bi = 1., 2., 3., 4.",10,
9,"�����: a, c, d, e  := 100., 2., 2.,4.",10,
"���������� : %d ,%d ,%d ,%d ",10,10,
"�����: HamletOs,���. ���-36, ��� ���",10,
9,0
.code 

mov rcx,len2
lea rdx,res
lea rbx,mas1
vmovsd xmm1,mas2[0]  ; xmm1 � a � ��������� real8
vmovsd xmm2,mas2[8]  ; xmm2 � c
vmovsd xmm3,mas2[16] ; xmm3 � d
vmovsd xmm5,mas2[24];  ; xmm4 - e
vmulsd xmm3,xmm2,xmm3; ;xmm3 - c*d   
@@:
vmovsd xmm0,qword ptr[rbx]; - xmm0 - b
vsqrtsd xmm4,xmm4,xmm1  ;xmm4 - a
vsubsd xmm4,xmm4,xmm3  ;xmm4 - a-cd
vmulsd xmm6,xmm5,xmm0; xmm6 - (e*b)
vsqrtsd xmm6,xmm6,xmm6 ;xmm6 - sqrt(e*b) 
vsubsd xmm4,xmm4,xmm6; a-cd-sqrt(e*b)
;vcvttsd2si eax,xmm4      ; ��
vcvttsd2si eax,xmm4   ; ��� �������
movsxd r15,eax ;
mov [rdx],eax ; ���������� ����������
add rbx,8
add rdx,8
dec rcx
jnz @b ; ������ �� ���������� ����� @@ (������)
jz m4
m4:
invoke wsprintf,addr buf1,addr ifmt,res,res[8],res[16],res[24]
invoke MessageBox,0,addr buf1,addr titll,MB_OK 
.else
invoke MessageBox,0,addr Msg2,addr Title2,MB_ICONWARNING

.endif
invoke ExitProcess,0
WinMain endp
end