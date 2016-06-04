#!/usr/bin/env python

import sys
import traceback
import argparse
import os
from subprocess import Popen, PIPE, call
#
# This script copies new Midas datafiles into a CDMS series-number structure
#

def odb(odbcmd, odbkey, val):
	#d = os.environ.copy()
        #d['MIDASSYS'] = '/home1/aroberts/cdms_midas.git'
	#d['MIDAS_EXPTAB'] = 'home1/aroberts/test2_expt/online/exptab'
	#d['MIDAS_ONLINE'] = 'home1/aroberts/test2_expt/online'
	#print d

	if odbcmd == "get":
		command = "odbedit -c 'ls -l \""+ odbkey +"\"'"
		print command

	elif odbcmd == "set":
		command = "odbedit -c 'set \"" + odbkey + "\" \"" + val + "\"'"
          
        elif odbcmd == "test":
		command = "odbedit -c 'ls -v \""+ odbkey +"\"'"

	p = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)#, env=d)
	stdout, stderr = p.communicate()
	print stderr

	return stdout



#the stuff below is so this functionality can be used as a script
########################################################################
if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	parser.add_argument('cmd', choices=['get', 'set', 'test'])
	parser.add_argument('key')
	parser.add_argument('val', nargs='*')

	args = parser.parse_args()
	print args
	print odb(args.cmd, args.key, args.val)




