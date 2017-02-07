#!/usr/bin/python

import sys
import os.path

if (len(sys.argv) != 3):
	print 'Incorrect number of arguments'
	print "Try 'glbcpy --help' for more information."
	sys.exit(1)

src = sys.argv[1]
dst = sys.argv[2]

if (not os.path.isdir(src)):
	print 'source folder is not a valid path'
	sys.exit(1)

if (not os.path.isdir(dst)):
	print 'destination folder is not a valid path'
	sys.exit(1)

question = "Are you sure you want to copy files from" + src + "to" + dst + "? (Y/n)" + "\n"
conf = raw_input(question)

if (conf != "Y" and conf != "y"):
	sys.exit(1)

print 'OK Copying!'

