#include<p16f84.inc>
W_TEMP EQU 0x0C ; адреса регістру збереження W
STATUS_TEMP EQU 0X0D
A equ 0x11  ;
	org 0

	goto START; ������� �� ����� START; 

	org  0x04 ; ����� ���������� ��������� ��������� ����������
	bsf INTCON, RBIE;�����
movwf W_TEMP ; ���������� W
swapf STATUS,W ; ���������� STATUS
movwf STATUS_TEMP;������� �� ����� START
btfsc INTCON,RBIF ; ����������� ��� ��� RB4-RB7
call INTRB47 ; ������ ����������� ����������� ; ��� ��� ������� �� ������� RB4-RB7
swapf STATUS_TEMP,W ; ���������� ������� STATUS
movwf STATUS
swapf W_TEMP, F ; ���������� ������� W
swapf W_TEMP, W
retfie

INTRB47
	movlw 0xFF
	tris PORTB
	movlw 0x00
	tris PORTA
	movf PORTB,0
	movwf A
	movwf PORTA
	swapf A,0
	movwf PORTA
	bcf INTCON,RBIF 
	return

START
bsf       INTCON, GIE
bsf       INTCON, RBIE
loop 
nop
goto loop	
end