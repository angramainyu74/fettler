#!/bin/bash
##Create a map by adding a tile to a map image
##Args: <mapfilepath> <x> <y> <maptilepath> 
##  if mapfilepath does not exist, will create a map of size x and y with maptilepath 
##  if mapfilepath does exist, will add maptilepath at position x and y (0-indexed)

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

PIXELS_PER_SQUARE_SIDE=70
SQUARES_PER_TILE_SIDE=6
MAP_TILE_WIDTH=8
MAP_TILE_HEIGHT=6

##directories
TMPDIR=tmp
TILEDIR=output


##The rest is calculated automatically

##------------------------------------

PIXEL_COUNT=$(($PIXELS_PER_SQUARE_SIDE * 6))
CANVAS_SIZE="${PIXEL_COUNT}x${PIXEL_COUNT}"

if [ "$#" -ne 4 ]; then
	echo "Usage:"
	echo "  $0 <mapfilepath> <x> <y> <maptilepath>"
	echo "    if mapfilepath does not exist, will create a map of size x and y" 
	echo "       with maptilepath" 
	echo "    if mapfilepath does exist, will add maptilepath at position x and y" 
	echo "       (0-indexed)"
	exit 1
fi

MAP=$1
X_POS=$2
Y_POS=$3
TILE=$4

X_PIXEL_POS=$(($X_POS * $PIXELS_PER_SQUARE_SIDE * $SQUARES_PER_TILE_SIDE))
Y_PIXEL_POS=$(($Y_POS * $PIXELS_PER_SQUARE_SIDE * $SQUARES_PER_TILE_SIDE))
CANVAS_SIZE="${X_PIXEL_POS}x${Y_PIXEL_POS}"
GEOM="+${X_PIXEL_POS}+${Y_PIXEL_POS}"

if [ ! -f ${TILE} ]; then
	echo "Unable to find ${TILE}"
	exit 1
fi

if [ ! -f ${MAP} ]; then
	echo "Unable to find ${MAP}, creating ${MAP} with ${X_POS},${Y_POS} ${TILE}"
	magick -size ${CANVAS_SIZE} tile:${TILE} ${MAP}
else
	echo "Adding ${TILE} at ${X_POS},${Y_POS} to ${MAP}"
	magick composite -geometry ${GEOM} ${TILE} ${MAP} ${MAP}
fi

