#!/usr/bin/env bash

ar x raylib/libraylib.a
csc -I. -c raylib/raylib.scm -o raylib.o
csc *.o -L -lGL -L -lm -L -lpthread -L -ldl -L -lrt -L -lX11 -dynamic -o raylib/raylib.so
rm *.o
