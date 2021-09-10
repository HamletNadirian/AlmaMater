clear all % �������� ���
disp('��������� �������� 2') % ��������� ������
syms x y Dy D2y % ������� �������� ����
%F=((Dy^2-4*Dy*cos(2.*x))+5*sin(3.*x)); % ������������ �������
%F
F=(Dy^2)+4*y^2+4*x^2*y+x*cos(x); % ������������ �������

x1=0; % ������� �����
y1=6;
x2=2;
y2=-30;
disp('������ ���:')
fprintf(['ϳ����������� ������� '...
  'F(x,y,y'')=%s\n'],char(F))
fprintf('�������� ����� ����: y(%d)=%d\n',x1,y1)
fprintf('�������� ����� ������: y(%d)=%d\n',x2,y2)

dFdy1=simple(diff(F,Dy)); % Fy'
deqEuler=[char(dFdy1) '=C']; % ������ ������
disp('������ �������� ������� ������:')
fprintf('%s\n',deqEuler)
Sol=dsolve(deqEuler,'x'); % ��������� ������� ������
if length(Sol)~=1 % ������ ���� ��� ����� ������ ��������
  error('���� ������� ��� ���� ������ ������ ��������!');
else
  disp('��������� �������� ������� ������:')
  fprintf('y(x)=%s\n',char(Sol))
end

SolLeft=subs(Sol,x,sym(x1)); % ��������� x1
SolRight=subs(Sol,x,sym(x2)); % ��������� x2
EqLeft=[char(SolLeft) '=' char(sym(y1))]; % =y1
EqRight=[char(SolRight) '=' char(sym(y2))]; % =y2
disp('г������ ��� ��������� ����:')
fprintf('%s\n',EqLeft,EqRight)

Con=solve(EqLeft,EqRight,'C,C2'); % ���������
C=Con.C; % ���������� ������� ��������
C2=Con.C2; % ���������� ������ C �� C2
Sol22=vpa(eval(Sol),12); % ��������� C2, C
disp('г������ ���������:')
fprintf('y(x)=%s\n',char(Sol22))

xpl=linspace(x1,x2); % ������ ����� ������
y22=subs(Sol22,x,xpl); % ��������� ��������
figure % ������
plot(xpl,y22,'-r') % ������ ������ �������� ���
set(get(gcf,'CurrentAxes'),...
  'FontName','Times New Roman Cyr','FontSize',12)
title('\bf�������� 2') % ���������
xlabel('\itx') % ���� �� OX
ylabel('\ity\rm(\itx\rm)') % ���� �� OY
Leg=diff(dFdy1,Dy); % Fy'y'
disp ('�������� ����� ��������:')
fprintf('Fy''y''=%s\n',char(Leg))

dFdy=diff(F,y); % ��������� Fy
dFdy1=diff(F,Dy); % ��������� Fy'
fprintf('Fy=%s\n',char(dFdy))
fprintf('Fy''=%s\n',char(dFdy1))

d_dFdy1_dx=diff(dFdy1,x); % Fxy'x
d_dFdy1_dy=diff(dFdy1,y); % Fyy'
d_dFdy1_dy1=diff(dFdy1,Dy); % Fy'y'-����� ��������
dFy1dx=d_dFdy1_dx+d_dFdy1_dy*Dy+d_dFdy1_dy1*D2y;
fprintf('dFy''/dx=%s\n',char(dFy1dx))
disp('����� ��������:')
fprintf('Fy''y''=%s\n',char(d_dFdy1_dy1))


Euler=simple(dFdy-dFy1dx); % ������� ������
deqEuler=[char(Euler) '=0']; % � ����� ������ =0
fprintf('г������ ������:\n%s\n',deqEuler)

Sol=dsolve(deqEuler,'x'); % ��������� ������� ������
if length(Sol)~=1 % ���������� ���� ��� ���� ������
  error('���� ���������� ��� ���� ������ ������ ����������!');
else
  disp('�������� ���������� ������� ������:')
  fprintf('y(x)=%s\n',char(Sol))
end

SolLeft=subs(Sol,x,x1); % ��������� x1
SolRight=subs(Sol,x,x2); % ��������� x2
EqLeft=[char(SolLeft) '=' char(sym(y1))]; % =y1
EqRight=[char(SolRight) '=' char(sym(y2))]; % =y2
disp('г������ ��� ��������� ����:')
fprintf('%s\n',EqLeft,EqRight)


Fextr=subs(F,{y,Dy},{Sol22,diff(Sol22,x)});
Jextr=eval(int(Fextr,x,x1,x2))
ylin=(x-x1)*(y2-y1)/(x2-x1)+y1;
Flin=subs(F,{y,Dy},{ylin,diff(ylin,x)});
Jlin=eval(int(Flin,x,x1,x2))

xpl=linspace(x1,x2); % ������ ����� ������
y21=subs(Sol22,x,xpl); % ��������� ��������
figure % ������
plot(xpl,y21,'-r') % ������ ������ �������� ���
set(get(gcf,'CurrentAxes'),...
  'FontName','Times New Roman Cyr','FontSize',12)
title('\bf������� 1') % ���������
xlabel('\itx') % ���� �� OX
ylabel('\ity\rm(\itx\rm)') % ���� �� OY




