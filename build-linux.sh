#!/bin/sh

set -xe
voc=./voc/install/bin/voc
voc_lib=./voc/install/lib/
raylib=./raylib/src/libraylib.a

compile() {
	$voc -ce  Raylib.Mod
	$voc -cm  Snake.Mod
	gcc  -g  *.o -o Snake -L${voc_lib} -lvoc-O2 -L./raylib/src -L/usr/local/lib -lraylib -lm

}


run() {
	LD_LIBRARY_PATH=${voc_lib} ./Snake
}

case $1 in
	run)
		run
		;;
	build)
		compile_osx
		;;
	example)
		compile_example
		;;
	clean)
		rm -rf *.o *.h *.c *.sym *.tmp*
		;;
	*)
		compile
		run
		;;
esac
