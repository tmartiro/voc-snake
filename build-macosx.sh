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
		-L${voc_lib} -lvoc-O2 \
		${raylib} \
		-framework OpenGL -framework Cocoa -framework IOKit -framework CoreAudio -framework CoreVideo
}

compile_wasm() {
	$voc -ce  Raylib.Mod
	$voc -cm  Snake.Mod
	clang -I${voc_include} --target=wasm32 -emit-llvm --no-standard-libraries -c -S Snake.c Raylib.c
	llc -march=wasm32 -filetype=obj Snake.ll
	llc -march=wasm32 -filetype=obj Raylib.ll
	wasm-ld --no-entry --export=Snake_Init --export=Snake_Update --allow-undefined -o snake.wasm Snake.o Raylib.o
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

