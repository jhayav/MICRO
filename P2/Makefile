EXE = pract2a.exe

all: $(EXE)

pract2a.exe: pract2a.obj
	tlink /v pract2a

pract2a.obj: pract2a.asm
	tasm /zi pract2a.asm

clean: 
	del *.obj
	del *.exe
	del *.map
