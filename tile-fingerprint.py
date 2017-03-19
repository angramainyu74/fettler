#!/usr/bin/python
import png
import sys
from collections import Counter
import glob
import json

threshold = 0.75 #percentage of black pixels to consider a block to be black
squares_per_side = 6
blocks_per_square_side = 11
discard_thresh = 1.8 # 1.8 or so to exclude iffy edges, down to around 1.0 to include more

# ===========
blocks_per_image_side = squares_per_side * blocks_per_square_side

def fill(data, start_coords, fill, orig):
	if fill == orig:
		return
	dx = [ 0,  1, 1, 1, 0, -1, -1, -1]
	dy = [-1, -1, 0, 1, 1,  1,  0, -1]
	xsize = len(data)
	ysize = len(data[0])
	
	stack = set(((start_coords[0], start_coords[1]),))

	while stack:
		x, y = stack.pop()

		data[x][y] = fill
		for i in range(8):
			nx = x + dx[i]
			ny = y + dy[i]
			if nx >= 0 and nx < xsize and ny >=0 and ny < ysize and data[nx][ny] == orig:
				stack.add((nx, ny))

def getfingerprint(filepath):
	r=png.Reader(open(filepath,'r'))
	block_matrix = [[0 for x in range(blocks_per_image_side)] for y in range(blocks_per_image_side)]

	img = r.read()

	img_x = img[0]
	img_y = img[1] 
	img_data = img[2]
	img_info = img[3]

#	print (img_info)

	if not img_info['greyscale']:
		print(filepath,'is not greyscale')
		sys.exit()

	if img_info['planes']>1:
		print(filepath,'is not flat')
		sys.exit()

	if img_info['alpha']:
		print(filepath,'has alpha')
		sys.exit()

	img_bitdepth = img_info['bitdepth']
	#white = 2 ** img_bitdepth - 1

	pixels_per_block = img_x / blocks_per_image_side

	for i in range (0, blocks_per_image_side):
		for j in range (0, blocks_per_image_side):
			bx = i * img_x / blocks_per_image_side
			by = j * img_y / blocks_per_image_side
			black_blocks = 0
			for y in range( by, by + pixels_per_block ):
				row = img_data[y]
				for x in range( bx, bx + pixels_per_block ):
					if row[x] == 0:
						black_blocks+=1
			if black_blocks/(pixels_per_block*pixels_per_block) > threshold:
				block_matrix[i][j] = -1
			else:
				block_matrix[i][j] = 0

#	print block_matrix

	fillnum = 1
	for b in range (0, blocks_per_image_side):
		if block_matrix[b][0] is -1:
			fill(block_matrix,(b,0),fillnum,-1)
			fillnum+=1
		if block_matrix[blocks_per_image_side - 1][b] is -1:
			fill(block_matrix,(blocks_per_image_side - 1,b),fillnum,-1)
			fillnum+=1
		if block_matrix[b][blocks_per_image_side - 1] is -1:
			fill(block_matrix,(b,blocks_per_image_side - 1),fillnum,-1)
			fillnum+=1
		if block_matrix[0][b] is -1:
			fill(block_matrix,(0,b),fillnum,-1)
			fillnum+=1

	edge = [[0 for x in range(blocks_per_image_side)] for y in range(4)]

	#clockwise for sides, but always left-to-right or top-to-bottom
	for b in range (0, blocks_per_image_side):
		edge[0][b] = block_matrix[b][0]
		edge[1][b] = block_matrix[blocks_per_image_side - 1][b]
		edge[2][b] = block_matrix[b][blocks_per_image_side - 1]
		edge[3][b] = block_matrix[0][b]

#	print edge

	fingerprint =''
	for a in range (0, 4):
		for b in range (0, squares_per_side):
				data =  Counter(edge[a][b*blocks_per_square_side:b*blocks_per_square_side+blocks_per_square_side])
				if len(data.most_common(1)[0]) is 0 or 2*data.most_common(1)[0][1] <= blocks_per_square_side*discard_thresh:
					print filepath,': edge on side',a,'square',b,'is ambiguous, perhaps increase blocks? Tile will not be included.', edge[a][b*blocks_per_square_side:b*blocks_per_square_side+blocks_per_square_side]
					mode = 'X'
				else:
					mode = data.most_common(1)[0][0]
	#				print 'edge on side',a,'square',b,'is',mode
				fingerprint=fingerprint+str(mode)

	return fingerprint

#print getfingerprint('masks/tile001.png')
#print getfingerprint('masks/tile001_r270.png')
#files=glob.glob("masks/tile11*.png")
files=glob.glob("masks/tile*.png")
fpdb = {}
for f in files:
	fp=getfingerprint(f)
	if 'X' not in fp:
		fpdb[f]=fp
with open('fingerprints.json','w') as of:
	of.write(json.dumps(fpdb, sort_keys=True,encoding="utf-8"))
	of.close()