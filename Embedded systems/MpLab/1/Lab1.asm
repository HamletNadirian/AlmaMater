;���.� 1
;������� �.�.
A equ .11 ;.number - dec number
M equ .176
 ORG 0 ;pic16f84 - 0 (����� �����)�����...pic 16056 - (����� �����) 3ff
  movlw M;mov - ���������,l - �������,w - ������� �����������.�.�. ��������� �������� � �����������,do 255
  movwf A;f - ��������� � ���� ������� M do 60-80
  nop
  goto $-1 ;����� � ���� �������� ������,������� �� nop.
 END
