;����������� ������ � 3
;����:������ ������ ������� (tmr0)
;������ �.�.
;���� 15.10.2019.
#include<p16f84a.inc> 
k1 equ .240
k2 equ .245
	org 0 ;����� ����� ������ ��������
	movlw b'00101000' ;������������ � ������������ ��������
	OPTION
	movlw 0x00 ;�� ������ �� ���
	TRIS PORTB ;������������ ����� B �� ����
	movlw 0xff ;�� ������ �� ����
	TRIS PORTA ;������������ ����� � �� ���
start movlw .256-k1 ;���������� ��������� ��� �������� �������
	movwf TMR0 ;��������೿ �������
	bcf INTCON,T0IF ;�������� ������� ������������� ������� 
M1	btfss INTCON,T0IF ;���������� ������������ �������
	goto M1; �������, ���� ������ �� ������������
	bcf PORTB,4 ;��������� ����������� ���� ��������� �������
	movlw .256-k2
	movwf TMR0 ;��������೿ �������
	bcf INTCON,T0IF
M2 	btfss INTCON,T0IF ;���������� ������������ �������
	goto M2 ; �������, ���� ������ �� ������������
	bsf PORTB,4

	goto start
	end