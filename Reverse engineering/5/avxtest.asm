include win64a.inc
.data
titl db "�������� ��������������� �� ��������� ������ AVX",0 ; �������� ����
szInf db "������� AVX ��������������!!!",0 ;
inf db "������� AVX ���������������� �� ��������������",0
.code
WinMain proc
sub rsp,28h; c���: 28h=32d+8; 8 - �������
mov rbp,rsp
mov rax,1
cpuid ; �� ����������� rax ������������ ������������� ���������������
and rcx,10000000h ; r�x:= r�x v 1000 0000h (28 ������)
jnz exit1 ; ������� �� exit, ���� �� ����
invoke MessageBox,0,addr inf,addr titl,MB_OK
jmp exit2
exit1:
invoke MessageBox,0,addr szInf,addr titl,MB_ICONINFORMATION
exit2:
invoke ExitProcess,0
WinMain endp
end