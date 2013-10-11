#! /usr/bin/env python

##Set the input file name
#make sure you run the program from within the directory that contins our input file

InFileName = "Marrus_Claudanielis.txt"

InFile = open(InFileName, 'r')
print InFile
## Initialize the counter used to count the number of lines in the file

LineNumber = 0

### Open the output file for writing
###Doo this BEFORE the loop, not inside it

OutFileName= InFileName + ".kml"
OutFile= open(OutFileName, "w") ## choose 'a' instead to append to the file i.e. if Outfile already existed in that directory


## Loop through each line in the file

for Line in InFile:
	if LineNumber >0:
		#remove line ending characters
		Line = Line.strip('\n')
		#print the line
		ElementList= Line.split("\t")
		## REPLACED WITH WRITE   print "Depth: %s\tLat: %s\tLong: %s" %(ElementList[4], ElementList[2],ElementList[3])
		OutputString = "Depth: %s\tLat: %s\tLong: %s" %(ElementList[4], ElementList[2],ElementList[3])
		print OutputString
		OutFile.write(OutputString + "\n")
		#increment your counter by 1 NOTE It is important to do this AFTER you print!!!
	LineNumber = LineNumber +1
	
InFile.close()
OutFile.close()