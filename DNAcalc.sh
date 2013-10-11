#! /usr/bin/env python

DNASeq = "ATGTCTCAAGCA"

#DNASeq= raw_input("Enter a DNA sequence:")
DNASeq= DNASeq.upper()
DNASeq= DNASeq.replace(" ","")

print "Input Sequence:", DNASeq

SeqLength = float(len(DNASeq))

print "Input Sequence Length: %d"% SeqLength

BaseList = "ATCG"


for Base in BaseList:
	NumberBase = DNASeq.count(Base)
	Percent = DNASeq.count(Base) *100 / SeqLength
	print "Percent %s: %.1f : Total %s = %d" % (Base, Percent,Base, NumberBase)

#Everything below is the bad way to write this program
		##NumberA = DNASeq.count('A')
		##NumberC = DNASeq.count("C")
		##NumberT = DNASeq.count("T")
		###NumberG = DNASeq.count("G")

		#print "Percent A: %.1f" % (100* NumberA/SeqLength)
		#print "Percent C: %.1f" % (100* NumberC/SeqLength)
		#print "Percent T: %.1f" % (100* NumberT/SeqLength)
		#print "Percent G: %.1f" % (100* NumberG/SeqLength)

#TotalStrong =  NumberG + NumberC
#TotalWeak = NumberA+ NumberT

#if SeqLength >= 14:
# formula for sequences that are 14 or more nucleotides
#	MeltTempLong= 64.9 + 41 * (TotalStrong -16.4) /SeqLength
#	print "Tm Long (>14bp): %.1f C" % (MeltTempLong)
#else:
#	MeltTemp = (4*TotalStrong) + (2* TotalWeak)
#	print "Melting Temp: %.f C" % (MeltTemp)


#print "There are %d A bases." %(NumberA)
#print "A occurs in %d bases out of %d." % (NumberA, SeqLength)
#print "A occurs in %.2f of %d bases." % (NumberA/SeqLength, SeqLength)

