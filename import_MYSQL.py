#! /usr/bin/env python
"""Import script for Parsing and preparing input files for MySQL database"""

import re
import sys
import MySQLdb

## Read in the infile
INFILENAME="/Users/meganm/Genomes/MySQL_inputfiles/IPO323input_sept2013.txt"
IPOIN= open(INFILENAME, 'r')


## Establish connection with MySQL
MyConnection = MySQLdb.connect( host = "RSB000291.local", user = "root", passwd= "", db= "Ztritici_resequencing")
MyCursor = MyConnection.cursor()

## Populate Ztritici_resequencing.IPO323 table
for Line in IPOIN:
    Line = Line.strip('\n')
    ElementList  = Line.split('\t')
    ### returns a list with the elements separated by tabs
    sampleid=ElementList[0]
    alt_name=ElementList[1]
    year=int(ElementList[2])
    location_sampled=ElementList[3]
    sample_by=ElementList[4]
    
    SQL = """ INSERT INTO IPO323 SET
    Sample_ID='%s',
    Alternate_name='%s',
    Year_Sampled='%d',
    Location_Sampled='%s',
    Sampled_by='%s';
    """ % (sampleid, alt_name, year, location_sampled, sample_by)
    print SQL
    MyCursor.execute(SQL)

IPOIN.close()
MyCursor.close()
MyConnection.close()
    

