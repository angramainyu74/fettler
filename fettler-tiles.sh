#!/bin/bash
##Apply a grid to a set of masks, using a wall and floor texture

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

PIXELS_PER_SQUARE_SIDE=70

##directories
TMPDIR=tmp
GRIDDIR=grids
MASKDIR=masks
TILEDIR=output
TEXTUREDIR=seamless


##Some predefined combinations

#PREFIX=classic_
#FLOOR=${TEXTUREDIR}/white.png
#WALL=${TEXTUREDIR}/blue.png
#GRID=${GRIDDIR}/grid_40_hard.png
#SHADOW=false
#EDGELESS=true

#PREFIX=cracked_
#FLOOR=${TEXTUREDIR}/Ground-Texture-Earth-Seamless-Tileable-Cracks-1807373.png
#WALL=${TEXTUREDIR}/4601588797_a6ced2011a_z.png
#GRID=${GRIDDIR}/cross_75_hard.png
#SHADOW=true

#PREFIX=moss_
#FLOOR=${TEXTUREDIR}/8148480132_a5fe6e6fed_z.png
#WALL=${TEXTUREDIR}/461223134.png
#GRID=${GRIDDIR}/grid_60_soft.png
#SHADOW=true

PREFIX=hatch_
FLOOR=${TEXTUREDIR}/white.png
WALL=${TEXTUREDIR}/hatch.png
GRID=${GRIDDIR}/grid_40_hard.png
SHADOW=false

#PREFIX=stone_
#FLOOR=${TEXTUREDIR}/461223168.png
#WALL=${TEXTUREDIR}/461223139.png
#GRID=${GRIDDIR}/box_75_soft.png
#SHADOW=true

#PREFIX=stone2_
#FLOOR=${TEXTUREDIR}/20537699384_b3e88b05f4_b.png
#WALL=${TEXTUREDIR}/4818273071_c3b375a183_b.png
#GRID=${GRIDDIR}/blank.png
#SHADOW=true


##The rest is calculated automatically

##------------------------------------

PIXEL_COUNT=$(($PIXELS_PER_SQUARE_SIDE * 6))
CANVAS_SIZE="${PIXEL_COUNT}x${PIXEL_COUNT}"

echo "Making tiles, this may take several minutes..."

mkdir -p ${TMPDIR}
mkdir -p ${TILEDIR}

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

magick convert ${WALL} -resize ${CANVAS_SIZE} ${TMPDIR}/wall.png
magick convert ${FLOOR} -resize ${CANVAS_SIZE} ${TMPDIR}/floor.png
magick convert ${GRID} -resize ${CANVAS_SIZE} ${TMPDIR}/grid.png

magick convert ${TMPDIR}/floor.png ${TMPDIR}/grid.png -alpha Off -compose Hard_Light -composite -size ${CANVAS_SIZE} ${TMPDIR}/floor_with_grid.png
for MASK in ${MASKDIR}/*.png; do
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
	cp ${TMPDIR}/final.png "${TILEDIR}/${PREFIX}$(basename "$MASK")"
done

echo "... done."
