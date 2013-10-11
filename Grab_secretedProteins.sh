#!/bin/bash

#  Grab_secretedProteins.sh
#  
#
#  Created by Megan McDonald on 5/02/13.
#
#### Use the shell to grab secreted proteins froma tab delimited excel file

grep "Signal peptide" -i Pnodorum_Expressiondata.txt  > secreted_proteins.txt