GO_IMPLIB = go-fib/libgofib.a
GO_SRC = go-fib/main.go

EXE = exe/main.exe
EXE_SRC = exe/main.cpp
EXE_LIB = -Ldll -lgofib
EXE_CFLAGS =

DLL = dll/gofib.dll
DLL_IMPLIB = dll/libgofib.dll.a
DLL_SRC = dll/gofib.cpp
DLL_DEF = dll/gofib.def
DLL_LIB = -Lgo-fib -lgofib -lwinmm -lws2_32 -lntdll
DLL_CFLAGS = -Wl,--out-implib=$(DLL_IMPLIB)

INCDIR = -Igo-fib

CC = gcc
RM = rm -f
CP = cp

$(EXE) : $(EXE_SRC) $(DLL_IMPLIB)
	$(CC) -o $@ $(EXE_SRC) $(EXE_CFLAGS) $(INCDIR) $(EXE_LIB)
	$(CP) $(DLL) $(dir $(EXE))

$(DLL_IMPLIB) : $(DLL)

$(DLL) : $(DLL_SRC) $(DLL_DEF) $(GO_IMPLIB)
	$(CC) -o $@ -mdll $(DLL_SRC) $(DLL_DEF) $(DLL_CFLAGS) $(INCDIR) $(DLL_LIB)

$(GO_IMPLIB) : $(GO_SRC)
	go build -buildmode=c-archive -o $(GO_IMPLIB) $(GO_SRC)

clean :
	$(RM) $(GO_IMPLIB) $(addsuffix .h, $(basename $(GO_IMPLIB))) \
		$(DLL) $(DLL_IMPLIB) \
		$(EXE) $(join $(dir $(EXE)),$(notdir $(DLL)))
