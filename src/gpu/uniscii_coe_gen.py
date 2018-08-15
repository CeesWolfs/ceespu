with open("uniscii.hex" , 'r') as f:
    lines = f.readlines() # readlines creates a list of the lines
lines = [ line[5:] for line in lines]
print("memory_initialization_radix=16;")
print("memory_initialization_vector=")
for line in lines:
	print(line[:8] + ',' + line[8:16] + ',' + line[16:24] + ',' + line[24:32] + ',')