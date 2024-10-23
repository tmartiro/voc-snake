<p align="center"> <img src="./screenshot.png"> </p>

## Quick Start
clone the project
```
git clone https://github.com/tmartiro/voc-snake
cd voc-snake
# install dependencies
```
***Linux build***: build and run Odzik
```
./build-linux.sh
```

***OSX***: build and run Odzik
```
./build-macosx.sh
```

***WASM***: The build has been tested on OSX

Some portions of the JavaScript glue code were derived from the [zozlib]( https://github.com/tsoding/zozlib.js) library (kudos to [Alexey Kutepov](https://github.com/rexim))
```
./build-macosx.sh wasm
# run http server because of wasm
python -m http.server
# open in the browser http://localhost:8000
```
[Try demo with wasm!](https://tmartiro.github.io/voc-snake)


## Dependencies
[VOC](https://github.com/vishapoberon/compiler) is a free implementation of the Oberon-2 language and libraries for use on conventional operating systems such as Linux, BSD, Android, Mac and Windows

VOC compiler build 
```
# git clone the project in the same folder where you cloned this repo
git clone https://github.com/vishaps/voc
make full -C voc
```
[Raylib](https://github.com/raysan5/raylib.git) is a simple and easy-to-use library to enjoy videogames programming.

Raylib library build
(for linux build you need to have following libraries preinstalled `libwayland-dev libxkbcommon-dev xorg-dev`)
```
# git clone the project in the same folder where you cloned this repo
git clone --depth=1 https://github.com/raysan5/raylib.git
make -C raylib/src
```



