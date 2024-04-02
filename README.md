<p align="center"> <img src="./screenshot.png"> </p>

## Quick Start
clone the project
```
git clone https://github.com/tmartiro/voc-snake
cd voc-snake
```

VOC compiler build
```
git clone https://github.com/vishaps/voc
make full -C voc
```
Raylib library build
(for linux build you need to have following libraries preinstalled `libwayland-dev libxkbcommon-dev xorg-dev`)
```
git clone --depth=1 https://github.com/raysan5/raylib.git
make -C raylib/src
```

Linux: Finally build and run the example program written in Oberon2
```
./build-linux.sh
```

OSX: Finally build and run the example program written in Oberon2
```
./build-osx.sh
```


