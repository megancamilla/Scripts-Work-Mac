#! /usr/bin/env python

##Manipulating or modifying lists

## produce a list using the range function: in this case make a list from 0 to 16 by 2
MyList = range(0,16,2)
print MyList

# Element in allows you to perform a function on every element in your list
#### THIS IS REALLY USEFULL it's called List Comprehension


Squares = [Element*2 for Element in MyList]
print Squares

### Even cooler use of the list comprehension is to extract the first codon (or three characters from a list
GeneList = ["ATGGGTACAC", "ATGTGCATGACG","TGTGAAGT", "TGT", "TGTAACACCT"]
FirstCodons = [Seq[0:3] for Seq in GeneList]
print FirstCodons


### add a link to your elements in your list
Linker = "GAATTC"
Start= [(Linker + Seq[0:3]) for Seq in GeneList]
print Start

## count the number of A's in each gene in your list
NumAs= [Seq.count("A") for Seq in GeneList]
print NumAs


## Convert a list of numbers into a list of numbers that are strings
Num= list(range(0,20,2))
print Num

StringNum= [str(N) for N in Num]
print StringNum




#### make a string a list and make a list a string

Mystring="ABCDEFGH"
print Mystring
MyList2 = list(Mystring)
print MyList2

MyList3= ["abc", "de","fgh"]
print MyList3

Joinstring ="".join(MyList3)
print Joinstring

JoinstringTab= "\t".join(MyList3)
print JoinstringTab


