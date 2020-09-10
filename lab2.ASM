format PE CONSOLE 4.0
entry start

include '%fasminc%\win32a.inc'

section ".code" code readable writeable executable 

        equation db "z = ((a+b)*c-24)/(a*c-1)",13,10,"a = ",0
        wB db "b = ",0
        wC db "c = ",0
        solve db "z = ",0
        para db '%lf', 0
        parb db '%lf', 0
        parc db '%lf', 0
        par1 db '%lf', 0
        par2 db '%1.5f', 13, 10, 0
        value dd 4.9
        tf dq 24.0
        o dq 1.0
        a dq 0
        b dq 0
        c dq 0
        f1 dq 0
        f2 dq 0
        z dq 0

start:
        cinvoke printf, equation
        cinvoke scanf, para, a
        cinvoke printf, wB
        cinvoke scanf, parb, b
        cinvoke printf, wC
        cinvoke scanf, parc, c

        finit
        fld [a]
        fld [b]
        faddp
        fld [c]
        fmulp
        fld [tf]
        fsubp
        fstp qword [f1]

        finit
        fld [a]
        fld [c]
        fmulp
        fld [o]
        fsubp
        fstp qword [f2]

        finit
        fld [f1]
        fld [f2]
        fdivp

        fstp qword [z]
        cinvoke printf, solve
        cinvoke printf, par2, dword[z], dword[z + 4]

        call [getch]
        push 0
        call [ExitProcess]

section '.idata' import data readable writeable

  library kernel32,'kernel32.dll',\
           msvcrt,'msvcrt.dll'

  import kernel32,\
          ExitProcess,'ExitProcess'

  import msvcrt,\
          printf,  'printf',\
          scanf,   'scanf',\
          system,  'system',\
          getch,   '_getch'

