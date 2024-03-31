#!/bin/sh

set -xe
voc=./voc/install/bin/voc
voc_lib=./voc/install/lib/
raylib=./raylib/src/libraylib.a

compile_osx() {
	$voc -ce  Raylib.Mod
	$voc -cm  Window.Mod
	clang \
		-g \
		*.o -o Window \
		-L${voc_lib} -lvoc-O2 \
		${raylib} \
		-framework OpenGL -framework Cocoa -framework IOKit -framework CoreAudio -framework CoreVideo
}

compile_example() {
	clang \
		-g shapes_rectangle_scaling.c \
		-o example \
		${raylib} \
		-framework OpenGL -framework Cocoa -framework IOKit -framework CoreAudio -framework CoreVideo

}

run() {
	LD_LIBRARY_PATH=${voc_lib} DYLD_LIBRARY_PATH=${voc_lib} ./Window
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
		compile_osx
		run
		;;
esac

