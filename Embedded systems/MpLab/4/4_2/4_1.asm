#include<p16f84.inc>
start movlw b'00001011'
option
nop
  loop clrwdt
goto loop
nop
end