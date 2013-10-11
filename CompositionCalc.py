#! /usr/bin/env python

DNASeq = raw_input("Enter a Sequence or Amino Acid:")
DNASeq = DNASeq.upper()

Seqlength = float(len(DNASeq))

BaseList= list(set(DNASeq))

for Base in BaseList:
	Percent = 100* DNASeq.count(Base)/Seqlength
	print "%s: %4.1f" % (Base, Percent)