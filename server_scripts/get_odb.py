#!/usr/bin/env python

import sys
import traceback
from subprocess import Popen, PIPE, call
#
# This script copies new Midas datafiles into a CDMS series-number structure
#

def getodb(odbkey):
	command = "odbedit -c 'ls -l \""+ odbkey +"\"'"

	p = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)
	stdout, stderr = p.communicate()

	return stdout


def setodb(odbkey, val):
	command = "odbedit -c 'set \"" + odbkey + "\" \"" + val + "\"'"

	p = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)
	stdout, stderr = p.communicate()

	return stdout

def loadodb(odbkey):
	command = "odbedit -c 'ls -v \""+ odbkey +"\"'"

	p = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)
	stdout, stderr = p.communicate()

	return stdout


#the stuff below is so this functionality can be used as a script
########################################################################
if __name__ == "__main__":
	key = sys.argv[1]    
	print getodb(key)




