#!/bin/bash

export MIDASSYS=/home1/aroberts/cdms_midas.git
export MIDAS_EXPTAB=$HOME/test_expt/online/exptab
export MIDAS_ONLINE=$HOME/test_expt/online

/home1/aroberts/exhttpd.git/server_scripts/odb.py $@

