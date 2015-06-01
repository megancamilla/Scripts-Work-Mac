#!/usr/bin/env python

#  Get_Sprotein_mysql.py
#  
#
#  Created by Megan McDonald on 4/07/2014.
#
import re
import MySQLdb


MyConnection= MySQLdb.connect(host ="localhost", user="meganm", passwd="pnodoruma27", db="Ztritici_resequencing")
MyCursor = MyConnection.cursor()
SQL = """SELECT gene_id_numeric, gene_id_name, protein_seq FROM `Ztritici_resequencing`.`Genes_IPO323` WHERE CHAR_LENGTH(protein_seq)<=250;"""
SQLLen= MyCursor.execute(SQL)


AllOut= MyCursor.fetchall()
OutFileName="250AA_orLess.names.txt"
OutFile=open(OutFileName, 'w')


for Index in range(SQLLen):
    Gene_name= AllOut[Index][1]
    Gene_id = AllOut[Index][0]
    protein_seq= AllOut[Index][2]
    outline= "%s\t%d\t%s\n" % (Gene_name, Gene_id, protein_seq)
    OutFile.write(outline)



MyCursor.close
MyConnection.close
OutFile.close
