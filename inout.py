infile = open("/Users/meganm/DNAdata/sample.txt")

count = 0

for line in infile:
	print line
	count = count +1
	print type(line), line
print count

infile.close()
