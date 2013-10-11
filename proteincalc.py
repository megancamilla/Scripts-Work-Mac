#! /usr/bin/env python

AminoDict={'A':89.09,
'R':174.20,
'N':132.12,
'D':133.10,
'C':121.15,
'Q':146.15,
'E':147.13,
'G':75.07,
'H':155.16,
'I':131.17,
'L':131.17,
'K':146.19,
'M':149.21,
'F':165.19,
'P':115.13,
'S':105.09,
'T':119.12,
'W':204.23,
'Y':181.19,
'V':117.15,
'X':0.0,
'-':0.0,
'*':0.0
}

ProteinSeq = "FDILSATFTYGNR"

MolWeight =0

for AminoAcid in ProteinSeq:
	MolWeight= AminoDict[AminoAcid] + MolWeight


print "Protein: ", ProteinSeq
print "Molecular Weight:%.1f " % MolWeight

Aminodict.get(AminoAcid, 0.0)
