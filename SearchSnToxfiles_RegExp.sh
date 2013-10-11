#! /usr/bin/env python
#  SearchSnToxfiles_RegExp.sh
#  
#
#  Created by Megan McDonald on 6/02/13.
#
### Purpose of this script is to search SnTox1, SnToxA and SnTox3 with regular #expression motifs. Grab only the line that contain the motif and print a #statement whether that file contains all three toxins

import re, sys

