#!/usr/bin/python
import sys
import json
import random
import time

squares_per_side = 6
mapx = 9
mapy = 6
timeout = 5
connector_bias = 0.99 # chance to favour selecting tiles that have more connections, 0.0 for no bias

#-------
tile_total=mapx*mapy
if connector_bias > 0.0:
	timeout *= 4

random.seed()

with open('fingerprints.json','r') as f:
	fingerprints=json.load(f)
	f.close()

tilelist=fingerprints.keys()

def getedge( tile, edge):
	offset = squares_per_side * edge
	if tile == 'edge':
		return '000000' #todo: fixme for any size
	return fingerprints[tile][offset:offset+squares_per_side]

def compareedges( e1, e2):
#	print 'comparing',e1, e2
	for i in range(len(e1)):
#		print e1[i],e2[i]
		if ( int(e1[i]) == 0 and int(e2[i]) > 0 ) or ( int( e1[i] ) > 0 and int( e2[i] ) == 0 ):
			return False
	return True

def checkedge( tile, tile_edge, x, y, map_edge ):
	e1 = getedge( tile, tile_edge)
	if x<0 or x>=mapx or y<0 or y>=mapy:
		map_tile = 'edge'
	else:
		map_tile = map[y][x]
		if map_tile == 0:
			return True
	e2 = getedge( map_tile, map_edge)	
	return compareedges( e1, e2 )

def isvalidplacement( tile, x, y ):
	r = checkedge( tile, 0, x, y-1, 2 ) and checkedge( tile, 1, x+1, y, 3 ) and checkedge( tile, 2, x, y+1, 0 ) and checkedge( tile, 3, x-1, y, 1 )
	return r

def getrandtilelist(tl):
	if connector_bias == 0.0:
		rtl = list(tl)
		random.shuffle(rtl)
		return rtl
	else:
		ttl = list(tl)
		rtl = list()
		random.shuffle(ttl)
		while ttl:
			t=ttl.pop()
			f=fingerprints[t]
			c = 0.0
			for i in range(4):
				c += len( ''.join(set(getedge(t,i).replace('0',''))) )
			if len( ''.join(set(fingerprints[t].replace('0',''))) ) <= c:
				c *= 0.5
			if random.random() > connector_bias and c <=2.0:
				rtl.insert(0,t)
			else:
				rtl.append(t)
		return rtl

def placetile( tile, coord_idx ):
	if int(time.time())>starttime+timeout:
		return False
	global maxreacheddepth
	if coord_idx > maxreacheddepth:
#		print coord_idx,'/',tile_total
		maxreacheddepth = coord_idx
	x = coords[coord_idx][0]
	y = coords[coord_idx][1]
	if not isvalidplacement( tile, x, y ):
		return False
#	print 'Adding',tile,'to',x,y
	map[y][x]=tile
	if tile_total == ( coord_idx + 1 ):
		return True
	r_tilelist = getrandtilelist(tilelist)
	while r_tilelist:
		t = r_tilelist.pop()
		if placetile( t, coord_idx + 1 ):
			return True
		if int(time.time())>starttime+timeout:
			return False
#	print 'Removing',map[y][x],'from',x,y
	map[y][x]=0
#	print map
#	print 'unwinding',coord_idx,x,y,tile
	return False

coords = []

def coord_scanline(coords):
	#scan-line coordinates
	for y in range(mapy):
		for x in range(mapx):
			coords.append((x,y))
	#don't do this, turns out it is a really bad idea
	#random.shuffle(coords)
	return coords

def coord_diagonal(coords):
	#diagonal fill, starting in top-left corner
	total = 0
	while total <= (mapx + mapy - 2):
		y = min( mapy - 1, total )
		x = total - y
	#	print 'total',total
		while x <= (mapx-1) and y >= 0:
	#		print 'adding',x,y
			coords.append((x,y))
			x += 1
			y -= 1
		total += 1
	return coords

def coord_snake(coords):
	#scan-line coordinates
	for y in range(mapy):
		for x in range(mapx):
			if y % 2 is 0:
				a=x
			else:
				a=mapx-x-1
			coords.append((x,y))
	return coords
	
#pick one:
#coords = coord_scanline(coords)
#coords = coord_diagonal(coords)
coords = coord_snake(coords)

#even chance of reversing the order, because why not
if random.random() > 0.5:
	coords.reverse()

#sys.exit(1)


starttime=int(time.time())
map = [[0 for x in range(mapx)] for y in range(mapy)]

def print1():
	print '#!/bin/bash'
	print 'PREFIX=hatch_'
	print 'TILEDIR=output'
	print 'MAP=random-map.png'
	print 'if [ -f ${MAP} ]; then'
	print '	 rm ${MAP}'
	print 'fi'
	print './fettler-map.sh ${MAP} '+str(mapx)+' '+str(mapy)+' ${TILEDIR}/${PREFIX}tile_wall.png'
	for y in range(mapy):
		for x in range(mapx):
			if map[y][x] == 0:
				print ''
			else:
				print './fettler-map.sh ${MAP} '+str(x)+' '+str(y)+' ${TILEDIR}/${PREFIX}'+map[y][x].replace('masks/','')

def print2():
	outlist = ''
	for y in range(mapy):
		for x in range(mapx):
#			outlist += map[y][x]+' '
			outlist += map[y][x].replace('masks/tile','${T}')+' '
	print "T='masks/tile' bash -c 'magick montage "+outlist+"-geometry +0+0 -tile "+str(mapx)+"x"+str(mapy)+" random-map.png'"

#todo: add 	'magick montage @filelist.txt ' version
#def print3():

r_tilelist = list(tilelist)
random.shuffle(r_tilelist)
maxreacheddepth = 0
while r_tilelist:
	done = placetile( r_tilelist.pop(), 0 )
	if done:
		print2()
		break
	if int(time.time())>=starttime+timeout:
#		print1()
#		sys.exit(1)
		map = [[0 for x in range(mapx)] for y in range(mapy)]
		random.shuffle(r_tilelist)
#		print "resetting...",maxreacheddepth
		maxreacheddepth = 0
		starttime=int(time.time())

