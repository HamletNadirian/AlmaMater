include win64a.inc ; ������������ ����������
_NHAMLET segment READ WRITE EXECUTE alias("NHO")

mas1 real8 1.,2.,3.,4. ; ������ ����� B
len1 equ ($-mas1)/type mas1
mas2 real8 100.,2.,2.,4.         ; a, c, d,e
tit1 db "��������� ���������� ��������� a/cd � sqart(e) + b .",0
res dq len1 DUP(0),0  ;
buf1 dd len1 DUP(0),0  ; ����� ������ ���������
ifmt db "Masm64 ������ bi = 1., 2., 3., 4.",10,
9,"�����: a, c, d, e  := 100., 2., 2.,4.",10,
"���������� : %d ,%d ,%d ,%d ",10,10,
"�����: HamletOs,���. ���-36, ��� ���",10,
9,0

 WinMain proc
 
 sub rsp,28h ; ������������ �����
 mov rbp,rsp
xor rdx,rdx
;mov rcx,0EAh
mov rcx,06Ah
mov rax,$+1Fh ; ������ � rax ����� ������� ����� ��� �����
mov bx,01515h ; ������ ����� � rbx

lp:
mov dx,word ptr [rax]
add dx,bx
mov word ptr [rax],dx ; ���������� �������� xor � ������
inc rax ; ��������� �� ��������� ����

 inc rax
loop lp
 ; ������� �� ��������� ������� � ��� ����� �
; �������������/�������������� ����
xor rcx,rcx
xor rax,rax
xor rbx,rbx
mov rcx,len1
lea rdx,res
lea rbx,mas1
vmovsd xmm1,mas2[0]  ; xmm1 � a � ��������� real8
vmovsd xmm2,mas2[8]  ; xmm2 � c
vmovsd xmm3,mas2[16] ; xmm3 � d
vmovsd xmm5,mas2[24];  ; xmm4 - e
vmulsd xmm3,xmm2,xmm3; ;xmm3 - c*d   

@@:
vmovsd xmm0,qword ptr[rbx]; - xmm0 - b
vmovsd xmm4,xmm4,xmm1  ;xmm4 - a
vdivsd xmm4,xmm4,xmm3  ;xmm4 - a/cd
;vmovsd xmm6,xmm6,xmm5 ;xmm6 - e
vsqrtsd xmm6,xmm6,xmm5 ;xmm6 - sqrt(e)
;vaddsd xmm6,xmm6,xmm0; ;xmm6 - (sqrt(e)+b)
vsubsd xmm4,xmm4,xmm6; a/cd-sqrt(e)
vaddsd xmm4,xmm4,xmm0;a/cd-sqrt(e)+b
vcvttsd2si eax,xmm4      ; ��
vcvttsd2si eax,xmm4   ; ��� �������
movsxd r15,eax ;
mov [rdx],eax ; ���������� ����������
add rbx,8
add rdx,8
dec rcx
jnz @b ; ������ �� ���������� ����� @@ (������)

;invoke MessageBox,0,addr inf0,ADDR tit0,0 
;tit0 db "Haxxor",0 ;
 ;inf0 db "Made by : Chelak V.V.",0
 ;exit1:
; invoke ExitProcess,0

invoke wsprintf,addr buf1,addr ifmt,res,res[8],res[16],res[24]
invoke MessageBox,0,addr buf1,addr tit1,MB_ICONINFORMATION
 invoke ExitProcess,0
 WinMain endp
_NHAMLET ends
end
