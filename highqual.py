infile = open("/Users/meganm/DNAdata/DNAsample.txt")

record = []

for line in infile:
    if line.startswith['@'] and record != []:
    seq = record[1]
    print seq
    print "yeah"

infile.close()
