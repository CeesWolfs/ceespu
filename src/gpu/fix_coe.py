with open("glyph.coe" , 'r') as f:
    lines = f.readlines() # readlines creates a list of the lines
print(lines[0], end='')
print(lines[1], end='')
for x in range(2, len(lines), 4):
	val = lines[x][:-1].replace(',', '') + lines[x+1][:-1].replace(',', '') + lines[x+2][:-1].replace(',', '') + lines[x+3][:-1].replace(',', '')
	print(val[::-1] + ',')