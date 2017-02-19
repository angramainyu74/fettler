#!/bin/bash
##Create a set of overlay grids.  The overlay will appear on the floor,
##but not the wall.

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

##All this assumes your tiles are 6 "units" square, other values are 
##possible but will require changes

##Modify this to change the height/width of each square, the grids 
##will be 6x6 squares.  For best results, generate your grids at the
##same size you will create the tiles.
PIXELS_PER_SQUARE_SIDE=70
SQUARES_PER_TILE_SIDE=6

##Output directories
TMPDIR=tmp
GRIDDIR=grids


##The rest is calculated automatically

##------------------------------------

PIXEL_COUNT=$(($PIXELS_PER_SQUARE_SIDE * $SQUARES_PER_TILE_SIDE))
CANVAS_SIZE="${PIXEL_COUNT}x${PIXEL_COUNT}"
SQUARE_SIZE="${PIXELS_PER_SQUARE_SIDE}x${PIXELS_PER_SQUARE_SIDE}"
PIXELS_MINUS_1=$(($PIXELS_PER_SQUARE_SIDE - 1))
PIXELS_MINUS_2=$(($PIXELS_PER_SQUARE_SIDE - 2))
PIXELS_10=$(($PIXELS_PER_SQUARE_SIDE/10))
PIXELS_90=$(($PIXELS_PER_SQUARE_SIDE - PIXELS_10 - 1))

mkdir -p ${TMPDIR}
mkdir -p ${GRIDDIR}

echo "Making grids..."

magick -size ${CANVAS_SIZE} xc:grey50 ${GRIDDIR}/blank.png
magick -size ${SQUARE_SIZE} xc:grey75 -fill grey50 -draw "rectangle 1,1 ${PIXELS_MINUS_2},${PIXELS_MINUS_2}" ${TMPDIR}/tile75.png
magick -size ${SQUARE_SIZE} xc:grey60 -fill grey50 -draw "rectangle 1,1 ${PIXELS_MINUS_2},${PIXELS_MINUS_2}" ${TMPDIR}/tile60.png

magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/tile75.png ${GRIDDIR}/grid_75_hard.png
magick convert ${GRIDDIR}/grid_75_hard.png -blur 0x1 ${GRIDDIR}/grid_75_soft.png
magick convert -alpha off ${GRIDDIR}/grid_75_hard.png -negate ${GRIDDIR}/grid_25_hard.png
magick convert ${GRIDDIR}/grid_25_hard.png -blur 0x1 ${GRIDDIR}/grid_25_soft.png
magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/tile60.png ${GRIDDIR}/grid_60_hard.png
magick convert ${GRIDDIR}/grid_60_hard.png -blur 0x1 ${GRIDDIR}/grid_60_soft.png
magick convert -alpha off ${GRIDDIR}/grid_60_hard.png -negate ${GRIDDIR}/grid_40_hard.png
magick convert ${GRIDDIR}/grid_40_hard.png -blur 0x1 ${GRIDDIR}/grid_40_soft.png

magick -size ${SQUARE_SIZE} xc:grey60 -fill grey50 -draw "rectangle 1,1 ${PIXELS_MINUS_2},${PIXELS_MINUS_2}" -fill grey50 -draw "rectangle 0,${PIXELS_10} ${PIXEL_COUNT},${PIXELS_90} rectangle ${PIXELS_10},0 ${PIXELS_90},${PIXEL_COUNT}" ${TMPDIR}/cross60.png
magick -size ${SQUARE_SIZE} xc:grey75 -fill grey50 -draw "rectangle 1,1 ${PIXELS_MINUS_2},${PIXELS_MINUS_2}" -fill grey50 -draw "rectangle 0,${PIXELS_10} ${PIXEL_COUNT},${PIXELS_90} rectangle ${PIXELS_10},0 ${PIXELS_90},${PIXEL_COUNT}" ${TMPDIR}/cross75.png

magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/cross75.png ${GRIDDIR}/cross_75_hard.png
magick convert ${GRIDDIR}/cross_75_hard.png -blur 0x1 ${GRIDDIR}/cross_75_soft.png
magick convert -alpha off ${GRIDDIR}/cross_75_hard.png -negate ${GRIDDIR}/cross_25_hard.png
magick convert ${GRIDDIR}/cross_25_hard.png -blur 0x1 ${GRIDDIR}/cross_25_soft.png
magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/cross60.png ${GRIDDIR}/cross_60_hard.png
magick convert ${GRIDDIR}/cross_60_hard.png -blur 0x1 ${GRIDDIR}/cross_60_soft.png
magick convert -alpha off ${GRIDDIR}/cross_60_hard.png -negate ${GRIDDIR}/cross_40_hard.png
magick convert ${GRIDDIR}/cross_40_hard.png -blur 0x1 ${GRIDDIR}/cross_40_soft.png

magick -size ${SQUARE_SIZE} xc:grey50 -stroke grey75 -draw "line 0,0 0,${PIXELS_MINUS_1} line 0,0 ${PIXELS_MINUS_1},0" -stroke grey25 -draw "line 0,${PIXELS_MINUS_1}, ${PIXELS_MINUS_1},${PIXELS_MINUS_1} line ${PIXELS_MINUS_1},1 ${PIXELS_MINUS_1},${PIXELS_MINUS_1}" ${TMPDIR}/box75.png
magick -size ${SQUARE_SIZE} xc:grey50 -stroke grey60 -draw "line 0,0 0,${PIXELS_MINUS_1} line 0,0 ${PIXELS_MINUS_1},0" -stroke grey40 -draw "line 0,${PIXELS_MINUS_1}, ${PIXELS_MINUS_1},${PIXELS_MINUS_1} line ${PIXELS_MINUS_1},1 ${PIXELS_MINUS_1},${PIXELS_MINUS_1}" ${TMPDIR}/box60.png

magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/box75.png ${GRIDDIR}/box_75_hard.png
magick convert ${GRIDDIR}/box_75_hard.png -blur 0x1 ${GRIDDIR}/box_75_soft.png
magick convert -alpha off ${GRIDDIR}/box_75_hard.png -negate ${GRIDDIR}/box_25_hard.png
magick convert ${GRIDDIR}/box_25_hard.png -blur 0x1 ${GRIDDIR}/box_25_soft.png
magick convert -size ${CANVAS_SIZE} tile:${TMPDIR}/box60.png ${GRIDDIR}/box_60_hard.png
magick convert ${GRIDDIR}/box_60_hard.png -blur 0x1 ${GRIDDIR}/box_60_soft.png
magick convert -alpha off ${GRIDDIR}/box_60_hard.png -negate ${GRIDDIR}/box_40_hard.png
magick convert ${GRIDDIR}/box_40_hard.png -blur 0x1 ${GRIDDIR}/box_40_soft.png

echo "... done."

