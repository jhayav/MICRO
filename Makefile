EXE = pract1a.exe pract1c.exe

all: $(EXE)

pract1a.exe: pract1a.obj
	tlink /v pract1a

pract1a.obj: pract1a.asm
	tasm /zi pract1a.asm

pract1c.exe: pract1c.obj
	tlink /v pract1c

pract1c.obj: pract1c.asm
	tasm /zi pract1c.asm

clean: 
	del *.obj
	del *.exe
	del *.map
