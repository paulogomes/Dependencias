## Instalar o pacote dependencias
#
DESTDIR=./dist/
BIN=$(DESTDIR)/bin
VAR=$(DESTDIR)/var/lib
#MAN=$(DESTDIR)/usr/man
ETC=$(DESTDIR)/etc

all: instalar

instalar: cria_estrutura
	install -C -D ./dependencias $(BIN)/dependencias
	install -C -D ./repositorio $(ETC)/dependencias/repositorio

cria_estrutura: cria_DESTDIR
	#mkdir -p $(MAN)
	mkdir -p $(VAR)/dependencias

cria_DESTDIR:
	mkdir -p $(DESTDIR)