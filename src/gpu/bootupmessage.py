bootupmsg = """//////////////////////////////////////////////////////////////////////////////
  #####                                               #######   #####          
 #     #  ######  ######   ####   #####   #    #      #     #  #     #         
 #        #       #       #       #    #  #    #      #     #  #               
 #        #####   #####    ####   #    #  #    #      #     #   #####          
 #        #       #            #  #####   #    #      #     #        #         
 #     #  #       #       #    #  #       #    #      #     #  #     #         
  #####   ######  ######   ####   #        ####       #######   #####          
                                                                               
 #     #                                                   ###           ###   
 #     #  ######  #####    ####   #   ####   #    #       #   #         #   #  
 #     #  #       #    #  #       #  #    #  ##   #      #     #       #     # 
 #     #  #####   #    #   ####   #  #    #  # #  #      #     #       #     # 
  #   #   #       #####        #  #  #    #  #  # #      #     #  ###  #     # 
   # #    #       #   #   #    #  #  #    #  #   ##       #   #   ###   #   #  
    #     ######  #    #   ####   #   ####   #    #        ###    ###    ###   
//////////////////////////////////////////////////////////////////////////////
Welcome Cees:"""

print("memory_initialization_radix=16;")
print("memory_initialization_vector=")
row = 0
for line in bootupmsg.splitlines():
	col = [0] * 80
	row += 1
	i = 0
	for c in line:
		col[i] = ord(c)
		i += 1
	for x in range(0,80, 4):
		d = col[x] + (col[x+1] << 8) + (col[x+2] << 16) + (col[x+3] << 24)
		print(format(d, "08X")+',',end='')
	#print(col[x] + col[x+1] << 8 + col[x+2] << 16 + col[x+3] << 24)
	print()
