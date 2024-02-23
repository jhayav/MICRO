EXE = pract1a.exe

all: $(EXE)

pract1a.exe: pract1a.obj
	tlink /v pract1a

pract1a.obj: pract1a.asm
	tasm /zi pract1a.asm

clean: 
	del *.obj
	del *.exe
	del *.map