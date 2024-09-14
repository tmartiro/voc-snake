#!/bin/sh

set -xe
voc=./voc/install/bin/voc
voc_lib=./voc/install/lib/
voc_include=./voc/install/C/include
raylib=./raylib/src/libraylib.a

compile_osx() {
	$voc -ce  Raylib.Mod
	$voc -cm  Snake.Mod
	clang \
		-g \
		*.o -o Snake \
		-L${voc_lib} \
		${raylib} \
		${voc_lib}\libvoc-O2.a \
		-framework OpenGL -framework Cocoa -framework IOKit -framework CoreAudio -framework CoreVideo
}

compile_wasm() {
	compile_osx
	clang --target=wasm32 -I ${voc_include} -emit-llvm -c -S Snake.c
	llc -march=wasm32 -filetype=obj Snake.ll
	wasm-ld --no-entry --export-all --allow-undefined -o snake.wasm Snake.o
}

run() {
	LD_LIBRARY_PATH=${voc_lib} DYLD_LIBRARY_PATH=${voc_lib} ./Snake
}

case $1 in
	run)
		run
		;;
	build)
		compile_osx
		;;
	wasm)
		compile_wasm
		;;
	example)
		compile_example
		;;
	clean)
		rm -rf Snake *.o *.h *.c *.sym *.tmp* *.ll
		;;
	*)
		compile_osx
		run
		;;
esac

