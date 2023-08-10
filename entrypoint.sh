#!/bin/sh

cd software
PICO_SDK_FETCH_FROM_GIT=on cmake .
make
cd ..

cd hardware
make
cd ..

zip -j release.zip hardware/*.stl software/*.uf2
