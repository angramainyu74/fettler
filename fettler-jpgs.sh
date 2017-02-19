#!/bin/bash
##Convert a directory of pngs to jpgs

##In the future you'll probably be able to specify these as 
##command-line arguments and/or use already-set environment variables

##Directory to read from
TILEDIR=output

##Directory to write jpgs to
JPGDIR=output_jpg


##The rest is calculated automatically

##------------------------------------

mkdir -p ${JPGDIR}

echo "Converting files, this may take a moment..."

for FILE in ${TILEDIR}/*.png; do
	magick convert "${TILEDIR}/$(basename "$FILE")" "${JPGDIR}/$(basename "$FILE" png)jpg"
done

echo "... done."
