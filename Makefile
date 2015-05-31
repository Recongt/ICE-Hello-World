all: client server Printer.h Printer.cpp Server.o Client.o Printer.o

Printer.cpp Printer.h: Printer.ice
	rm -f Printer.h Printer.cpp
	/usr/bin/slice2cpp -I. -I/usr/share/Ice-3.5.1/slice Printer.ice

Client.o Printer.o: Printer.cpp Client.cpp
	rm -f Client.o Printer.o
	g++ -c -I.   -Wall -Werror -pthread -fPIC -g  Printer.cpp
	g++ -c -I.   -Wall -Werror -pthread -fPIC -g  Client.cpp

client: Client.o Printer.o
	rm -f client
	g++  -Wall -Werror -pthread -fPIC -g --enable-new-dtags -rdynamic -Wall -Werror -pthread -fPIC -g -o client Printer.o Client.o -lIce -lIceUtil

Server.o: Server.cpp
	rm -f Server.o
	g++ -c -I.   -Wall -Werror -pthread -fPIC -g  Server.cpp

server: Server.o Printer.o
	rm -f server
	g++  -Wall -Werror -pthread -fPIC -g --enable-new-dtags -rdynamic  -Wall -Werror -pthread -fPIC -g -o server Server.o Printer.o -lIce -lIceUtil

clean:
	rm -f Printer.h Printer.cpp
	rm -f Client.o Printer.o
	rm -f Server.o
	rm -f client
	rm -f server

.PHONY: all clean