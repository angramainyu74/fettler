Fettler v1.2
A free dungeon tile set generator

"Magic is impressive, but now Minsc leads. Free tiles for everyone!"

---------------------------------------------------------------------
Created by Alex Wilson
@400goblins
https://400goblins.blogspot.com
https://github.com/angramainyu74/fettler

This software is released under CC0 "No Rights Reserved" license.
https://creativecommons.org/share-your-work/public-domain/cc0/

If you like it and use it, attribution is appreciated, but optional.

This software comes without any warranty, to the extent permitted by
applicable law.
---------------------------------------------------------------------


Overview
========
Fettler is a series of bash scripts. It can apply a grid to a floor
and wall texture using a tile "mask" to easily create useful tiles
for Roll20, other VTT systems, or where-ever you can make use of
modular tile geomorphs. It has the ability to generate a large number
of pre-defined masks for you, as well as some grids.

Once you have masks, textures, and a grid, you just need to run the
script to generate a full set of tiles.

My hope is that these script make building and re-skinning a tile
library much easier tasks.  If you make cool tile sets (and the
textures allow it), share them with others!  If you make new masks,
share them too!  If you add to the mask script, share it and let me
know so I can include more masks in future updates!


Requirements
============
-Windows with Cygwin (tested), or anything with Bash (other platforms
 untested) https://www.cygwin.com/
-ImageMagick http://www.imagemagick.org/


Installation
============
Unzip and untar.
Check that you have ImageMagick set up correctly. From Bash, the 
command:
 magick convert logo: logo.png
should produce the logo.png file. If it does not, Fettler scripts
will not work.
Personally, I found it easier to get the Win64 non-Cygwin build of
ImageMagick working correctly with Cygwin.


Usage
=====
From a Bash prompt, you should cd into the directory Fettler is
installed in. Here's how to use them:

setenv.sh
---------
This is optional, but included for convenience  if you need something
to set your PATH to include ImageMagick if it's not there already.
Edit to point to your ImageMagick path, and source with:
 . ./setenv.sh

fettler-grids.sh
----------------
Creates a set of overlay grids. When used, the overlay will appear
on the floor, but not the wall. You can just run it:
 ./fettler-grids.sh
and it will generate a bunch of grid files and put them in the
"grids" sub-directory.

fettler-masks.sh
----------------
Creates a set of tile masks, white for walls, black for floor.
Edit the script if you want to change whether it outputs rotated
versions - many seamless tiles won't still tile when rotated, so
having rotated masks will generate extra, already rotated versions of
tiles that need it. Run with:
 ./fettler-masks.sh
and it will generate a bunch of masks files and put them in the
"masks" sub-directory.

fettler-tiles.sh
----------------
Applies a grid to a set of masks, using a wall and floor texture.
You will want to edit this to set the textures you want, as well
as a few other options. Once you've set what you want, run:
 ./fettler-tiles.sh
and it will create a tile file for every mask file and put them in 
the "output" sub-directory.

fettler-jpgs.sh
---------------
Converts a directory of pngs to jpgs. This is optional, but if you
want more compressed version of the tiles, this will mass convert
them. Run:
 ./fettler-jpgs.sh
and it will convert all the pngs in "output" and put all of them
them into the "output_jpg" sub-directory.

fettler-map.sh
--------------
Creates a map by adding a tile to a map image.
Arguments: <mapfilepath> <x> <y> <maptilepath> 
-if mapfilepath does not exist, will create a map of size x and y
 with maptilepath (x and y as number of tiles) 
-if mapfilepath does exist, will add maptilepath at position x and y
 (0-indexed)
See sample-map.sh for an example script that builds a map out of 
tiles.


Known issues
============
-Sometime ImageMagick (at least the Win64 build I have) hangs
trying to process jpgs when loading textures. Converting the jpgs
to pngs solves the issue.


Possible future plans
=====================
-Move some of the options to env. variables and/or command-line
 options, so scripts don't need to be edited directly.
-Add a "liquid" layer, another layer mask that applies a texture
 between the floor and wall layers, for making sewers, lava channels,
 etc.
-Add option for using single larger map-sized mask for making a
 single map file.
-Expand built-in support to options other than 6x6
-Windows batch file support, and/or some other more cross-platform
 support, like Python.
-Some sort of "decoration" support for doors, etc.
-... other suggestions?


Other useful commands
=====================
You can use ImageMagick to make thumbnail sheets of your masks for 
easy reference:
 magick montage -pointsize 10 -label '%t' 'masks/*.png' -geometry 60x60+2+2 -tile 10x10 -background gray50 tiles_%d.png
Or a single giant thumbnail sheet:
 magick montage -pointsize 10 -label '%t' 'masks/*.png' -geometry 60x60+2+2 -tile 30x -background gray50 tiles.png


Resources
=========
Check Twitter and my blog for updates!
@400goblins
https://400goblins.blogspot.com

Some sources for seamless tileable textures:
http://opengameart.org/content/100-seamless-textures
http://www.swtexture.com/
http://duion.com/art/textures
http://www.deviantart.com/browse/all/?section=&global=1&q=seamless+tile&offset=0
and doctorfree's mkseamless.sh:
https://github.com/doctorfree/Scripts


Changelog
=========
v1.2
-fettle-map-single.sh will apply tiled walls and floors to a single larger
 mask image -- you can use this to make/edit a map as single mask, then
 texture it.
-added some initial python-based tools for random map generation -- Further
 cleanup and documentation forthcoming.

v1.1
-add fettler-map.sh and sample-map.sh
-fix edge of soft grid overlays (you could see the edge of tile that
 used a soft box)
-added my hatch.png and some solid colour texture files to the repo

v1.0
-Initial release