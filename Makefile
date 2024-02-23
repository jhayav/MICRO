all: p1.exe

p1.exe: p1.obj
	tlink /v p1

p1.obj: p1.asm
	tasm /zi p1.asm

.PHONY : clean
clean: 
	del *.obj
	del *.exe
	del *.map