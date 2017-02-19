#!/bin/bash
##Create a set of tile masks, white for walls, black for floor.

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

##All this assumes your tiles are 6 "units" square, other values are 
##possible but will require changes

##Modify this to change the height/width of each square, the masks 
##will be 6x6 squares.  For best results, generate your masks at the
##same size you will create the tiles.
PIXELS_PER_SQUARE_SIDE=70

##Set to true if you want rotated versions of the masks
ROTATE=true
#ROTATE=false

##Output location to write the mask files
MASKDIR=masks


##The rest is calculated automatically

##------------------------------------

PIXEL_COUNT=$(($PIXELS_PER_SQUARE_SIDE * 6))
CANVAS_SIZE="${PIXEL_COUNT}x${PIXEL_COUNT}"

#set up subdivisions: _O for "outside" measure, _I for "inside" (the outside minus 1)
P0_O=0
P1_O=$(($PIXEL_COUNT / 6))
P1_I=$(($P1_O - 1))
P2_O=$(($P1_O * 2))
P2_I=$(($P2_O - 1))
P3_O=$(($P1_O * 3))
P3_I=$(($P3_O - 1))
P4_O=$(($P1_O * 4))
P4_I=$(($P4_O - 1))
P5_O=$(($P1_O * 5))
P5_I=$(($P5_O - 1))
P6_O=$(($P1_O * 6))
P6_I=$(($P6_O - 1))

mkdir -p ${MASKDIR}

#mask tile definitions

echo "Making masks, this may take a moment..."

magick -size ${CANVAS_SIZE} xc:black ${MASKDIR}/tile_floor.png
magick -size ${CANVAS_SIZE} xc:white ${MASKDIR}/tile_wall.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I}" ${MASKDIR}/tile001.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I}" ${MASKDIR}/tile002.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I}" ${MASKDIR}/tile003.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile004.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile005.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile006.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} circle ${P2_I},${P2_I} ${P0_O},${P2_I}" -fill white -draw "rectangle ${P0_O},${P0_O} ${P1_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} circle ${P1_O},${P1_O} ${P1_O},${P2_I}" ${MASKDIR}/tile007.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P4_I},${P4_I} rectangle ${P1_O},${P1_O} ${P2_I},${P5_I}" -fill white -draw "circle ${P1_O},${P1_O} ${P1_O},${P2_I} circle ${P1_O},${P5_I} ${P2_I},${P5_I}" ${MASKDIR}/tile008.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P1_O},${P1_O} ${P5_I},${P5_I}" ${MASKDIR}/tile009.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P1_O},${P1_O} ${P5_I},${P5_I}" ${MASKDIR}/tile010.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P1_O},${P1_O} ${P5_I},${P5_I}" ${MASKDIR}/tile011.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P1_O},${P1_O} ${P5_I},${P5_I}" ${MASKDIR}/tile012.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} rectangle ${P1_O},${P1_O} ${P5_I},${P5_I}" ${MASKDIR}/tile013.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P3_I} circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P1_I}" ${MASKDIR}/tile014.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P1_I}" ${MASKDIR}/tile015.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} circle ${P3_I},${P3_I} ${P1_O},${P3_I}" ${MASKDIR}/tile016.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P1_I}" ${MASKDIR}/tile017.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P1_I}" ${MASKDIR}/tile018.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I}" ${MASKDIR}/tile019.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P3_O},${P1_O} ${P5_I},${P5_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I}" ${MASKDIR}/tile020.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I}" ${MASKDIR}/tile021.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P5_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I} circle ${P4_O},${P2_I} ${P5_I},${P2_I} circle ${P4_O},${P4_O} ${P4_O},${P5_I}" ${MASKDIR}/tile022.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P5_I} rectangle ${P0_O},${P2_O} ${P5_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I} circle ${P4_O},${P2_I} ${P5_I},${P2_I} circle ${P4_O},${P4_O} ${P4_O},${P5_I}" ${MASKDIR}/tile023.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P5_I} rectangle ${P1_O},${P2_O} ${P5_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I} circle ${P4_O},${P2_I} ${P5_I},${P2_I} circle ${P4_O},${P4_O} ${P4_O},${P5_I}" ${MASKDIR}/tile024.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P1_O},${P2_O} ${P5_I},${P4_I} circle ${P2_I},${P2_I} ${P1_O},${P2_I} circle ${P2_I},${P4_O} ${P2_I},${P5_I} circle ${P4_O},${P2_I} ${P5_I},${P2_I} circle ${P4_O},${P4_O} ${P4_O},${P5_I}" ${MASKDIR}/tile025.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P3_I} circle ${P3_I}.5,${P3_I} ${P3_I}.5,${P2_O}" ${MASKDIR}/tile026.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} rectangle ${P4_O},${P0_O} ${P6_I},${P1_I}" ${MASKDIR}/tile027.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I}" ${MASKDIR}/tile028.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I}" ${MASKDIR}/tile029.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} rectangle ${P4_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P5_O} ${P1_I},${P6_I} rectangle ${P5_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile030.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P5_O} ${P1_I},${P6_I} rectangle ${P5_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile031.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P5_O},${P5_O} ${P6_I},${P6_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I}" ${MASKDIR}/tile032.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} rectangle ${P4_O},${P0_O} ${P6_I},${P1_I} circle ${P0_O},${P6_I} ${P1_I},${P6_I} circle ${P6_I},${P6_I} ${P5_I},${P6_I}" ${MASKDIR}/tile033.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} circle ${P0_O},${P6_I} ${P1_I},${P6_I} circle ${P6_I},${P6_I} ${P5_I},${P6_I}" ${MASKDIR}/tile034.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} circle ${P6_I},${P6_I} ${P5_I},${P6_I}" ${MASKDIR}/tile035.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P1_I},${P1_I}" ${MASKDIR}/tile036.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P0_O},${P0_O} ${P0_O},${P1_I}" ${MASKDIR}/tile037.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P1_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} circle ${P1_O},${P1_O} ${P1_O},${P2_I}" ${MASKDIR}/tile038.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P2_I}" -fill black -draw "circle ${P2_I},${P2_I} ${P1_O},${P2_I}" ${MASKDIR}/tile039.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P0_O},${P0_O} ${P2_I},${P2_I}" -fill black -draw "circle ${P2_I},${P2_I} ${P1_O},${P2_I}" ${MASKDIR}/tile040.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P0_O},${P0_O} ${P3_I},${P3_I}" -fill black -draw "circle ${P3_I},${P3_I} ${P1_O},${P3_I}" ${MASKDIR}/tile041.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P0_O},${P0_O} ${P4_I},${P4_I}" -fill black -draw "circle ${P4_I},${P4_I} ${P1_O},${P4_I}" ${MASKDIR}/tile042.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P0_O},${P0_O} ${P5_I},${P5_I}" -fill black -draw "circle ${P5_I},${P5_I} ${P1_O},${P5_I}" ${MASKDIR}/tile043.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${P6_I},${P6_I} ${P1_O},${P6_I}" ${MASKDIR}/tile044.png

magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile040.png ${MASKDIR}/tile045.png
magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile041.png ${MASKDIR}/tile046.png
magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile042.png ${MASKDIR}/tile047.png
magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile043.png ${MASKDIR}/tile048.png
magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile044.png ${MASKDIR}/tile049.png

magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile040.png ${MASKDIR}/tile050.png
magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile041.png ${MASKDIR}/tile051.png
magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile042.png ${MASKDIR}/tile052.png
magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile043.png ${MASKDIR}/tile053.png
magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile044.png ${MASKDIR}/tile054.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P6_I}" ${MASKDIR}/tile055.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P6_I} rectangle ${P0_O},${P0_O} ${P3_I},${P3_I}" -fill black -draw "circle ${P3_I},${P3_I} ${P2_O},${P3_I}" ${MASKDIR}/tile056.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P6_I} rectangle ${P0_O},${P0_O} ${P4_I},${P4_I}" -fill black -draw "circle ${P4_I},${P4_I} ${P2_O},${P4_I}" ${MASKDIR}/tile057.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P2_I} rectangle ${P0_O},${P0_O} ${P2_I},${P6_I} rectangle ${P0_O},${P0_O} ${P5_I},${P5_I}" -fill black -draw "circle ${P5_I},${P5_I} ${P2_O},${P5_I}" ${MASKDIR}/tile058.png

magick composite -compose Screen ${MASKDIR}/tile038.png -rotate 180 ${MASKDIR}/tile056.png ${MASKDIR}/tile059.png
magick composite -compose Screen ${MASKDIR}/tile038.png -rotate 180 ${MASKDIR}/tile057.png ${MASKDIR}/tile060.png
magick composite -compose Screen ${MASKDIR}/tile038.png -rotate 180 ${MASKDIR}/tile058.png ${MASKDIR}/tile061.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P2_O}" ${MASKDIR}/tile062.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P3_I}.5,${P3_I}.5 ${P3_I}.5,${P1_O}" ${MASKDIR}/tile063.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P2_O},${P2_O} ${P4_I},${P4_I}" ${MASKDIR}/tile064.png

magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 180 ${MASKDIR}/tile036.png ${MASKDIR}/tile065.png
magick composite -compose Screen ${MASKDIR}/tile036.png -rotate 90 ${MASKDIR}/tile065.png ${MASKDIR}/tile066.png
magick composite -compose Screen ${MASKDIR}/tile065.png -rotate 90 ${MASKDIR}/tile065.png ${MASKDIR}/tile067.png

magick composite -compose Screen ${MASKDIR}/tile067.png ${MASKDIR}/tile064.png ${MASKDIR}/tile068.png

magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 180 ${MASKDIR}/tile037.png ${MASKDIR}/tile069.png
magick composite -compose Screen ${MASKDIR}/tile037.png -rotate 90 ${MASKDIR}/tile069.png ${MASKDIR}/tile070.png
magick composite -compose Screen ${MASKDIR}/tile069.png -rotate 90 ${MASKDIR}/tile069.png ${MASKDIR}/tile071.png

magick composite -compose Screen ${MASKDIR}/tile071.png ${MASKDIR}/tile062.png ${MASKDIR}/tile072.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P2_I}" ${MASKDIR}/tile073.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P3_I}" ${MASKDIR}/tile074.png

magick composite -compose Screen ${MASKDIR}/tile038.png -rotate 180 ${MASKDIR}/tile038.png ${MASKDIR}/tile075.png
magick composite -compose Screen ${MASKDIR}/tile038.png -rotate 90 ${MASKDIR}/tile075.png ${MASKDIR}/tile076.png
magick composite -compose Screen ${MASKDIR}/tile075.png -rotate 90 ${MASKDIR}/tile075.png ${MASKDIR}/tile077.png

magick composite -compose Screen ${MASKDIR}/tile077.png ${MASKDIR}/tile062.png ${MASKDIR}/tile078.png

magick composite -compose Screen ${MASKDIR}/tile039.png -rotate 180 ${MASKDIR}/tile039.png ${MASKDIR}/tile079.png
magick composite -compose Screen ${MASKDIR}/tile039.png -rotate 90 ${MASKDIR}/tile079.png ${MASKDIR}/tile080.png
magick composite -compose Screen ${MASKDIR}/tile079.png -rotate 90 ${MASKDIR}/tile079.png ${MASKDIR}/tile081.png

magick composite -compose Screen ${MASKDIR}/tile081.png ${MASKDIR}/tile062.png ${MASKDIR}/tile082.png

magick convert -alpha off ${MASKDIR}/tile073.png -negate ${MASKDIR}/tile083.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P1_O},${P1_O} ${P5_I},${P4_I}" ${MASKDIR}/tile084.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P1_O},${P1_O} ${P5_I},${P3_I}" ${MASKDIR}/tile085.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P3_I} rectangle ${P1_O},${P1_O} ${P5_I},${P3_I}" ${MASKDIR}/tile086.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I}" ${MASKDIR}/tile087.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P4_I}" ${MASKDIR}/tile088.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P3_I}" ${MASKDIR}/tile089.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I}" ${MASKDIR}/tile090.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P4_I} rectangle ${P2_O},${P4_O} ${P4_I},${P6_I}" ${MASKDIR}/tile091.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P3_I} rectangle ${P2_O},${P3_O} ${P4_I},${P6_I}" ${MASKDIR}/tile092.png

magick convert -alpha off ${MASKDIR}/tile055.png -negate ${MASKDIR}/tile093.png
magick convert -alpha off ${MASKDIR}/tile056.png -negate ${MASKDIR}/tile094.png
magick convert -alpha off ${MASKDIR}/tile057.png -negate ${MASKDIR}/tile095.png
magick convert -alpha off ${MASKDIR}/tile058.png -negate ${MASKDIR}/tile096.png
magick convert -alpha off ${MASKDIR}/tile004.png -negate ${MASKDIR}/tile097.png
magick convert -alpha off ${MASKDIR}/tile059.png -negate ${MASKDIR}/tile098.png
magick convert -alpha off ${MASKDIR}/tile060.png -negate ${MASKDIR}/tile099.png
magick convert -alpha off ${MASKDIR}/tile061.png -negate ${MASKDIR}/tile100.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P0_O},${P0_O} ${P0_O},${P2_I}" ${MASKDIR}/tile101.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P0_O},${P0_O} ${P0_O},${P3_I}" ${MASKDIR}/tile102.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P0_O},${P0_O} ${P0_O},${P4_I}" ${MASKDIR}/tile103.png
magick convert -alpha off ${MASKDIR}/tile044.png -rotate 180 -negate ${MASKDIR}/tile104.png

magick convert -alpha off ${MASKDIR}/tile101.png -negate ${MASKDIR}/tile105.png
magick convert -alpha off ${MASKDIR}/tile102.png -negate ${MASKDIR}/tile106.png
magick convert -alpha off ${MASKDIR}/tile103.png -negate ${MASKDIR}/tile107.png

magick composite -compose Minus ${MASKDIR}/tile103.png ${MASKDIR}/tile101.png ${MASKDIR}/tile108.png
magick convert -alpha off ${MASKDIR}/tile108.png -negate ${MASKDIR}/tile109.png

magick composite -compose Add ${MASKDIR}/tile108.png -rotate 180 ${MASKDIR}/tile108.png ${MASKDIR}/tile110.png
magick convert -alpha off ${MASKDIR}/tile110.png -negate ${MASKDIR}/tile111.png

magick composite -compose Add ${MASKDIR}/tile103.png -rotate 180 ${MASKDIR}/tile103.png ${MASKDIR}/tile112.png
magick convert -alpha off ${MASKDIR}/tile112.png -negate ${MASKDIR}/tile113.png

magick composite -compose Multiply ${MASKDIR}/tile001.png ${MASKDIR}/tile044.png ${MASKDIR}/tile114.png
magick composite -compose Multiply ${MASKDIR}/tile001.png -rotate 270 ${MASKDIR}/tile044.png -rotate 90 ${MASKDIR}/tile115.png

magick composite -compose Multiply ${MASKDIR}/tile003.png -rotate 180 ${MASKDIR}/tile107.png ${MASKDIR}/tile116.png
magick composite -compose Multiply ${MASKDIR}/tile003.png -rotate 90 ${MASKDIR}/tile107.png -rotate 90 ${MASKDIR}/tile117.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} rectangle ${P1_O},${P1_O} ${P2_I},${P5_I}" -fill white -draw "circle ${P1_O},${P1_O} ${P1_O},${P2_I} circle ${P1_O},${P5_I} ${P2_I},${P5_I}" ${MASKDIR}/tile118.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P4_O},${P0_O} ${P6_I},${P1_O}" ${MASKDIR}/tile119.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P2_I} rectangle ${P0_O},${P4_O} ${P1_O},${P6_O}" ${MASKDIR}/tile120.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P2_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I} rectangle ${P4_O},${P0_O} ${P6_I},${P1_O} rectangle ${P5_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile121.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P2_I} rectangle ${P0_O},${P4_O} ${P1_O},${P6_O} rectangle ${P5_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile122.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_I},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile123.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P1_O},${P4_I}" ${MASKDIR}/tile124.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I} rectangle ${P5_I},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile125.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P5_I} rectangle ${P0_O},${P2_O} ${P1_O},${P4_I}" ${MASKDIR}/tile126.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P0_O},${P0_O} ${P6_I},${P1_I} rectangle ${P0_O},${P0_O} ${P1_I},${P6_I}" ${MASKDIR}/tile127.png

magick convert -alpha off ${MASKDIR}/tile028.png -negate ${MASKDIR}/tile128.png

magick composite -compose Multiply ${MASKDIR}/tile003.png ${MASKDIR}/tile128.png ${MASKDIR}/tile129.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P6_I},${P1_I}" ${MASKDIR}/tile130.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P0_O},${P0_O} ${P5_I},${P1_I}" ${MASKDIR}/tile131.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P1_O},${P0_O} ${P5_I},${P1_I}" ${MASKDIR}/tile132.png

magick composite -compose Multiply ${MASKDIR}/tile003.png ${MASKDIR}/tile130.png ${MASKDIR}/tile133.png
magick composite -compose Multiply ${MASKDIR}/tile003.png ${MASKDIR}/tile131.png ${MASKDIR}/tile134.png
magick composite -compose Multiply ${MASKDIR}/tile003.png ${MASKDIR}/tile132.png ${MASKDIR}/tile135.png

magick composite -compose Multiply ${MASKDIR}/tile004.png ${MASKDIR}/tile130.png ${MASKDIR}/tile136.png
magick composite -compose Multiply ${MASKDIR}/tile005.png ${MASKDIR}/tile130.png ${MASKDIR}/tile137.png
magick composite -compose Multiply ${MASKDIR}/tile061.png ${MASKDIR}/tile130.png ${MASKDIR}/tile138.png
magick convert -flop ${MASKDIR}/tile136.png ${MASKDIR}/tile139.png
magick convert -flop ${MASKDIR}/tile137.png ${MASKDIR}/tile140.png
magick convert -flop ${MASKDIR}/tile138.png ${MASKDIR}/tile141.png

magick composite -compose Multiply ${MASKDIR}/tile004.png ${MASKDIR}/tile132.png ${MASKDIR}/tile142.png
magick composite -compose Multiply ${MASKDIR}/tile005.png ${MASKDIR}/tile132.png ${MASKDIR}/tile143.png
magick composite -compose Multiply ${MASKDIR}/tile061.png ${MASKDIR}/tile132.png ${MASKDIR}/tile144.png
magick convert -flop ${MASKDIR}/tile142.png ${MASKDIR}/tile145.png
magick convert -flop ${MASKDIR}/tile143.png ${MASKDIR}/tile146.png
magick convert -flop ${MASKDIR}/tile144.png ${MASKDIR}/tile147.png

FAR_MID="$(($PIXEL_COUNT + $P3_I)).5"
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${FAR_MID},${FAR_MID} ${P1_O},${FAR_MID}" ${MASKDIR}/tile148.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${P3_I}.5,${FAR_MID} ${P3_I}.5,${P1_O}" ${MASKDIR}/tile149.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${P3_I}.5,${FAR_MID} ${P3_I}.5,${P1_O}" ${MASKDIR}/tile149.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${P3_I}.5,${FAR_MID} ${P3_I}.5,${P1_O} rectangle ${P2_O},${P0_O} ${P4_I},${P2_I}" ${MASKDIR}/tile150.png

magick composite -compose Multiply ${MASKDIR}/tile003.png ${MASKDIR}/tile148.png ${MASKDIR}/tile151.png
magick convert -flop ${MASKDIR}/tile151.png ${MASKDIR}/tile152.png
magick composite -compose Multiply ${MASKDIR}/tile006.png ${MASKDIR}/tile148.png ${MASKDIR}/tile153.png

DOUBLE="$(($PIXEL_COUNT * 2 - 1 )).5"
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${DOUBLE},${DOUBLE} ${DOUBLE},${P1_O}" ${MASKDIR}/tile154.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "circle ${P6_I}.5,${DOUBLE} ${P6_I}.5,${P1_O}" ${MASKDIR}/tile155.png
magick convert -flop ${MASKDIR}/tile155.png ${MASKDIR}/tile156.png
magick composite -compose Multiply ${MASKDIR}/tile001.png ${MASKDIR}/tile155.png ${MASKDIR}/tile157.png
magick convert -flop ${MASKDIR}/tile157.png ${MASKDIR}/tile158.png
magick composite -compose Multiply ${MASKDIR}/tile088.png ${MASKDIR}/tile155.png ${MASKDIR}/tile159.png
magick convert -flop ${MASKDIR}/tile159.png ${MASKDIR}/tile160.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P1_I},${P2_O} ${P2_O},${P3_I}" ${MASKDIR}/tile161.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P1_I},${P1_O} ${P2_O},${P2_I}" ${MASKDIR}/tile162.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P1_I},${P2_O} ${P2_O},${P3_I}" ${MASKDIR}/tile163.png
magick convert -flop ${MASKDIR}/tile161.png ${MASKDIR}/tile164.png
magick convert -flop ${MASKDIR}/tile162.png ${MASKDIR}/tile165.png
magick convert -flop ${MASKDIR}/tile163.png ${MASKDIR}/tile166.png
magick composite -compose Multiply ${MASKDIR}/tile161.png ${MASKDIR}/tile164.png ${MASKDIR}/tile167.png
magick composite -compose Multiply ${MASKDIR}/tile162.png ${MASKDIR}/tile165.png ${MASKDIR}/tile168.png
magick composite -compose Multiply ${MASKDIR}/tile163.png ${MASKDIR}/tile166.png ${MASKDIR}/tile169.png
magick composite -compose Multiply ${MASKDIR}/tile161.png -rotate 180 ${MASKDIR}/tile161.png ${MASKDIR}/tile170.png
magick composite -compose Multiply ${MASKDIR}/tile162.png -rotate 180 ${MASKDIR}/tile162.png ${MASKDIR}/tile171.png
magick composite -compose Multiply ${MASKDIR}/tile163.png -rotate 180 ${MASKDIR}/tile163.png ${MASKDIR}/tile172.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P1_I},${P2_O} ${P2_O},${P3_I}" ${MASKDIR}/tile173.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P1_I},${P1_O} ${P2_O},${P2_I}" ${MASKDIR}/tile174.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P1_I},${P2_O} ${P2_O},${P3_I}" ${MASKDIR}/tile175.png
magick convert -flop ${MASKDIR}/tile173.png ${MASKDIR}/tile176.png
magick convert -flop ${MASKDIR}/tile174.png ${MASKDIR}/tile177.png
magick convert -flop ${MASKDIR}/tile175.png ${MASKDIR}/tile178.png
magick composite -compose Multiply ${MASKDIR}/tile173.png ${MASKDIR}/tile176.png ${MASKDIR}/tile179.png
magick composite -compose Multiply ${MASKDIR}/tile174.png ${MASKDIR}/tile177.png ${MASKDIR}/tile180.png
magick composite -compose Multiply ${MASKDIR}/tile175.png ${MASKDIR}/tile178.png ${MASKDIR}/tile181.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P1_I},${P3_O} ${P2_O},${P4_I}" ${MASKDIR}/tile182.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P1_I},${P3_O} ${P2_O},${P4_I}" ${MASKDIR}/tile183.png
magick convert -flop ${MASKDIR}/tile182.png ${MASKDIR}/tile184.png
magick convert -flop ${MASKDIR}/tile183.png ${MASKDIR}/tile185.png
magick composite -compose Multiply ${MASKDIR}/tile182.png ${MASKDIR}/tile184.png ${MASKDIR}/tile186.png
magick composite -compose Multiply ${MASKDIR}/tile183.png ${MASKDIR}/tile185.png ${MASKDIR}/tile187.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I}" ${MASKDIR}/tile188.png
magick convert -flop ${MASKDIR}/tile188.png ${MASKDIR}/tile189.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I}" ${MASKDIR}/tile190.png
magick convert -flop ${MASKDIR}/tile190.png ${MASKDIR}/tile191.png
magick composite -compose Multiply ${MASKDIR}/tile181.png ${MASKDIR}/tile188.png ${MASKDIR}/tile192.png
magick composite -compose Multiply ${MASKDIR}/tile187.png ${MASKDIR}/tile188.png ${MASKDIR}/tile193.png
magick convert -flop ${MASKDIR}/tile192.png ${MASKDIR}/tile194.png
magick convert -flop ${MASKDIR}/tile193.png ${MASKDIR}/tile195.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile196.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P2_O},${P4_O} ${P3_I},${P5_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile197.png
magick convert -flop ${MASKDIR}/tile196.png ${MASKDIR}/tile198.png
magick convert -flop ${MASKDIR}/tile197.png ${MASKDIR}/tile199.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I}" ${MASKDIR}/tile200.png
magick convert -flop ${MASKDIR}/tile200.png ${MASKDIR}/tile201.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile202.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I} rectangle ${P2_O},${P4_O} ${P3_I},${P5_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I}" ${MASKDIR}/tile203.png
magick convert -flop ${MASKDIR}/tile202.png ${MASKDIR}/tile204.png
magick convert -flop ${MASKDIR}/tile203.png ${MASKDIR}/tile205.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I} rectangle ${P3_O},${P4_O} ${P4_I},${P5_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I}" ${MASKDIR}/tile206.png
magick convert -flop ${MASKDIR}/tile206.png ${MASKDIR}/tile207.png

MID2="$((($P1_O + $P2_O) / 2 - 1)).5"
MID5="$((($P4_O + $P5_O) / 2 - 1)).5"
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${MID2},${MID2} ${MID2},${P1_I} circle ${MID5},${MID2} ${MID5},${P1_I} circle ${MID2},${MID5} ${P1_I},${MID5} circle ${MID5},${MID5} ${MID5},${P4_I}" ${MASKDIR}/tile208.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${MID2},${MID2} ${MID2},${P1_I} circle ${MID5},${MID2} ${MID5},${P1_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I}" ${MASKDIR}/tile209.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${MID2},${MID2} ${MID2},${P1_I} circle ${MID5},${MID2} ${MID5},${P1_I} rectangle ${P0_O},${P5_O} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile210.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${MID2},${MID2} ${MID2},${P1_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I} rectangle ${P5_I},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile211.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${MID2},${MID2} ${MID2},${P1_I} rectangle ${P0_O},${P5_I} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I} rectangle ${P5_O},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile212.png
magick convert -flop ${MASKDIR}/tile212.png ${MASKDIR}/tile213.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P1_O},${P4_O} ${P2_I},${P5_I} rectangle ${P4_O},${P4_O} ${P5_I},${P5_I}" ${MASKDIR}/tile214.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P1_O},${P4_O} ${P2_I},${P5_I} rectangle ${P4_O},${P4_O} ${P5_I},${P5_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I}" ${MASKDIR}/tile215.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P1_O},${P4_O} ${P2_I},${P5_I} rectangle ${P4_O},${P4_O} ${P5_I},${P5_I} rectangle ${P0_O},${P5_O} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile216.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P1_O},${P4_O} ${P2_I},${P5_I} rectangle ${P4_O},${P4_O} ${P5_I},${P5_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I} rectangle ${P5_I},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile217.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P1_O},${P4_O} ${P2_I},${P5_I} rectangle ${P4_O},${P4_O} ${P5_I},${P5_I} rectangle ${P0_O},${P5_I} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I} rectangle ${P5_O},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile218.png
magick convert -flop ${MASKDIR}/tile218.png ${MASKDIR}/tile219.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I}" ${MASKDIR}/tile220.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P4_O},${P1_O} ${P5_I},${P2_I} rectangle ${P0_O},${P5_O} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile221.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P0_O},${P5_I} ${P6_I},${P6_I} rectangle ${P5_I},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile222.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P1_O},${P1_O} ${P2_I},${P2_I} rectangle ${P0_O},${P5_I} ${P2_I},${P6_I} rectangle ${P4_O},${P5_O} ${P6_I},${P6_I} rectangle ${P5_O},${P0_O} ${P6_I},${P6_I}" ${MASKDIR}/tile223.png
magick convert -flop ${MASKDIR}/tile223.png ${MASKDIR}/tile224.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I}" ${MASKDIR}/tile225.png
magick convert -flop ${MASKDIR}/tile225.png ${MASKDIR}/tile226.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I}" ${MASKDIR}/tile227.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile228.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I}  rectangle ${P2_O},${P5_O} ${P4_I},${P6_I}" ${MASKDIR}/tile229.png
 
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I}" ${MASKDIR}/tile230.png
magick convert -flop ${MASKDIR}/tile230.png ${MASKDIR}/tile231.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I}" ${MASKDIR}/tile232.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile233.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P5_O},${P1_O} ${P6_I},${P5_I}" ${MASKDIR}/tile234.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P5_O},${P1_O} ${P6_I},${P5_I}" ${MASKDIR}/tile235.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P2_O} ${P6_I},${P4_I}  rectangle ${P1_O},${P5_O} ${P5_I},${P6_I}" ${MASKDIR}/tile236.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I}" ${MASKDIR}/tile237.png
magick convert -flop ${MASKDIR}/tile237.png ${MASKDIR}/tile238.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile239.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P1_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile240.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile241.png
magick convert -flop ${MASKDIR}/tile241.png ${MASKDIR}/tile242.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P1_O} ${P1_I},${P5_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_O},${P1_O} ${P6_I},${P5_I}" ${MASKDIR}/tile243.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I}" ${MASKDIR}/tile244.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile245.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile246.png

magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I}" ${MASKDIR}/tile247.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P5_O},${P1_O} ${P6_I},${P5_I}" ${MASKDIR}/tile248.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P1_O},${P5_O} ${P5_I},${P6_I} rectangle ${P5_O},${P2_O} ${P6_I},${P4_I}" ${MASKDIR}/tile249.png
magick -size ${CANVAS_SIZE} xc:white -fill black -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P4_I} rectangle ${P0_O},${P2_O} ${P2_I},${P4_I} rectangle ${P2_O},${P5_O} ${P4_I},${P6_I} rectangle ${P5_O},${P1_O} ${P6_I},${P5_I}" ${MASKDIR}/tile250.png

magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P6_I} rectangle ${P0_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile251.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P3_I} rectangle ${P0_O},${P5_O} ${P6_I},${P6_I}" ${MASKDIR}/tile252.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "rectangle ${P2_O},${P0_O} ${P4_I},${P2_I} rectangle ${P0_O},${P5_O} ${P6_I},${P6_I} circle ${P3_I}.5,${P2_I}.5 ${P3_I}.5,${P1_O}" ${MASKDIR}/tile253.png
magick convert -alpha off ${MASKDIR}/tile006.png -negate ${MASKDIR}/tile254.png
magick -size ${CANVAS_SIZE} xc:black -fill white -draw "circle ${P3_I}.5,${PIXEL_COUNT}.5 ${P3_I}.5,${P5_O}" ${MASKDIR}/tile255.png
magick composite -compose Screen ${MASKDIR}/tile255.png -rotate 90 ${MASKDIR}/tile255.png -rotate 180 ${MASKDIR}/tile256.png
magick composite -compose Screen ${MASKDIR}/tile256.png -rotate 180 ${MASKDIR}/tile255.png -rotate 90 ${MASKDIR}/tile257.png
magick composite -compose Screen ${MASKDIR}/tile256.png -rotate 180 ${MASKDIR}/tile256.png ${MASKDIR}/tile258.png
magick convert -alpha off ${MASKDIR}/tile003.png -negate ${MASKDIR}/tile259.png
magick convert -alpha off ${MASKDIR}/tile005.png -negate ${MASKDIR}/tile260.png
magick convert -alpha off ${MASKDIR}/tile026.png -negate ${MASKDIR}/tile261.png



if [ "${ROTATE}" == 'true' ]; then
	echo "Making rotated masks, this may take a moment..."
	#rotate - 90, 180, and 270
	PREFIX=tile
	for TILE in 001 002 004 005 007 008 009 011 012 014 016 017 019 020 021 022 023 024 026 027 028 029 030 031 032 033 034 035 036 037 038 039 040 041 042 043 044 045 046 047 048 049 050 051 052 053 054 055 056 057 058 059 060 061 066 070 073 074 076 080 083 084 085 086 087 088 089 090 091 092 093 094 095 096 097 098 099 100 101 102 103 104 105 106 107 108 109 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 209 210 211 212 213 215 216 217 218 219 220 221 222 223 224 225 226 227 229 230 231 232 233 234 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 255 256 257 260 261; do
		FILE=$PREFIX$TILE
		magick convert ${MASKDIR}/${FILE}.png -rotate 90 ${MASKDIR}/${FILE}_r090.png
		magick convert ${MASKDIR}/${FILE}.png -rotate 180 ${MASKDIR}/${FILE}_r180.png
		magick convert ${MASKDIR}/${FILE}.png -rotate 270 ${MASKDIR}/${FILE}_r270.png
	done

	for TILE in 003 010 015 025 065 069 075 079 110 111 112 113 228 235 259; do
		FILE=$PREFIX$TILE
		magick convert ${MASKDIR}/${FILE}.png -rotate 90 ${MASKDIR}/${FILE}_r090.png
	done
fi

echo "... done."
