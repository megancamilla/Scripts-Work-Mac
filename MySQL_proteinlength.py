#!/usr/bin/env python

#  MySQLquery.py
#  
#
#  Created by Megan McDonald on 30/01/13.
#

""" Using the mysqldb module, extract all the proteins from the Pnodorum_V3_JGI database that are less than 200 aa in length. Extract the Scaffold number, SNOG, Start Position, and Strand from the table GeneCatalog to use for downstream modification to get the upstream UTR region  """

import re
import MySQLdb

# Create variable to hold the database connection
Connection = MySQLdb.connect(host= "localhost", user = "root", passwd = "", \
db= "Ztritici_IPO323")

MyCursor = Connection.cursor()
SQL= """select Genes.Transcript_ID, Genes.Prediction_ID, GeneCatalog.StartPos, GeneCatalog.StopPos,GeneCatalog.Strand
 	FROM GeneCatalog, CDS 
	WHERE Genecatalog.DNAtype ="start_codon" and CDS.SNOG=GeneCatalog.CDS_SNOG and CHAR_LENGTH(CDS.ProteinSeq)<=250
	LIMIT 13000;"""

SQLLen = MyCursor.execute(SQL)

AllOut = MyCursor.fetchall()
print SQLLen

Connection.close()
MyCursor.close()
print "FINISHED!"