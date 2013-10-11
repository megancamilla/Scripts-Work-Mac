infile = open("/Users/meganm/DNAdata/pel_1-small.txt")

count = 0

for line in infile:
	if line.startswith("@"):
	  count = count +1
print count

infile.close()
