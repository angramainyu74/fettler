#!/bin/bash
##Create a map by adding a tile to a map image
##Args: <mapfilepath> <x> <y> <maptilepath> 
##  if mapfilepath does not exist, will create a map of size x and y with maptilepath 
##  if mapfilepath does exist, will add maptilepath at position x and y (0-indexed)

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

PIXELS_PER_SQUARE_SIDE=50
SQUARES_PER_TILE_SIDE=6
MAP_TILE_WIDTH=28
MAP_TILE_HEIGHT=20

##directories
TMPDIR=tmp
GRIDDIR=grids
MASKDIR=masks
TILEDIR=output
TEXTUREDIR=seamless

MASK=school_mask.png

FLOOR=${TEXTUREDIR}/461223168.png
WALL=${TEXTUREDIR}/461223134.png
GRID=${GRIDDIR}/box_40_soft.png
SHADOW=true

#FLOOR=${TEXTUREDIR}/white.png
#WALL=${TEXTUREDIR}/hatch.png
#GRID=${GRIDDIR}/grid_40_hard.png
#SHADOW=false

#FLOOR=${TEXTUREDIR}/white.png
#WALL=${TEXTUREDIR}/blue.png
#GRID=${GRIDDIR}/grid_40_hard.png
#SHADOW=false
#EDGELESS=true

if [ ! -f ${WALL} ]; then
	echo "Unable to find ${WALL}"
	exit 1
fi
if [ ! -f ${FLOOR} ]; then
	echo "Unable to find ${FLOOR}"
	exit 1
fi
if [ ! -f ${GRID} ]; then
	echo "Unable to find ${GRID}"
	exit 1
fi

PIXEL_COUNTX=$(($MAP_TILE_WIDTH * $PIXELS_PER_SQUARE_SIDE * 6))
PIXEL_COUNTY=$(($MAP_TILE_HEIGHT * $PIXELS_PER_SQUARE_SIDE * 6))
CANVAS_SIZE="${PIXEL_COUNTX}x${PIXEL_COUNTY}"

magick convert -size ${CANVAS_SIZE} tile:${WALL} ${TMPDIR}/wall.png
magick convert -size ${CANVAS_SIZE} tile:${FLOOR} ${TMPDIR}/floor.png
magick convert -size ${CANVAS_SIZE} tile:${GRID} ${TMPDIR}/grid.png

magick convert ${TMPDIR}/floor.png ${TMPDIR}/grid.png -alpha Off -compose Hard_Light -composite -size ${CANVAS_SIZE} ${TMPDIR}/floor_with_grid.png
magick convert $MASK -resize ${CANVAS_SIZE} ${TMPDIR}/mask.png
magick convert ${TMPDIR}/wall.png ${TMPDIR}/mask.png -alpha off -compose copy_opacity -composite -size ${CANVAS_SIZE} ${TMPDIR}/wall_cutout.png
if [ "$SHADOW" == "true" ]; then
	magick convert ${TMPDIR}/mask.png -edge 5 -negate -blur 0x5 ${TMPDIR}/shadow.png
	magick convert ${TMPDIR}/floor_with_grid.png ${TMPDIR}/shadow.png -alpha Off -compose Multiply -composite ${TMPDIR}/floor_with_grid_and_shadow.png
	magick composite ${TMPDIR}/wall_cutout.png ${TMPDIR}/floor_with_grid_and_shadow.png ${TMPDIR}/merged.png
	magick convert ${TMPDIR}/merged.png ${TMPDIR}/shadow.png -alpha Off -compose Multiply -composite ${TMPDIR}/final.png
else
	if [ "$EDGELESS" == "true" ]; then
		magick composite ${TMPDIR}/wall_cutout.png ${TMPDIR}/floor_with_grid.png ${TMPDIR}/final.png
	else
		magick convert ${TMPDIR}/mask.png -edge 3 -negate ${TMPDIR}/shadow.png
		magick convert ${TMPDIR}/floor_with_grid.png ${TMPDIR}/shadow.png -alpha Off -compose Multiply -composite ${TMPDIR}/floor_with_grid_and_shadow.png
		magick composite ${TMPDIR}/wall_cutout.png ${TMPDIR}/floor_with_grid_and_shadow.png ${TMPDIR}/merged.png
		magick convert ${TMPDIR}/merged.png ${TMPDIR}/shadow.png -alpha Off -compose Multiply -composite ${TMPDIR}/final.png
	fi
fi
cp ${TMPDIR}/final.png school.png
