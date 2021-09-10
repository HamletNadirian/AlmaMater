clear all % �������� ������
syms t u y1 Dy1 y2 Dy2 L1 DL1 L2 DL2 % ������� �������� ����
F=u^2+L1*(Dy1-y2)+L2*(Dy2-u) ; % ������� ��������
t0=0; % ������� �����
t1=10;
y1_t0=12;
y2_t0=6;
y1_t1=30;
y2_t1=8;
disp('������ ���:')
fprintf(['������� �������� '...
  'F(t,u,y)=%s\n'],char(F))

Fu=2*u - L2
Fy1=0
dFdu=diff(F,u); % ��������� Fu
dFdy1=diff(F,y1); % ��������� Fy1
dFdDy1=diff(F,Dy1); % ��������� FDy1
dFdy2=diff(F,y2); % ��������� Fy2
dFdDy2=diff(F,Dy2); % ��������� FDy1
dFdL1= diff(F,L1); % ��������� FL1
dFdL2= diff(F,L2); % ��������� FL2
fprintf('FDy1=%s\n',char(dFdDy1))
fprintf('Fy2=%s\n',char(dFdy2))
fprintf('FDy2=%s\n',char(dFdDy2))
fprintf('FL1=%s\n',char(dFdL1))
fprintf('FL2=%s\n',char(dFdL2))

d_dFDy1_dt=diff(dFdDy1,t); % Fty1't
d_dFDy1_L1=diff(dFdDy1,L1); % Fy1L1

dFy1dt=d_dFDy1_dt+d_dFDy1_L1*DL1; % 

d_dFDy2_dt=diff(dFdDy2,t); % Fty1't
d_dFDy2_L2=diff(dFdDy2,L2); % Fy2L2

dFy2dt=d_dFDy2_dt+d_dFDy2_L2*DL2; % 

fprintf('dFDy1/dt=%s\n',char(dFy1dt))
fprintf('dFDy2/dt=%s\n',char(dFy2dt))


Euler_y1=simple(dFdy1-dFy1dt); % ������� ������ ��� y1
deqEuler_y1=[char(Euler_y1) '=0']; % � ����� ������ =0
fprintf('г������ ������ ��� y1:\n%s\n',deqEuler_y1)
Euler_y2=simple(dFdy2-dFy2dt); % ������� ������ ��� y2
deqEuler_y2=[char(Euler_y2) '=0']; % � ����� ������ =0
fprintf('г������ ������ ��� y2:\n%s\n',deqEuler_y2)
eq_u = [char(dFdu) '=0'];
eq_L1 = [char(dFdL1) '=0'];
eq_L2 = [char(dFdL2) '=0'];
fprintf('г������ ��� u:\n%s\n',eq_u)
fprintf('г������ ��� L1:\n%s\n',eq_L1)
fprintf('г������ ��� L2:\n%s\n',eq_L2)

eq_L22 = char(subs(eq_L2,u,solve(eq_u,u)));
Sol=dsolve(deqEuler_y1, deqEuler_y2, eq_L1, eq_L22, 'y1(0) = 12', 'y2(0) = 6'); % ������� ������� ������

Left_y1=subs(Sol.y1,t,t1); % ��������� t1
Left_y2=subs(Sol.y2,t,t1); % ��������� t1
Eq_y1=[char(Left_y1) '=' char(sym(y1_t1))]; % =y1_t1
Eq_y2=[char(Left_y2) '=' char(sym(y2_t1))]; % =y2_t1
disp('г������ ��� ��������� ����:')
fprintf('%s\n',Eq_y1,Eq_y2)

Sol_U= solve(char(subs(eq_u,L2,Sol.L2)),u);
Con=solve(Eq_y1,Eq_y2,'C2,C4'); % ��������� �������
C2=Con.C2; % ���������� �������� ��������
C4=Con.C4; % ���������� ���������� C2 � C3
Sol_y1=vpa(eval(Sol.y1),10); % ��������� C3,C4
Sol_y2=vpa(eval(Sol.y2),10); % ��������� C3,C4
Sol_U=vpa(eval(Sol_U),10); % ��������� C3,C4
disp('г������ �������� ����')
fprintf('u(t)=%s\n',char(Sol_U))

JJ = u^2;
JJextr=subs(JJ,{u},{Sol_U});
Jextr=eval(int(JJextr,t,t0,t1))

tp1=linspace(t0,t1); % ������ ����� ������
U2=subs(Sol_U,t,tp1); % ��������� ��������
figure % ������
plot(tp1,U2,'-r') % ������ ������ �������� ���
set(get(gcf,'CurrentAxes'),...
  'FontName','Times New Roman Cyr','FontSize',12)
title('\bf���������') % ���������
xlabel('\itt') % ���� �� OX
ylabel('\itU\rm(\itt\rm)') % ���� �� OY


