#!/bin/bash
PREFIX=hatch_
TILEDIR=output
MAP=sample-map.png
if [ -f ${MAP} ]; then
	rm ${MAP}
fi
./fettler-map.sh ${MAP} 6 5 ${TILEDIR}/${PREFIX}tile_wall.png
./fettler-map.sh ${MAP} 0 0 ${TILEDIR}/${PREFIX}tile003.png
./fettler-map.sh ${MAP} 1 0 ${TILEDIR}/${PREFIX}tile009_r180.png
./fettler-map.sh ${MAP} 2 0 ${TILEDIR}/${PREFIX}tile011_r180.png
./fettler-map.sh ${MAP} 3 0 ${TILEDIR}/${PREFIX}tile115.png
./fettler-map.sh ${MAP} 4 0 ${TILEDIR}/${PREFIX}tile044_r090.png
./fettler-map.sh ${MAP} 5 0 ${TILEDIR}/${PREFIX}tile024_r180.png
./fettler-map.sh ${MAP} 0 1 ${TILEDIR}/${PREFIX}tile004_r090.png
./fettler-map.sh ${MAP} 1 1 ${TILEDIR}/${PREFIX}tile005_r090.png
./fettler-map.sh ${MAP} 2 1 ${TILEDIR}/${PREFIX}tile181_r270.png
./fettler-map.sh ${MAP} 3 1 ${TILEDIR}/${PREFIX}tile044_r270.png
./fettler-map.sh ${MAP} 4 1 ${TILEDIR}/${PREFIX}tile115_r180.png
./fettler-map.sh ${MAP} 5 1 ${TILEDIR}/${PREFIX}tile198_r180.png
./fettler-map.sh ${MAP} 0 2 ${TILEDIR}/${PREFIX}tile144_r180.png
./fettler-map.sh ${MAP} 1 2 ${TILEDIR}/${PREFIX}tile152_r270.png
./fettler-map.sh ${MAP} 2 2 ${TILEDIR}/${PREFIX}tile150.png
./fettler-map.sh ${MAP} 3 2 ${TILEDIR}/${PREFIX}tile148_r090.png
./fettler-map.sh ${MAP} 4 2 ${TILEDIR}/${PREFIX}tile014_r090.png
./fettler-map.sh ${MAP} 5 2 ${TILEDIR}/${PREFIX}tile146_r180.png
./fettler-map.sh ${MAP} 0 3 ${TILEDIR}/${PREFIX}tile090.png
./fettler-map.sh ${MAP} 1 3 ${TILEDIR}/${PREFIX}tile149_r270.png
./fettler-map.sh ${MAP} 2 3 ${TILEDIR}/${PREFIX}tile063.png
./fettler-map.sh ${MAP} 3 3 ${TILEDIR}/${PREFIX}tile150_r090.png
./fettler-map.sh ${MAP} 4 3 ${TILEDIR}/${PREFIX}tile146_r090.png
./fettler-map.sh ${MAP} 5 3 ${TILEDIR}/${PREFIX}tile045.png
./fettler-map.sh ${MAP} 0 4 ${TILEDIR}/${PREFIX}tile225_r090.png
./fettler-map.sh ${MAP} 1 4 ${TILEDIR}/${PREFIX}tile151_r270.png
./fettler-map.sh ${MAP} 2 4 ${TILEDIR}/${PREFIX}tile149_r180.png
./fettler-map.sh ${MAP} 3 4 ${TILEDIR}/${PREFIX}tile148_r180.png
./fettler-map.sh ${MAP} 4 4 ${TILEDIR}/${PREFIX}tile011_r090.png
./fettler-map.sh ${MAP} 5 4 ${TILEDIR}/${PREFIX}tile014_r270.png
